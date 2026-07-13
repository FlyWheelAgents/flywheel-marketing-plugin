# FlyWheel Marketing Plugin

A marketing team for your agent. One Claude Code plugin bundles nine
marketing agents, guided onboarding, campaign workflows, and the FlyWheel
connector — audited read/write access to Reddit Ads, Google Ads, and Meta,
with every action logged.

The agents and skills work on their own. Connect FlyWheel and they also get
hands: live stats, campaign creation (paused by default), and an audit trail
you can grep.

## Install

Two steps in Claude Code:

```
/plugin marketplace add FlyWheelAgents/flywheel-marketing-plugin
/plugin install flywheel@flywheel
```

Then run:

```
/flywheel:get-started
```

That walks you through defining your company, writing brand guidelines,
connecting the FlyWheel connector, and launching a first campaign — and it's
resumable, so you can stop at any step.

**Right after install** the `flywheel` MCP server shows as needing sign-in.
That's expected: the agents and skills work immediately; sign in when
get-started asks, or via `/mcp` → `flywheel` → Authenticate. New accounts are
enabled by an admin after sign-up (you'll get an email) — while pending, the
connector tells your agent so in plain words, and everything else keeps
working.

### Already added FlyWheel with `claude mcp add`?

Remove the manual registration so tools aren't loaded twice:

```
claude mcp remove flywheel
```

The plugin registers its own copy. Your account, approval, and platform
connections are untouched — they live server-side.

## What's inside

### Agents

| Agent | Use it for |
|---|---|
| `marketing-strategist` | Positioning, channel choice, budget splits, 90-day plans |
| `campaign-designer` | Objective → structure → targeting → creative brief, per platform |
| `channel-strategist` | Reddit / Google / Meta depth: norms, budgets, what to check when performance dips |
| `growth-analyst` | Performance readouts, anomaly triage, "what did the agent change and when" |
| `brand-guardian` | Reviews any outward-facing artifact against your brand guidelines |
| `copywriter` | Headlines, landing pages, ads within platform limits, emails — three variants each |
| `seo-specialist` | Intent mapping, on-page fundamentals, content briefs |
| `geo-specialist` | Getting cited by AI answer engines — ChatGPT, Perplexity, AI Overviews |
| `content-marketer` | Pillar/cluster strategy, sustainable calendars, channel-native repurposing |

Every agent reads your `.flywheel/` context files first (created by
get-started), so they write in your voice about your product without being
reminded.

### Skills

| Skill | What it does |
|---|---|
| `/flywheel:get-started` | Guided setup: company → brand → connector → first campaign |
| `/flywheel:define-company` | Interview → `.flywheel/product-context.md` |
| `/flywheel:define-personas` | Interview → `.flywheel/personas.md` (1-3 targeting-grade personas) |
| `/flywheel:define-brand` | Interview → `.flywheel/brand-voice.md` + `brand-visual.md` |
| `/flywheel:connect-flywheel` | Connector sign-in, duplicate cleanup, approval-state handling |
| `/flywheel:connect-platforms` | Link Reddit/Google/Meta ad accounts — no campaign required |
| `/flywheel:first-campaign` | Build the first campaign, paused, with receipts and a campaign log |
| `/flywheel:book-a-call` | Book a 20-minute call with the team, from chat (works while pending) |
| `/flywheel:daily-marketing-meeting` | Standup: yesterday's numbers, one win, one concern, proposed actions |
| `/flywheel:weekly-marketing-report` | Stakeholder-ready week in review with budget pacing |
| `/flywheel:campaign-brief` | One-page brief before any money moves |

### The connector

`.mcp.json` points at `https://connector.flywheelagents.com/api/mcp` — a
hosted MCP server with a uniform tool surface across Reddit Ads, Google Ads,
and Meta. Reads and writes, with server-enforced defaults: new campaigns
ship paused, deletion isn't exposed, and every tool call is logged with
args, status, latency, and actor.

## What works without the connector

| | Without FlyWheel | With FlyWheel |
|---|---|---|
| All nine agents | Full (strategy, content, review) | Plus live data and campaign actions |
| get-started steps 1-2, define-company, define-personas, define-brand, campaign-brief | Full | Full |
| get-started steps 3-4, connect-flywheel, connect-platforms, first-campaign | — | Full |
| book-a-call | Booking page URL | Books from chat (even while pending approval) |
| daily-marketing-meeting, weekly-marketing-report | Planning mode (no live numbers) | Full |

## Automate the daily meeting

The meeting runs when you invoke it. To run it on a schedule you need a
headless auth path, since cron can't do browser sign-in:

1. Once approved, mint a `fw_live_…` API key in the FlyWheel dashboard.
2. Register a key-authenticated server at project scope:
   `claude mcp add --transport http flywheel-ci https://connector.flywheelagents.com/api/mcp --header "Authorization: Bearer $FLYWHEEL_API_KEY"`
3. Schedule `claude -p "/flywheel:daily-marketing-meeting"` with your
   scheduler of choice (OS cron, CI, or Claude Code's scheduled routines).

Keep the key in an environment variable. Treat it like money, because it is.

## Troubleshooting

- **FlyWheel tools missing entirely** — run `/plugin` and check the plugin
  is enabled, then restart Claude Code.
- **"pending approval" responses** — normal for new accounts; see
  `/flywheel:connect-flywheel`. Access unlocks automatically, no re-sign-in.
- **Sign-in browser doesn't open (SSH/WSL/containers)** — copy the sign-in
  URL and open it on any device; the flow doesn't depend on the machine
  running Claude Code.
- **Duplicate tools** — you have both a manual `claude mcp add` server and
  the plugin's. Remove the manual one (above).
- **Something else** — [open an issue](https://github.com/FlyWheelAgents/flywheel-marketing-plugin/issues).
  Plain-language reports welcome; you don't need to know whose bug it is.

## Removing FlyWheel

1. `/plugin uninstall flywheel@flywheel` removes agents, skills, and the MCP
   registration. Your `.flywheel/` files stay (they're yours).
2. Server-side: disconnect ad platforms with the `connection_revoke` tool or
   the dashboard, and revoke API keys in the dashboard. For Reddit/Google,
   also revoke the app in the platform's own security settings to fully cut
   access.

## Versioning

Semver, tagged releases, [CHANGELOG.md](CHANGELOG.md). Update with
`/plugin marketplace update flywheel`. Connector tool changes that would
break skills ship as coordinated plugin releases.

## License

MIT. Original work throughout — we studied the open-source marketing-skills
ecosystem and wrote our own take; see
[ACKNOWLEDGEMENTS.md](ACKNOWLEDGEMENTS.md) for the repos that shaped our
thinking.
