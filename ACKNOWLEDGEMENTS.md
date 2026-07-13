# Acknowledgements

Everything in this repo is original text, but none of it was written in a
vacuum. These projects shaped how we think about skills, agents, and plugin
structure, and deserve the credit:

- [coreyhaines31/marketingskills](https://github.com/coreyhaines31/marketingskills) (MIT) —
  set the bar for marketing skills as software: trigger-phrase descriptions,
  a shared product-context file so skills stop re-interviewing the user, and
  per-skill evals. Our `.flywheel/` context convention is a descendant of
  that idea.
- [wshobson/agents](https://github.com/wshobson/agents) (MIT) — the cleanest
  plugin-marketplace packaging in the ecosystem, and proof that terse agent
  definitions with clear delegation cues beat sprawling ones.
- [anthropics/skills](https://github.com/anthropics/skills) (per-skill
  licenses) — the canonical skill format, and the brand-guidelines skill
  that showed a brand system can be encoded as directives an agent follows.
- [seranking/seo-skills](https://github.com/seranking/seo-skills) (MIT) —
  the reference for shipping a hosted MCP server inside a plugin, including
  honest docs about auth flows and scope precedence.
- [AgriciDaniel/claude-seo](https://github.com/AgriciDaniel/claude-seo) (MIT) —
  repo hygiene worth copying the spirit of, and vendor-neutral core with
  provider extensions kept at arm's length.
- [contains-studio/agents](https://github.com/contains-studio/agents) — the
  department-of-specialists taxonomy for marketing agents. No license file,
  so nothing was reused; the organizational idea still deserves a nod.

If you maintain one of these and think we've under-credited you, open an
issue — we'd rather over-credit than the alternative.
