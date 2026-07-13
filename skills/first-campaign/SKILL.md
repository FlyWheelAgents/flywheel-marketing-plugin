---
name: first-campaign
description: >
  Connect an ad platform account (Reddit, Google Ads, or Meta) and launch a
  first campaign through the FlyWheel connector, paused by default, with the
  audit trail as receipts. Use when the user wants to launch their first
  campaign, connect Reddit/Google/Meta ads, asks "run my first ad", or has an
  authenticated FlyWheel account with no platform connections yet. Requires
  the connector — see connect-flywheel if FlyWheel tools are missing or
  pending approval. For designing the campaign strategy itself, see the
  campaign-designer agent.
---

# First Campaign

You are walking the user from an authenticated FlyWheel account to a built,
reviewable, still-paused first campaign. Two rules govern everything here:
nothing spends without an explicit, separate confirmation, and the platform
mechanics come from FlyWheel's own runbook, not from memory.

## Step 0 — Preconditions

Call `connections_list`. If tools are missing or the response carries
`account_status: "pending_approval"`, stop and run the `connect-flywheel`
flow instead. If `.flywheel/product-context.md` exists, read it — the 90-day
goal and budget shape every recommendation below.

## Step 1 — Fetch FlyWheel's launch runbook

Call the connector's `getting_started` tool and say what you're doing:
"fetching FlyWheel's launch runbook". It returns the current, accurate
step-by-step for all three platforms — tool order, platform quirks, money
units. Treat it as the source of truth over anything in this file; the
server evolves faster than the plugin.

## Step 2 — Choose the platform

If the user hasn't chosen, recommend ONE platform from their audience and
budget (product-context.md), with one sentence of reasoning. Don't launch on
two platforms on day one; there's no baseline to compare against yet.

## Step 3 — Connect the platform account

1. Call `connect_service` with the chosen service (`"reddit"`,
   `"google_ads"`, or `"meta"`).
2. Give the user the returned URL: it works pasted into any browser on any
   device, no prior dashboard session needed, and expires in about 10
   minutes. If it expires or the user abandons the platform's consent
   screen, just call `connect_service` again for a fresh URL.
3. Poll `connections_list` until the connection appears, then relay what
   came back: currency, time zone, and any platform flags (for Meta,
   `has_funding`; a manager account; Pages count).

## Step 4 — Money check before anything is built

Campaigns that can't spend don't serve; catch this now, not after review:

- **Reddit:** confirm funding with the funding tool named in the runbook.
- **Google:** note the account's currency and that all Google money values
  are micros (1,000,000 = one unit of that currency).
- **Meta:** money is in minor units (cents), and `has_funding: false` often
  means the API can't see a credit line rather than that none exists — have
  the user verify billing in Ads Manager instead of assuming.

## Step 5 — Build, paused

Follow the runbook's order for the chosen platform, exactly. Before each
create call, show the user what will be created in plain language (budget
per day, targeting, where it runs). After building, confirm the whole
structure with the platform's list tools and present a review summary:
campaign → group → ad, budget, targeting, status. Everything is paused;
say so.

If the user wants creative input, involve the `copywriter` (platform
character limits) and run the result past `brand-guardian` before uploading.

## Step 6 — The receipts

Call `audit_query` and show the trail of what was just done: every call,
args, status, latency. This is the habit that matters later: when anyone
asks "what did the agent do to our ad account", this is the answer.

## Step 7 — Going live (separate decision)

Enabling the campaign is its own conversation. Restate the daily budget and
the first review checkpoint (48-72h; nothing meaningful sooner), get an
explicit yes, then enable via the platform's update tool. Log the decision
in `.flywheel/meeting-log.md` if it exists, and point the user at
`/flywheel:daily-marketing-meeting` for the follow-up rhythm.
