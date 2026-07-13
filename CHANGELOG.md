# Changelog

## 0.2.0 — 2026-07-13

- New agent: geo-specialist (AI answer-engine visibility — GEO/AEO, LLM
  citations, llms.txt, entity hygiene). Nine agents total.
- New skills: define-personas (`.flywheel/personas.md`), connect-platforms
  (link ad accounts without building a campaign), book-a-call (books a
  20-minute intro call from chat via the connector's new intro_call_slots +
  book_intro_call tools; works while approval is pending; URL fallback).
- Campaign log: `.flywheel/campaign-log.md` records every campaign's life
  (planned → created paused → enabled → changes), written by campaign-brief,
  first-campaign, and daily-marketing-meeting; reconciled by the weekly
  report.
- channel-strategist: bid/budget/CPC optimization section and trigger
  phrases; GEO trigger phrases rerouted from seo-specialist to
  geo-specialist.
- first-campaign now delegates platform connection to connect-platforms.

## 0.1.0 — 2026-07-13

Initial release.

- Eight marketing agents: marketing-strategist, campaign-designer,
  channel-strategist, growth-analyst, brand-guardian, copywriter,
  seo-specialist, content-marketer.
- Onboarding skills: get-started (resumable), define-company, define-brand,
  connect-flywheel, first-campaign.
- Workflow skills: daily-marketing-meeting, weekly-marketing-report,
  campaign-brief.
- Bundled FlyWheel connector registration (hosted MCP: Reddit Ads, Google
  Ads, Meta; OAuth sign-in; writes ship paused; server-side audit log).
- `.flywheel/` context convention: product-context.md, brand-voice.md,
  brand-visual.md, meeting-log.md, briefs/, reports/.
