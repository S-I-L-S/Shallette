# Architecture plan

This is a planning outline, not a description of existing implementation.

## Separate product identity from browser engine

Keep Shallette-authored interface and identity changes easy to locate and maintain. If the project is based on Zen, record upstream revisions and keep a reproducible patch or branch strategy so upstream security updates can be tracked. Avoid mixing original Shallette assets with upstream-branded assets.

## Future build variants

When multiple builds are introduced, define each variant explicitly with a named configuration, supported platforms, update channel, signing identity, and branding asset set. Prefer shared source plus explicit configuration over undocumented manual edits. Do not publish a variant until its source revision and build inputs are identifiable.

## Planned documentation

- `docs/ARCHITECTURE.md`: actual component boundaries and upstream relationship.
- `docs/RELEASES.md`: channels, platforms, versioning, signing, and artifact provenance.
- `THIRD_PARTY_NOTICES.md`: incorporated components and required notices.

Replace this plan with concrete diagrams and build instructions after source code is available.
