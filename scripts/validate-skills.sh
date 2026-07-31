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
# Keep in sync with the connector's tool registry. Regenerate with:
#   grep -rhoE '^\s+name: "[a-z_]+"' <connector>/src/mcp/tools/*.ts <connector>/src/mcp/tools/*/*.ts \
#     | sed -E 's/.*"(.*)"/\1/' | sort -u
# NOTE: the "referenced" regex below only scans reddit|google|meta|asset|audit|
# connect|connections|getting prefixes, so tiktok_* and x_* references are NOT
# validated today. Their names are listed above so the regex can be widened safely.
known_tools="asset_upload_begin asset_upload_commit assets_list audit_query book_intro_call connect_service \
connection_revoke connections_list context_get context_save getting_started guided_workflow \
intro_call_slots \
reddit_ad_account_funding reddit_ad_accounts_list reddit_ad_create reddit_ad_group_create \
reddit_ad_group_update reddit_ad_groups_list reddit_ad_update reddit_ads_list \
reddit_audience_create reddit_audience_users_update reddit_audiences_list reddit_campaign_create \
reddit_campaign_update reddit_campaigns_list reddit_creative_create reddit_creative_status \
reddit_pixels_list reddit_stats \
google_accounts_list google_ad_create google_ad_group_audience_set \
google_ad_group_audiences_list google_ad_group_create google_ad_group_update \
google_ad_groups_list google_ad_update google_ads_list google_asset_link_set \
google_asset_links_list google_assets_list google_audience_create google_audiences_list \
google_callout_create google_campaign_create google_campaign_update google_campaigns_list \
google_geo_target_resolve google_keyword_add google_sitelink_create google_stats \
google_structured_snippet_create google_targeting_list google_targeting_set \
meta_accounts_list meta_ad_create meta_ad_set_create meta_ad_set_update meta_ad_sets_list \
meta_ad_update meta_ads_list meta_audience_create meta_audience_users_update meta_audiences_list \
meta_campaign_create meta_campaign_update meta_campaigns_list meta_creative_create \
meta_creative_upload meta_creatives_list meta_enhancement_features meta_stats \
meta_targeting_search meta_video_status \
tiktok_accounts_list tiktok_ad_create tiktok_ad_group_create tiktok_ad_group_status \
tiktok_ad_group_update tiktok_ad_groups_list tiktok_ad_update tiktok_ads_list \
tiktok_audiences_list tiktok_campaign_create tiktok_campaign_status tiktok_campaign_update \
tiktok_campaigns_list tiktok_identities_list tiktok_identity_create tiktok_image_upload \
tiktok_spark_ad_create tiktok_stats tiktok_video_status tiktok_video_upload \
x_accounts_list x_audiences_list x_campaign_create x_campaign_status x_campaign_update \
x_campaigns_list x_card_create x_funding_instruments_list x_line_item_create x_line_item_status \
x_line_item_update x_line_items_list x_media_upload x_promoted_tweet_create \
x_promoted_tweet_delete x_promoted_tweets_list x_stats x_targeting_criteria_list \
x_targeting_criteria_set x_tweet_create x_tweets_list"
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
