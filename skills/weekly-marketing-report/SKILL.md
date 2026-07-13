---
name: weekly-marketing-report
description: >
  Produce the weekly marketing report: seven days of cross-platform
  performance, trend versus the previous week, budget pacing against plan,
  and next week's priorities. Use when the user asks for a weekly report,
  week-in-review, marketing summary for stakeholders, or "how did marketing
  do this week". Works in planning mode without the FlyWheel connector. For
  the daily rhythm, see daily-marketing-meeting; for metric deep-dives, see
  the growth-analyst agent.
---

# Weekly Marketing Report

You are writing the report a founder forwards to a co-founder or an investor
without editing it first. Longer horizon than the daily standup, higher bar
for "insight": week-over-week direction, not day-to-day noise.

## Gather

1. Mode check, exactly as in `daily-marketing-meeting` (full / pending /
   no-connections / no-connector). In anything but full mode, produce the
   qualitative sections and mark the numbers section "pending live data".
2. Full mode: pull the last 7 days and the 7 before that per connected
   platform (`reddit_stats`, `google_stats`, `meta_stats`), account
   time zone.
3. `audit_query` over the week: every change made, by whom (actor), and
   when.
4. `.flywheel/meeting-log.md`: the week's decisions, so the report reflects
   what was tried, not just what happened.
5. `.flywheel/campaign-log.md`: the campaign roster and each one's History
   lines — the "what we did" section should reconcile with it, and any
   campaign that changed state without a log entry gets flagged.
6. `.flywheel/product-context.md`: goal and monthly budget for pacing.

## Write

```
# Marketing week in review — <date range>

**One-liner:** <the week in one honest sentence>

## Numbers
| Platform | Spend | CTR | Conv | CPA | WoW Δ |
|---|---|---|---|---|---|
Budget pacing: <spent so far this month> of <monthly budget> (<ahead/on/behind> pace)

## What we did
<3-6 bullets from the audit trail and meeting log — changes, launches, tests>

## What we learned
<2-3 findings with the number that backs each. A failed test with a clear
reading counts as a win here.>

## Next week
<Up to 3 priorities, each tied to the 90-day goal, each with an owner —
"agent" is a valid owner.>
```

## Rules

- Every number traces to a tool response or the log; anything estimated is
  labeled as an estimate.
- Week-over-week deltas over absolutes; absolutes without context read as
  noise.
- At small spend, say plainly when a difference is not meaningful rather
  than narrating randomness.
- Save the report to `.flywheel/reports/<year>-w<week>.md` and tell the user
  where it landed.
