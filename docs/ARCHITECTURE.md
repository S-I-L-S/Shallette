# Architecture

Shallette is a **tuning atelier over Zen Browser**, not a browser engine project. This document describes the architecture that follows from that decision: what we change, what we deliberately do not touch, and how the pieces fit together.

Status markers: **Decided** items are settled project decisions; **Open** items still need answers. This document describes the planned and in-progress implementation, not a shipped release.

## Positioning

**Decided.** Shallette takes Zen Browser — a fork of Mozilla Firefox on the Gecko engine, MPL 2.0, [`github.com/zen-browser/desktop`](https://github.com/zen-browser/desktop) — and re-finishes it. The relationship is the one between a carmaker and its tuning house: Zen is the Mercedes; Shallette is AMG/Brabus. The base does the engineering; Shallette does the identity.

Concretely, Shallette changes exactly three things and nothing else:

- **Name** — Shallette replaces Zen wherever the product presents itself.
- **Logo** — a rune-like symbol belonging to the project owner, used for the application icon and product mark.
- **Palette** — derived from the active theme at runtime rather than fixed at build time.

Zen's interface and UX are preserved in full. Layout, features, preferences, and interaction patterns come from upstream; a user moving from Zen to Shallette should feel at home immediately. Any change that would alter Zen's UX is out of scope by definition and belongs upstream.

## Upstream relationship and change management

**Decided.** Shallette maintains its identity work as a small, traceable layer on top of upstream:

- Shallette-specific changes (branding strings, assets, palette logic) are kept as a distinct patch set or branch, never intermixed with upstream code.
- Each build records the exact upstream revision it was produced from.
- When upstream ships security updates, Shallette rebases its layer onto the new revision and rebuilds. The tuning layer is kept small precisely so this stays cheap.

**Open:** whether the layer is maintained as a patch series against Zen or as a fork branch, and how often rebases track upstream.

## Build model: one build per engine, no launcher

**Decided.** Each browser engine gets its own self-contained build. There is no launcher application, no multi-engine wrapper, and none is planned. One install, one engine, one binary doing one job well.

Consequences:

- Every artifact is a complete, independently installable browser.
- A build's identity is explicit: "Shallette, Gecko edition, based on Zen Browser, revision …" is printed in the product itself, not inferred.
- Engine selection happens through build switching (below), not through a runtime menu.

## Build switching via Settings → Updates

**Decided.** Switching build types is a first-class flow inside the browser, driven from **Settings → Updates**:

1. The user picks the target build type.
2. The migration wizard downloads the new build and verifies it before anything else happens.
3. The wizard migrates the user profile to the new build.
4. The new build launches. The old build is kept on disk until this point is reached successfully.
5. Only after the new build has started does the old one get retired.

The design goal is simple: a failed switch must never leave the user without a working browser. The old build is the fallback until the new one proves itself.

**Open:** exact rollback behavior if the new build launches but then misbehaves, and how profile migrations between different engine generations are validated.

## Sync service — deferred

**Decided, deferred.** Synchronization is excluded from the first builds and connects later as an add-on to already-shipping builds:

- End-to-end encryption; the server stores only ciphertext.
- Passwords are the first synchronized data type.
- Users choose between the official Shallette server and a self-hosted one.

Because sync arrives after the builds it serves, the browser must be structured so sync is a pluggable capability, not a build-time assumption. Account and server components are documented here once designed.

**Open:** server implementation, account model, key recovery UX.

## Scrinium — the legacy line

**Decided.** Scrinium is a separate Shallette product line for old and rare systems. It is architecturally independent from the main line: its own base, its own supported-hardware envelope, its own lifecycle.

The lifecycle rule is strict: a Scrinium web build is supported only while its engine receives security updates. When the engine's support ends, the Scrinium build is retired — publicly, with notice, and without exceptions.

**Open:** the first Scrinium base and minimum hardware targets.

## Target architectures

**Decided.** The project targets:

- x86, 32-bit and 64-bit
- ARM
- Apple Silicon
- RISC-V

The first practical milestone narrows this to a Linux x86_64 Gecko build (see [`ROADMAP.md`](ROADMAP.md)). Wider coverage follows as each architecture proves buildable on top of the current engine — with the standing constraint that no build is promised beyond its engine's security-support window.

## Licensing and trademarks

**Decided.** Shallette is a free, open-source project.

- Source code is released under MPL 2.0, matching the upstream stack (Zen is MPL 2.0; Gecko/Firefox files carry their own notices, inventoried per release).
- The Shallette name and the rune mark are Shallette's own trademarks — asserted by Shallette, not derived from or granted by upstream.
- Every build explicitly states its base. Attribution is a feature, not a footnote.

The detailed checklist lives in [`LICENSING.md`](LICENSING.md); branding rules and the upstream-attribution statement in [`BRANDING.md`](BRANDING.md).

## Current implementation status

Where things actually stand:

- A ChatGPT agent has applied **all 263 Zen patches to Firefox 158 sources** and completed the Shallette branding pass. The build ran inside **that agent's VM** — not on this machine — so the from-source build is validated second-hand and remains locally unverified.
- Meanwhile, a **badge edition** exists: an identity-layer repack of the official Zen 1.23.4b Linux x86_64 release, versioned **0.0.1** (brand strings replaced, rune/portrait icons, canonical profile `~/.shallette`, updates disabled, `MOZ_APP_REMOTINGNAME=shallette`). It starts and renders; its known limits are documented in [`BADGE-EDITION.md`](BADGE-EDITION.md).

The next concrete step for the from-source line is reproducing the build locally on the primary test machine (Mac Pro 5,1, openSUSE Tumbleweed, 2× Xeon E5620, 40 GiB RAM) as Milestone 1 of the [`ROADMAP.md`](ROADMAP.md).

## Planned documentation

As implementation lands, this document grows into:

- concrete component diagrams (identity layer, palette logic, update/migration wizard, sync connector);
- per-variant build instructions and configuration;
- `THIRD_PARTY_NOTICES.md` with the full component inventory;
- release provenance rules in [`RELEASES.md`](RELEASES.md).
