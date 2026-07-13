---
name: define-personas
description: >
  Interview the user and write 1-3 buyer personas to .flywheel/personas.md —
  the targeting detail behind product-context.md's audience summary. Use when
  the user wants to define or update personas, buyer profiles, ICP, target
  customers, or audience segments, or says "who should we target", "build our
  personas", or "our audience changed". For company positioning, see
  define-company. Campaign-designer and channel-strategist read this file for
  targeting decisions; copywriter reads it for the reader's voice.
---

# Define Personas

You are writing `.flywheel/personas.md` from the structure in
`../get-started/templates/personas.md`. Personas here are targeting
instruments, not creative-writing exercises: every field must change a real
decision (channel, targeting parameter, copy angle) or it gets cut.

## Before the interview

1. Read `.flywheel/product-context.md` if it exists — its Audience section is
   the starting draft. If `personas.md` already exists, this is an update:
   summarize each persona in a line, ask which changed, edit only those.
2. Draft from evidence first: real customers the user can name, support
   conversations, reviews of competitor products. Ask the user to correct a
   draft rather than fill a blank form.

## The interview, per persona (max 3)

1. **A person, not a segment.** Ask the user to picture one real person who
   bought or should buy. The persona gets a nickname they'd recognize
   themselves by ("the agency owner drowning in client reporting"), never a
   fake first name with a stock photo personality.
2. **Trigger over demographics.** What event starts the search — a hire, a
   failed audit, a price increase somewhere else? Campaigns aim at triggers;
   demographics only narrow delivery.
3. **Attention, specifically.** Which subreddits, which search phrases, which
   feeds. "LinkedIn" is not an answer; "follows marketing-ops voices,
   searches 'google ads api audit log'" is. This field feeds
   channel-strategist directly.
4. **Objections in their words**, and the honest answers.
5. **Disqualifiers.** Who looks like this persona but wastes budget. This
   becomes negative targeting and copy that self-selects.

Push back on a persona that no current customer resembles: label it
`hypothesis` in the file so agents treat its targeting as a test, not a fact.

## Writing the file

- Write `.flywheel/personas.md`; keep each persona under ~20 lines.
- Update `product-context.md`'s Audience section to a two-line summary per
  persona pointing at this file (ask before touching it if it wasn't written
  by these skills).
- Close by naming the one campaign implication per persona ("persona 1 says
  Reddit before Meta; persona 2's trigger fits search intent").
