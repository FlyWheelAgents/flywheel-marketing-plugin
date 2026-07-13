---
name: get-started
description: >
  Set up the FlyWheel marketing system from zero: define the company, write
  brand guidelines, connect the FlyWheel ad connector, and launch a first
  campaign. Use when the user has just installed the flywheel plugin, asks
  "how do I get started", "set up flywheel", "onboard me", or wants a guided
  setup of their marketing context. Resumable: safe to run again after an
  interruption — it detects what's already done and continues from there.
  For individual steps, see define-company, define-brand, connect-flywheel,
  and first-campaign.
---

# Get Started with FlyWheel

You are running the FlyWheel onboarding. It has four steps. Detect what's
already done, skip it, and continue from the first incomplete step. Never
redo a completed step without asking, and never silently overwrite an
existing file.

## Step 0 — Detect state

Check, in order:

1. Walk up from the current directory looking for a `.flywheel/` directory.
   Note which of these exist: `product-context.md`, `brand-voice.md`,
   `brand-visual.md`, `meeting-log.md`.
2. Check whether FlyWheel MCP tools are available in this session (tool names
   containing `connections_list`, `getting_started`).
3. If the current directory is the user's home directory, warn that context
   files will land in `$HOME/.flywheel/` and suggest running from a project
   directory instead. Warn once, then respect their choice.

Report state as a short checklist ("company context: done, brand voice:
missing, connector: not authenticated"), then continue.

## Step 1 — Define the company

If `.flywheel/product-context.md` exists, summarize it in two lines and ask
whether it's still current; update only the sections the user wants changed.
Otherwise run the `define-company` skill flow: interview the user and write
`.flywheel/product-context.md` from `templates/product-context.md`.

## Step 2 — Define the brand

Same pattern with `define-brand`: written voice guidelines to
`.flywheel/brand-voice.md`, visual/imagery guidelines to
`.flywheel/brand-visual.md`, from the matching templates.

Steps 1 and 2 need no account and no connector. They are the foundation every
flywheel agent reads before doing work; finishing just these two steps is
already a useful outcome.

## Step 3 — Connect the FlyWheel ad connector

Run the `connect-flywheel` skill flow. Key points it handles:

- A pre-flight check for a duplicate manually-added `flywheel` MCP server.
- Sign-in via `/mcp` → Authenticate (browser magic-link).
- The pending-approval state: FlyWheel accounts are approved by an admin.
  While pending, tools return `account_status: "pending_approval"`. That is
  normal, not an error. Access unlocks automatically on approval with no
  re-sign-in; everything else in this plugin keeps working meanwhile.

If the user doesn't want the connector (agents and skills work without it),
skip this step and step 4, and say what they'd gain by connecting later.

## Step 4 — First campaign

Run the `first-campaign` skill flow: connect an ad platform account, then
build a first campaign following FlyWheel's launch runbook (fetched live from
the connector's `getting_started` tool). Everything ships paused; nothing
spends without an explicit, separate confirmation.

## Wrap up

Summarize: what was created (file paths), connector state, and what to try
next. Suggest `/flywheel:daily-marketing-meeting` as the recurring habit, and
name two agents relevant to the user's stated 90-day goal.
