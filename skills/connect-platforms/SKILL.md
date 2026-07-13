---
name: connect-platforms
description: >
  Connect ad platform accounts (Reddit Ads, Google Ads, Meta) to FlyWheel —
  no campaign required. Use when the user wants to connect, link, or
  authorize an ad account, says "connect my Google Ads", "link Meta", "add
  Reddit", or asks which platforms are connected. Requires an authenticated
  FlyWheel connector — see connect-flywheel if tools are missing or pending
  approval. For building a campaign after connecting, see first-campaign or
  the campaign-designer agent.
---

# Connect Platforms

You are linking ad platform accounts to the user's FlyWheel business. This
is connection only: nothing here creates campaigns or spends money.

## Step 1 — Current state

Call `connections_list`. If tools are missing or the response carries
`account_status: "pending_approval"`, hand off to `connect-flywheel`.
Otherwise report what's already connected (platform, account name, status)
and confirm which platform(s) to add. If the user is unsure which platform
matters first, that's a persona question: check `.flywheel/personas.md` or
suggest the channel-strategist agent — don't default to "all three".

## Step 2 — Connect (per platform)

1. Call `connect_service` with `"reddit"`, `"google_ads"`, or `"meta"`.
2. Hand the user the returned URL. It works pasted into any browser on any
   device — no dashboard session needed — and expires in about 10 minutes.
   If it expires or they abandon the platform's consent screen, call
   `connect_service` again for a fresh URL; retrying is always safe.
3. Platform notes worth saying up front:
   - **Google Ads:** they'll pick the account during consent; manager
     accounts appear too.
   - **Meta:** the ad account must live in a Meta Business Manager, and
     they should approve the workspace the account belongs to.
   - **Reddit:** connection is quick; funding is the usual gotcha (step 4).

## Step 3 — Verify

Poll `connections_list` until the connection appears. Relay what came back
in plain terms: account name, currency, time zone, and flags (Meta
`has_funding`, manager status, Pages count). If it never appears, the
consent was likely abandoned mid-flow — issue a fresh URL and try again.

## Step 4 — Funding reality check

A connected account that can't pay won't serve ads. Without building
anything:

- **Reddit:** check `reddit_ad_account_funding` for the connected account.
- **Meta:** if `has_funding` is false, explain it often means the API can't
  see a credit line rather than that none exists — verify billing in Ads
  Manager.
- **Google:** billing lives in the Google Ads UI; just remind the user a
  new account needs billing set up before anything can serve.

## Step 5 — What's now possible

Close with the unlocked capabilities, concretely: live numbers in
`/flywheel:daily-marketing-meeting`, campaign builds via
`/flywheel:first-campaign` (or campaign-designer for the strategy first),
and every action on the record via `audit_query`.
