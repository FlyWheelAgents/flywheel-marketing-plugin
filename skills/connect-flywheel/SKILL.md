---
name: connect-flywheel
description: >
  Connect and authenticate the FlyWheel ad connector (the MCP server this
  plugin bundles), including duplicate-server cleanup, sign-in, the
  pending-approval state, and verification. Use when the user wants to set up
  the FlyWheel MCP, can't authenticate, sees "pending approval", asks why
  FlyWheel tools are failing or missing, or previously added FlyWheel with
  "claude mcp add" and now sees duplicate tools. For connecting an actual ad
  platform account (Reddit, Google Ads, Meta), see first-campaign.
---

# Connect FlyWheel

You are getting the user from "plugin installed" to "authenticated connector,
ready to connect an ad account". The connector is a hosted MCP server at
`https://connector.flywheelagents.com/api/mcp`; this plugin already registers
it. No API key is needed for interactive use; sign-in happens in the browser.

## Step 1 — Duplicate-server check

Users who followed older instructions may have added FlyWheel manually. Ask
the user to run:

```
claude mcp list
```

If a user- or project-scope server also points at
`connector.flywheelagents.com` (typically named `flywheel`), have them remove
it so tools aren't registered twice:

```
claude mcp remove flywheel
```

The plugin's copy stays; nothing else is lost — server-side connections and
approval are account-level, not client-level.

## Step 2 — Sign in

1. Have the user run `/mcp`, select the `flywheel` server, and choose
   **Authenticate**.
2. A browser opens: they enter their email and confirm with a magic
   link / one-time code. New users are creating an account right now; there
   is no separate signup form.
3. On headless or SSH machines the browser step can't open locally — the
   sign-in URL can be copied and opened on any device.

## Step 3 — Handle the approval gate

FlyWheel accounts are enabled by an admin after sign-up. Probe with
`connections_list`:

- **Response contains `account_status: "pending_approval"`** — expected for
  new accounts. Tell the user, in this order: sign-in worked; an admin
  enables the account (they'll get an email, typically within a business
  day); access unlocks on the next tool call with no re-sign-in and no
  reinstall; and the rest of the plugin (all agents, company/brand skills)
  works fully in the meantime. Do not treat this as an error and do not
  retry in a loop. Offer `/flywheel:book-a-call`: the booking tools work
  even while pending, and a 20-minute intro call is the fastest way to get
  approved and oriented at once.
- **Response lists connections (even zero of them, without the pending
  status)** — the account is live. Continue.
- **Authentication error** — re-run `/mcp` → Authenticate. If it persists,
  collect the exact error and point the user to
  https://github.com/FlyWheelAgents/flywheel-marketing-plugin/issues.

## Step 4 — Verify and hand off

On a live account, confirm the state out loud: "authenticated, N platform
connections". If N is zero, the next step is connecting an ad platform,
which belongs to the `first-campaign` skill; offer to continue there.

## Headless / CI note

Scheduled or headless agents can't do browser sign-in. For that case the
user mints a `fw_live_…` API key in the FlyWheel dashboard (available once
approved) and registers the endpoint with a bearer header at project scope:

```
claude mcp add --transport http flywheel-ci https://connector.flywheelagents.com/api/mcp \
  --header "Authorization: Bearer $FLYWHEEL_API_KEY"
```

Keep the key in an environment variable, never in a committed file.
