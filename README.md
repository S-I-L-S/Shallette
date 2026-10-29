# Shallette

**An independent browser project with a calm, considered identity.**

Shallette is in early development. This repository contains project documentation and identity assets only; it does not yet include browser source code or a published release. A first badge-edition build (a repack of Zen 1.23.4b, versioned 0.0.1) exists locally — see [`docs/BADGE-EDITION.md`](docs/BADGE-EDITION.md).

## Project status

| Area | Status |
| --- | --- |
| Product and visual direction | Decided — tuning atelier model; rune mark final |
| Browser implementation | Badge edition 0.0.1 exists locally (see [`docs/BADGE-EDITION.md`](docs/BADGE-EDITION.md)); from-source build not yet reproduced |
| Upstream relationship | Decided — Zen Browser is the base |
| Project license | Decided — MPL 2.0 for source code |
| Public release | None yet |

The badge-edition build is not distributed from this repository. No browser capability or compatibility should be inferred from the project name or plans.

## Product direction

Shallette is a tuning atelier for browsers: it takes a complete, working browser — Zen Browser, a fork of Mozilla Firefox — and refinishes the visible parts (name, rune mark, and theme-derived palette) while the engineering underneath stays with the upstream project. The decision is recorded in [`docs/ROADMAP.md`](docs/ROADMAP.md) and [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md).

### Design principles

- **Recognizably Shallette:** create original interface details, visual assets, and product language.
- **Clear provenance:** make the source, upstream revisions, changes, and build inputs traceable.
- **Independent presentation:** describe any technical relationship to other projects accurately and avoid implying endorsement.
- **Evidence-led releases:** document supported systems and release artifacts only after they have been built and verified.

## Roadmap

The project model, upstream base, and architecture decisions are recorded as **Decided** in [`docs/ROADMAP.md`](docs/ROADMAP.md). Current work is **Milestone 1 — a Linux x86_64 Gecko build**; as an interim, non-source path, a badge-edition repack of Zen 1.23.4b already exists (see [`docs/BADGE-EDITION.md`](docs/BADGE-EDITION.md)). The later milestones — build switching without a launcher, wider architecture coverage, the deferred sync service, and the Scrinium legacy line — are planning targets, not delivery commitments.

## Repository guide

- [`docs/ROADMAP.md`](docs/ROADMAP.md) — decided project model, milestones, and open questions.
- [`docs/BRANDING.md`](docs/BRANDING.md) — identity decisions, attribution rules, and asset status.
- [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md) — the decided architecture and remaining open questions.
- [`docs/BADGE-EDITION.md`](docs/BADGE-EDITION.md) — the proven badge-edition rebrand procedure and its known limits.
- [`docs/ENGINES.md`](docs/ENGINES.md) — engine candidates for the second build variant.
- [`docs/SCRINIUM.md`](docs/SCRINIUM.md) — policy for the legacy-systems line.
- [`docs/ZEN-INTERNALS.md`](docs/ZEN-INTERNALS.md) — reverse-engineering notes on Zen's identity surface.
- [`docs/LICENSING.md`](docs/LICENSING.md) — licensing decisions and the checklist required before importing or distributing code.
- [`docs/RELEASES.md`](docs/RELEASES.md) — release information required for future builds.
- [`.github/CONTRIBUTING.md`](.github/CONTRIBUTING.md) — contribution guidance for the current stage.
- [`.github/SECURITY.md`](.github/SECURITY.md) — current security-reporting limitations.

## Relationship to other projects

Zen Browser is the upstream base: Shallette is a tuning layer over Zen, itself a fork of Mozilla Firefox. Shallette is an independent project and is not presented as an official Zen Browser or Mozilla product. Any future relationship statement must match the code and components actually used. See [`docs/BRANDING.md`](docs/BRANDING.md) and [`docs/LICENSING.md`](docs/LICENSING.md).

## License

The source-code license is decided: MPL 2.0 (see [`docs/ROADMAP.md`](docs/ROADMAP.md)); the repository does not yet carry a `LICENSE` file. Review [`docs/LICENSING.md`](docs/LICENSING.md) before adding code or publishing this repository. Do not assume one license will cover source code, artwork, fonts, codecs, and bundled components alike.
