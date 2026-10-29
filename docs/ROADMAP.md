# Roadmap

This roadmap describes decisions and evidence needed to move Shallette from a documentation starter to a distributable browser. It does not promise dates or imply that implementation has begun.

## Current phase: 0 — foundation

**Goal:** make the project model and its legal and operational boundaries clear before source is imported or a public release is prepared.

- Decide whether Shallette is a clean-room implementation, a fork, or a downstream build.
- Confirm the intended repository visibility and contribution model.
- Identify likely upstream projects and review their license and trademark requirements.
- Choose a project-wide source license only after provenance and intended distribution are understood.

**Complete when:** the project model, source provenance plan, repository visibility, and initial licensing decisions are written down.

## Phase 1 — product and identity

**Goal:** describe what Shallette should feel like and how it will be distinguishable from upstream projects.

- Approve a concise product brief and design principles.
- Create original name presentation, mark, palette, and interface direction.
- Record the origin and license of each asset intended for distribution.
- Select initial operating systems and processor architectures for evaluation.

**Complete when:** the product brief and identity are reviewed, asset provenance is recorded, and target platforms are named without claiming unverified compatibility.

## Phase 2 — architecture

**Goal:** define an implementation and maintenance approach that can be built and updated responsibly.

- Document the browser engine and component boundaries.
- Define how Shallette changes will be separated from upstream changes.
- Specify update channels, update ownership, and configuration for each planned build variant.
- Record build inputs and the approach to reproducible development and release builds.

**Complete when:** the architecture describes a traceable source revision, an update strategy, and a build plan for each initial target.

## Phase 3 — prototype

**Goal:** produce a reviewable implementation and validate the planned experience on the selected targets.

- Add source code and development instructions.
- Build a prototype from documented inputs.
- Evaluate core navigation, profile handling, accessibility, and platform integration against the approved product brief.
- Record test scope and known limitations alongside the prototype.

**Complete when:** another contributor can follow the documented steps to build the prototype and reproduce the recorded evaluation on a named platform.

## Phase 4 — release readiness

**Goal:** make each distributed build identifiable, supportable, and correctly attributed.

- Publish the supported-version and security-reporting policies.
- Complete third-party license and attribution notices.
- Verify signing and notarization requirements for each target platform.
- Publish release notes, source revision, build provenance, and artifact checksums.
- Confirm that product names, icons, installers, and screenshots use approved Shallette branding.

**Complete when:** every release artifact has a traceable source revision, reviewed notices, documented platform scope, and an active reporting process.

## Scope changes

Update this roadmap when the product model or supported targets change. Keep completed work tied to reviewable evidence; do not mark a phase complete because a document or prototype exists if its stated completion criteria are not met.
