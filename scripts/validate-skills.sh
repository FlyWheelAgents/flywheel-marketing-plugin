#!/usr/bin/env bash
# Frontmatter and naming checks for skills/ and agents/.
# Run from the repo root. CI runs this plus `claude plugin validate .`.
set -euo pipefail

fail=0
err() { echo "FAIL: $1"; fail=1; }

# --- Skills: skills/<dir>/SKILL.md, frontmatter name matches dir ---
for dir in skills/*/; do
  name="$(basename "$dir")"
  f="$dir/SKILL.md"
  [ -f "$f" ] || { err "$dir has no SKILL.md"; continue; }
  head -1 "$f" | grep -q '^---$' || err "$f missing frontmatter opening ---"
  fm_name="$(awk '/^---$/{n++;next} n==1 && /^name:/{print $2; exit}' "$f")"
  [ "$fm_name" = "$name" ] || err "$f frontmatter name '$fm_name' != directory '$name'"
  awk '/^---$/{n++;next} n==1 && /^description:/{found=1} END{exit !found}' "$f" \
    || err "$f missing description in frontmatter"
done

# --- Agents: agents/<name>.md, frontmatter name matches filename ---
for f in agents/*.md; do
  name="$(basename "$f" .md)"
  head -1 "$f" | grep -q '^---$' || err "$f missing frontmatter opening ---"
  fm_name="$(awk '/^---$/{n++;next} n==1 && /^name:/{print $2; exit}' "$f")"
  [ "$fm_name" = "$name" ] || err "$f frontmatter name '$fm_name' != filename '$name'"
  awk '/^---$/{n++;next} n==1 && /^description:/{found=1} END{exit !found}' "$f" \
    || err "$f missing description in frontmatter"
done

# --- Style tells in outward-facing prose (skills, agents, README) ---
# Banned vocabulary. The brand-voice template and CONTRIBUTING enumerate the
# banned list itself, so they're excluded.
banned='seamless|robust solution|game-chang|supercharg|turbocharg|cutting-edge|revolutioniz|next-generation|AI revolution|AI-driven|best-in-class|end-to-end solution'
if grep -rniE "$banned" skills agents README.md ACKNOWLEDGEMENTS.md 2>/dev/null \
  | grep -v 'skills/get-started/templates/brand-voice.md'; then
  err "banned phrase found (see matches above)"
fi

# --- MCP tool-name references must exist on the live connector ---
# Keep in sync with the connector's tool registry.
known_tools="getting_started connections_list connect_service connection_revoke audit_query \
assets_list asset_upload_begin asset_upload_commit \
reddit_ad_accounts_list reddit_ad_account_funding reddit_campaigns_list reddit_ad_groups_list \
reddit_ads_list reddit_stats reddit_creative_status reddit_campaign_create reddit_campaign_update \
reddit_ad_group_create reddit_ad_group_update reddit_ad_create reddit_ad_update reddit_creative_create \
google_accounts_list google_campaigns_list google_ad_groups_list google_ads_list google_targeting_list \
google_stats google_geo_target_resolve google_campaign_create google_campaign_update \
google_ad_group_create google_ad_group_update google_ad_create google_ad_update google_keyword_add google_targeting_set \
meta_accounts_list meta_campaigns_list meta_ad_sets_list meta_ads_list meta_creatives_list meta_stats \
meta_targeting_search meta_video_status meta_enhancement_features meta_campaign_create meta_campaign_update \
meta_ad_set_create meta_ad_set_update meta_creative_upload meta_creative_create meta_ad_create meta_ad_update"
# Non-tool identifiers that share the prefix families (parameter names,
# service keys) — not errors.
not_tools="google_ads asset_id"
referenced=$(grep -rhoE '\b(reddit|google|meta|asset|audit|connect|connections|getting)_[a-z_]+\b' skills agents 2>/dev/null | sort -u)
for t in $referenced; do
  echo "$not_tools" | tr ' ' '\n' | grep -qx "$t" && continue
  echo "$known_tools" | tr ' ' '\n' | grep -qx "$t" || err "unknown connector tool referenced: $t"
done

if [ "$fail" -eq 0 ]; then
  echo "OK: $(ls -d skills/*/ | wc -l | tr -d ' ') skills, $(ls agents/*.md 2>/dev/null | wc -l | tr -d ' ') agents validated"
fi
exit "$fail"
