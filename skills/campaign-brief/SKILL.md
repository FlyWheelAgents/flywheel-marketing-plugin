---
name: campaign-brief
description: >
  Turn a campaign idea into a one-page brief: objective, audience, platform,
  budget, message, creative requirements, and success criteria, ready to
  hand to campaign-designer to build. Use when the user wants to plan a
  campaign, write a campaign brief, scope a launch or promotion, or says "I
  want to run ads for X" and the strategy isn't settled yet. No connector
  required. For building the campaign in an ad platform, see the
  campaign-designer agent and the first-campaign skill.
---

# Campaign Brief

You are writing the one page that prevents the expensive kind of confusion:
building the wrong campaign well. The brief is a thinking tool; keep it to
one page, and fight scope creep in the objective line.

## Inputs

Read `.flywheel/product-context.md` and `.flywheel/brand-voice.md` if they
exist. The positioning and 90-day goal constrain everything below; if the
proposed campaign doesn't serve the 90-day goal, say so before writing the
brief, and let the user overrule.

## Interview (only what's missing)

1. **Objective** — one measurable outcome with a number and a date. Not
   "awareness"; "300 landing-page visits and 30 signups by <date>".
2. **Audience** — which slice of the audience in product-context.md, and
   what they should think/do after seeing the campaign.
3. **Budget & duration** — total, daily, and hard stop date. A campaign
   without a stop date is a subscription.
4. **Offer & message** — what the audience gets and the one claim the
   campaign leads with (from the messaging pillars, or flag that a new
   pillar is being invented ad hoc).
5. **Platform** — one, with reasoning. Two platforms only if the budget
   supports a real test on each.

## The brief

Write `.flywheel/briefs/<slug>.md`:

```
# Campaign brief: <name>
Date: <date>  ·  Status: draft

**Objective:** <number + date>
**Audience:** <who, and the desired next action>
**Platform:** <one, and why>
**Budget:** <total / daily / stop date>
**Core message:** <the claim>
**Supporting proof:** <why the claim is credible — from product-context.md>

## Creative requirements
<formats and copy blocks needed for the platform, with limits — e.g. Google
RSA: 3-15 headlines ≤30 chars, 2-4 descriptions ≤90 chars; Meta: feed 1:1 /
4:5, primary text front-loaded; Reddit: title that reads native>

## Measurement
Primary metric: <one>
Guardrails: <e.g. pause if CPA exceeds X for 3 consecutive days>
First review: <48-72h after launch>

## Out of scope
<what this campaign deliberately does not try to do>
```

## Hand-off

Offer the next steps in order: `copywriter` for the creative blocks,
`brand-guardian` for review, `campaign-designer` (or `first-campaign` if
this is the first one) to build it — paused — through the FlyWheel
connector.
