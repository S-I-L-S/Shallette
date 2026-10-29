# Roadmap

Shallette is a **tuning atelier for browsers**. It takes a complete, working browser and refinishes the visible parts — name, mark, and palette — while the engineering underneath stays with the upstream project. The first base is [Zen Browser](https://github.com/zen-browser/desktop), a fork of Mozilla Firefox on the Gecko engine, released under MPL 2.0. The analogy we work by: Zen is the Mercedes; Shallette is the AMG/Brabus treatment.

Zen's interface and UX are carried over in full. Shallette changes the name, the logo (a rune-like symbol belonging to the project owner), and the palette, which is picked up from the active theme rather than hard-coded.

This roadmap records the decisions already made (marked **Decided**) and the questions still open (marked **Open**). It does not promise dates.

## Foundations

| Area | Status | Decision |
| --- | --- | --- |
| Product model | **Decided** | Tuning atelier over Zen Browser; no clean-room implementation, no separate engine work. |
| Upstream base | **Decided** | Zen Browser (Gecko / Firefox fork), MPL 2.0, `github.com/zen-browser/desktop`. |
| Interface and UX | **Decided** | Zen's interface and UX preserved in full; only name, logo, and palette differ. |
| Distribution model | **Decided** | Free, open-source project. Every build explicitly states its base. |
| Licensing | **Decided** | Source code under MPL 2.0; Shallette trademarks (name, rune mark) remain its own. |
| Build variants | **Decided** | One build per engine. No launcher application. |
| Sync service | **Decided, deferred** | E2E-encrypted synchronization (passwords first) connects later to ready builds; official or self-hosted server. |
| Scrinium line | **Decided** | Separate product line for old and rare systems; a web build is supported only while its engine still receives security updates. |
| Target architectures | **Decided** | x86 (32- and 64-bit), ARM, Apple Silicon, RISC-V. |
| Sync server software | Open | Which server implementation to run and document for self-hosting. |
| Additional engines after Gecko | Open | Which engine defines the second build variant, and on what upstream. |
| Release signing and channels | Open | Signing identities and update channels per platform (see [`RELEASES.md`](RELEASES.md)). |

## Milestone 1 — Linux x86_64 Gecko build

The first practical milestone: a Linux x86_64 build of Shallette on the Zen/Gecko base.

**Scope:**

- Produce a buildable source tree: Zen sources with Shallette branding applied.
- Verify the build locally, end to end, on the primary test machine.
- Run the Shallette-specific checks: name, rune mark, and theme-derived palette appear correctly; everything else behaves as Zen.

**Test matrix:**

| Machine | Role |
| --- | --- |
| Mac Pro 5,1 — openSUSE Tumbleweed, 2× Xeon E5620, 40 GiB RAM | Primary development and validation host |
| Mac Pro 4,1 | Older-hardware validation |
| MSI laptop | Consumer-laptop validation |
| HP 4540s | Budget/legacy laptop validation |

**Status in a third-party environment:** a ChatGPT agent has applied all 263 Zen patches to Firefox 158 sources and completed the Shallette branding pass; the build ran inside that agent's VM, not on this machine. This is real progress, but it is second-hand evidence — treat the build as **not locally verified** until Milestone 1 is reproduced here.

**Complete when:** a locally built Linux x86_64 image passes the branding and behavior checks on the primary test machine, and the build steps are documented well enough for another contributor to repeat them.

## Milestone 2 — Build switching without a launcher

There is no launcher application, and none is planned. Switching between build types happens inside the browser.

**Decided mechanics:**

- A switch starts in **Settings → Updates** and walks the user through a migration wizard.
- The wizard downloads the target build, verifies it, migrates the user profile to it, and launches it.
- The previous build is kept on disk until the new one has started successfully — only then is it retired.

**Complete when:** a user can move between two Shallette build variants (for example Gecko and a second engine) using only this wizard, with profile data intact and a working fallback if the new build fails to start.

## Milestone 3 — Wider architecture coverage

Extend the Gecko build line beyond Linux x86_64:

- Linux x86 32-bit, where the underlying engine still supports it.
- ARM and Apple Silicon builds.
- RISC-V, as engine support matures.

**Open:** which of these ship first, and what the minimum engine version is per architecture. A build is only promised for as long as its engine receives security updates — this constraint applies to every architecture, not just the legacy ones.

## Deferred — Sync service

Synchronization is out of scope for the first builds and connects later to already-shipping ones.

**Decided:** end-to-end encryption, with passwords as the first synchronized data type; users choose between the official server and a self-hosted one. Shallette never sees plaintext sync data.

**Open:** server implementation, account model, and the exact onboarding flow.

## Scrinium — the legacy line

Scrinium is a separate Shallette product line for old and rare systems that mainstream builds no longer serve well.

**Decided:** Scrinium exists as its own line, clearly labeled, with its own base. Its web build is supported exactly as long as its engine keeps receiving security updates — no longer. When the engine goes out of support, the Scrinium build is retired with it, publicly and on schedule.

**Open:** the first Scrinium base and its minimum hardware targets.

## Release readiness

Before any public binary:

- Each artifact names its base explicitly ("Shallette, based on Zen Browser, revision …").
- Third-party license notices are complete under MPL 2.0 obligations; Shallette trademarks are asserted as its own.
- Checksums, source revision, and build provenance are published with each release (see [`RELEASES.md`](RELEASES.md)).
- Screenshots and artwork come from real builds and carry only Shallette branding (see [`BRANDING.md`](BRANDING.md)).

## Scope changes

Update this roadmap when a Decided item changes. Mark new decisions as **Decided** with the reasoning, and move superseded text out rather than letting contradictory statements coexist. Completed work stays tied to reviewable evidence; a milestone is complete when its completion criteria are met, not when a document about it exists.
