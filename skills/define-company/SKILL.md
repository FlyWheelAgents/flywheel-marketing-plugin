---
name: define-company
description: >
  Interview the user about their company, product, positioning, audience, and
  90-day goals, then write .flywheel/product-context.md — the context file
  every flywheel agent reads first. Use when the user wants to define or
  update their company profile, positioning, target audience, or marketing
  goals, or says "set up my product context", "our positioning changed", or
  "update my company info". For brand voice and visuals, see define-brand.
  For the full guided setup, see get-started.
---

# Define the Company

You are building the single context file that stops every future marketing
conversation from starting with twenty questions. Interview, then write
`.flywheel/product-context.md` using the structure in
`../get-started/templates/product-context.md`.

## Before the interview

1. Walk up from the current directory for an existing
   `.flywheel/product-context.md`. If found, this is an update: show a
   two-line summary, ask which sections changed, and edit only those.
2. Mine what's already available before asking anything: a README, a
   marketing site (fetch it if the user gives a URL), package descriptions,
   an existing pitch deck. Draft answers from evidence and ask the user to
   correct them. Confirming a draft is faster than a blank questionnaire.

## The interview

Ask in this order, one small batch at a time, and push back on vague answers:

1. **What it does.** One sentence, no adjectives. If the user needs two
   sentences, the positioning work below matters more than they think.
2. **Positioning.** "For [who], [product] is [category]. Unlike
   [the realistic alternative], it [one difference that matters]." The
   alternative is usually a spreadsheet, an intern, or doing nothing, not the
   venture-backed competitor.
3. **Audience.** Role, the job they're hiring the product for, what they've
   tried, what they're allergic to. Reject demographic fluff ("25-45,
   tech-savvy") and ask for a person they can name.
4. **Proof.** Only claims that can be pointed to today. Roadmap items get
   listed separately and are never described as live. This section is what
   keeps every downstream agent honest.
5. **Objections.** The two or three things prospects actually say, with the
   real answer, including trade-offs.
6. **90-day goal.** One measurable goal, its current baseline, and the real
   monthly budget. "Grow awareness" is not a goal; "40 qualified signups a
   month, currently 12" is.

## Writing the file

- Create `.flywheel/` in the current directory (after the home-directory
  warning from get-started, if applicable).
- Fill every section of the template. Where the user had no answer, write
  `TBD — [what would resolve it]` rather than inventing content.
- Keep it under ~120 lines. This file gets read on every task; bloat is a tax
  on every future conversation.
- Show the finished file and ask for one correction pass before moving on.
