---
name: daily-marketing-meeting
description: >
  Run the daily marketing standup: pull yesterday's ad performance through
  the FlyWheel connector, compare against plan, surface wins and concerns,
  and propose today's actions with a decision log. Use when the user says
  "daily marketing meeting", "morning marketing standup", "how are the ads
  doing today", or wants a recurring review rhythm for their campaigns.
  Works in a reduced planning mode without the connector. For deep metric
  investigation, see the growth-analyst agent; for one-off stat pulls, call
  the platform stats tools directly.
---

# Daily Marketing Meeting

You are chairing a short, factual standup. The output is a readout the user
can skim in two minutes and a decision log entry. Opinions are welcome;
invented numbers are not.

## Step 0 — Establish mode

Check the connector state and say which mode you're in:

1. **Full** — FlyWheel tools available and authenticated: run the whole
   agenda.
2. **Pending approval** — tools return `account_status: "pending_approval"`:
   say so in one line, then run planning mode (step 4 only).
3. **Connected, no platform connections** — offer `first-campaign`, then
   planning mode.
4. **No connector** — planning mode, with one line noting that connecting
   FlyWheel enables live numbers.

Also read `.flywheel/product-context.md` (the 90-day goal is the yardstick)
and `.flywheel/meeting-log.md` (yesterday's decisions are today's follow-ups).

## Step 1 — Pull the numbers (full mode)

For each platform in `connections_list`, pull yesterday and the prior 7 days
for context: `reddit_stats`, `google_stats`, `meta_stats` as applicable.
Practicalities:

- "Yesterday" is the ad account's time zone (it's in `connections_list`),
  not the user's.
- Campaigns younger than ~48h: report spend and delivery only; flag that
  performance judgments would be noise.
- A platform API error is a line in the readout ("Meta stats unavailable:
  <error>"), not a reason to stop the meeting.
- If FlyWheel asks for re-authentication mid-meeting, have the user
  re-authenticate via `/mcp` and pick up where you left off.

## Step 2 — What changed

Call `audit_query` for the last 24h. Anything that changed state (created,
enabled, budget updated) gets correlated with the numbers: "CTR dropped the
same day the new creative went live" is the kind of sentence this meeting
exists for.

## Step 3 — The readout

Produce this exact structure, in plain markdown:

```
## Marketing standup — <date>

**Goal check:** <90-day goal> — <current pace vs baseline, one line>

| Platform | Spend | Impr | Clicks | CTR | Conv | CPA | Δ vs 7-day avg |
|---|---|---|---|---|---|---|---|

**Win:** <one thing working, with the number>
**Concern:** <one thing off, with the number — or "none">
**Yesterday's follow-ups:** <status of each open item from the log>
```

One win, one concern. If everything is fine, say so in one line; a quiet day
is a valid readout.

## Step 4 — Proposed actions

Up to three, each with: the reasoning, the exact tool call it maps to, and
the blast radius (money touched or not). Order: fix tracking problems, then
stop money-losers, then scale winners, then experiments.

Anything touching spend (enable, budget change, new campaign) needs the
user's explicit yes in this conversation before you call the tool. Read-only
follow-ups you can just do.

In planning mode, actions come from the plan and the log instead of stats,
and each carries "verify against live numbers once connected".

## Step 5 — Log it

Append to `.flywheel/meeting-log.md` (create it if missing):

```
### <date>
- Readout: <two-line summary>
- Decisions: <what was approved / declined>
- Open: <follow-ups for tomorrow>
```

The log is what makes tomorrow's meeting start from context instead of zero.

## Automating the meeting

This skill runs when invoked; Claude Code doesn't schedule it by itself. If
the user wants it truly daily, point them to the README's "Automate the
daily meeting" section (scheduled runs need the headless API-key setup from
connect-flywheel; browser sign-in isn't available in cron).
