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

Run the `connect-platforms` skill flow for the chosen platform (it owns
connection and the funding reality check). Come back here once
`connections_list` shows the account.

## Step 4 — Money units before anything is built

- **Google:** all money values are micros (1,000,000 = one unit of the
  account currency).
- **Meta:** money is in minor units (cents; whole units for JPY/KRW).
- **Reddit:** funding was checked during connect; if that was a while ago,
  re-check before building.

## Step 5 — Build, paused

Follow the runbook's order for the chosen platform, exactly. Before each
create call, show the user what will be created in plain language (budget
per day, targeting, where it runs). After building, confirm the whole
structure with the platform's list tools and present a review summary:
campaign → group → ad, budget, targeting, status. Everything is paused;
say so.

If the user wants creative input, involve the `copywriter` (platform
character limits) and run the result past `brand-guardian` before uploading.

## Step 6 — The receipts and the log

Call `audit_query` and show the trail of what was just done: every call,
args, status, latency. This is the habit that matters later: when anyone
asks "what did the agent do to our ad account", this is the answer.

Then record the campaign in **`.flywheel/campaign-log.md`** (create it if
missing). This file is the canonical format — other skills append entries
in the same shape:

```
## <campaign name> — <platform>
- Created: <date> · status: paused
- Ids: campaign <id> · group/set <id> · ad <id>
- Objective: <from the brief, or one line>
- Budget: <daily, currency> · stop date: <date or "none set — fix this">
- Brief: .flywheel/briefs/<slug>.md (if one exists)
- History:
  - <date>: created (paused)
```

Every later state change (enabled, budget change, stopped) appends a dated
History line. The audit trail records what tools did; this log records
which campaigns exist and why.

## Step 7 — Going live (separate decision)

Enabling the campaign is its own conversation. Restate the daily budget and
the first review checkpoint (48-72h; nothing meaningful sooner), get an
explicit yes, then enable via the platform's update tool. Append the
History line to `.flywheel/campaign-log.md`, log the decision in
`.flywheel/meeting-log.md` if it exists, and point the user at
`/flywheel:daily-marketing-meeting` for the follow-up rhythm.
