---
name: define-brand
description: >
  Interview the user and write their brand guidelines: written voice rules to
  .flywheel/brand-voice.md and visual/imagery rules to
  .flywheel/brand-visual.md. Use when the user wants to define or update
  brand guidelines, brand voice, tone of voice, banned phrases, visual
  identity, logo/color/typography rules, or ad imagery standards, or says
  "our copy sounds generic", "set up our brand", or "write our style guide".
  For company positioning and audience, see define-company. For enforcing
  these guidelines on a piece of work, see the brand-guardian agent.
---

# Define the Brand

You are writing the two files the brand-guardian agent will enforce:
`.flywheel/brand-voice.md` (words) and `.flywheel/brand-visual.md` (pixels).
Templates live in `../get-started/templates/`. Read
`.flywheel/product-context.md` first if it exists; voice follows positioning,
not the other way round.

If either file already exists, this is an update: summarize, ask what
changed, edit only that.

## Part 1 — Voice (brand-voice.md)

Work through the template top to bottom:

1. **Name casing.** Exact capitalization in prose, plus the technical
   contexts (domain, package name, handle) where lowercase is correct.
2. **The reader.** Steal it from product-context.md's audience section and
   sharpen: what does this reader already know that most marketing would
   insult them by explaining?
3. **Voice traits.** Three or four, each as a table row with "sounds like" /
   "never sounds like" examples. A trait without an example is a poster, not
   a guideline. Draft the examples yourself from the user's own answers so
   far; they'll correct faster than they'll invent.
4. **Banned phrases.** Start from the template's generic-AI list, then add
   the user's category clichés: ask "what does every competitor's homepage
   say?" — those words go on the list.
5. **Punctuation discipline.** Exclamation marks, em-dash policy, emoji
   policy, heading capitalization. Small rules, loud tells.
6. **Messaging pillars.** Two to four priority-ordered claims, each with a
   proof point. If a pillar has no proof, move it to the roadmap section of
   product-context.md instead.
7. **Claim rules.** What is live today and safe to claim; what is never
   claimed. Copy the proof section from product-context.md rather than
   re-interviewing.

## Part 2 — Visuals (brand-visual.md)

Be honest about maturity. A company with a logo and one accent color should
get crisp rules for those two things, not an invented design system.

1. **Logo.** Primary form, file locations, and the two or three "never"
   rules that actually get violated.
2. **Color.** The accent, its job, how much is too much, forbidden colors
   (usually: whatever the category uniform is).
3. **Type.** Display, body, code if relevant. Names and one rule each.
4. **Imagery & ad creative.** The practical section: what the imagery looks
   like, which aspect ratios they actually need per platform, text-in-image
   policy, and named forbidden visuals.
5. **Signatures.** One or two recognizable habits, no more.

## If the FlyWheel connector is set up

Offer to store finished brand assets in the FlyWheel asset library so
campaign tools can use them by id: `asset_upload_begin` →
`asset_upload_commit`, then verify with `assets_list`. Record the naming
convention in brand-visual.md's asset-library section. Skip silently if the
connector isn't available.

## Wrap up

Show both files, take one correction pass, then remind the user: these files
are now binding on every flywheel agent — the fastest way to change how the
whole team writes is to edit `brand-voice.md`.
