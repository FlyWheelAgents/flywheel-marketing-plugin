# Contributing

Contributions welcome: new skills, agent improvements, better docs, bug
reports in plain language.

## The originality rule (non-negotiable)

Every sentence in this repo is written for this repo. You may study other
skill/agent collections for structure and ideas (we did — see
ACKNOWLEDGEMENTS.md), but no text may be copied from another project,
regardless of its license. PRs with recognizably lifted prose are closed.
If your contribution is a close derivative of a specific MIT/Apache file,
say so in the PR and preserve its notice; we'd rather have the conversation
than the surprise.

## Quality bar for skills and agents

- **Descriptions are routing.** The frontmatter `description` decides when
  Claude reaches for your skill or agent: write trigger phrases users
  actually say, and cross-reference neighboring skills/agents so the router
  can pick the right one, not just yours.
- **Read context first.** Anything that produces outward-facing work reads
  `.flywheel/product-context.md` and `.flywheel/brand-voice.md` before
  writing a word, and degrades gracefully when they're missing.
- **Honest about the connector.** Reference only MCP tools that exist on
  the live connector; state the fallback when it's absent or pending
  approval. Never let an agent fabricate stats.
- **Money needs a yes.** Any step that creates, enables, or changes spend
  requires explicit user confirmation in the conversation.
- **No hype.** No exclamation marks, no "seamless/robust/game-changer"
  vocabulary. If the claim needs decoration, it isn't a claim.

## Mechanics

1. Fork, branch, make your change.
2. Run `scripts/validate-skills.sh` (frontmatter and naming checks) and
   `claude plugin validate .` — both must pass; CI runs them too.
3. One logical change per PR, with a sentence on why it earns its context
   window.

## Releases

Maintainers bump `version` in `.claude-plugin/plugin.json` and
`marketplace.json`, add a CHANGELOG entry, and tag. Users pick updates up
via `/plugin marketplace update flywheel`.
