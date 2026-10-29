# Engine options for non-Gecko Shallette builds

Status: **draft for decision.** The first build is Gecko/Zen (decided). This document compares candidates for the *second* engine so the choice can be made deliberately, not by momentum. Facts marked *(unverified)* should be re-checked against upstream sources before committing.

The bar for any second build comes from ARCHITECTURE.md: one build per engine, no launcher, Zen-familiar UI, portable profile. In practice "Zen-familiar UI" on a non-Gecko engine means re-implementing Zen's layout language (vertical tabs, sidebar, compact mode) on top of that engine's embedding API — that re-implementation, not the engine, is the real project.

## Candidates

### Servo
- License: MPL 2.0 — clean, same family as our code.
- Embedding story: servo has an embedding API (`libservo`), revived upstream investment; Linux support is real but younger than GTK-WebKit's. *(unverified: current API stability and release cadence in 2026.)*
- "Looks like Zen": must be built from scratch — Servo ships no browser chrome we can reuse. Highest UI cost, but no licensing entanglement and a genuinely independent base.
- Architectures: x86_64, ARM/Apple Silicon plausible; RISC-V experimental. *(unverified)*
- Servo's completeness on heavy modern sites is the practical risk for a daily-driver browser.

### WebKitGTK (and WebKit on other platforms)
- License: LGPL-2.1+ (library) — compatible with an open Shallette; requires careful dynamic-linking obligations, well-understood in Linux packaging.
- Embedding: mature, documented GTK API; a GNOME-grade browser (Epiphany) demonstrates the ceiling.
- "Looks like Zen": moderate cost — WebKitGTK gives you a view, not chrome; sidebar/tabs are ours to build, but platform integration (accelerators, IME, themes) comes cheap.
- Architectures: wherever Linux + WebKit builds: x86, ARM; RISC-V is community. *(unverified)*
- Security updates track WebKit upstream releases — fast but packaging burden is on the distribution/build (this matters for Scrinium policy).

### Blink via Chromium fork (ungoogled-chromium style)
- License: BSD-3 — permissive, legally easy.
- Cost of ownership: brutal. Chromium is ~tens of GB of source, huge build times (days on our 8-core/16-thread Mac Pro), and every security update means rebasing our patch set onto a moving target that moves weekly.
- "Looks like Zen": Chromium chrome/ is C++; Zen-like vertical-tab UX means forking browser UI code that upstream redesigns regularly. Highest maintenance, best site-compat.
- Trademark discipline: upstream Chromium assets must be stripped (ungoogled-chromium shows the sweep needed).

### CEF / system WebView (WebView2, GTK webkit widget)
- Not a browser engine we own — a borrowed one. Rejected for the same reason Shallette exists: the engine would silently change underneath the product per-OS, version drift across users, and security support tied to someone else's runtime. Fine for tooling, wrong for the product line.

## Comparison summary

| Criterion | Servo | WebKitGTK | Blink fork |
| --- | --- | --- | --- |
| License fit | excellent (MPL) | good (LGPL duties) | easy (BSD) |
| UI re-implementation cost | high | medium | high + upstream churn |
| Site compatibility today | weakest | strong | strongest |
| Build/update burden on Mac Pro 5,1 | medium | low–medium | very high |
| Long-term independence | high | medium | low |

## Recommendation

**Second build: WebKitGTK** on Linux first. Rationale: mature embedding API, sane build times on our hardware, security updates track upstream cleanly, and the UI work (the part that makes it "feel like Zen") is exactly the asset Shallette would own and reuse. Defer Servo to an experimental track — it is the most aligned philosophically (MPL, Rust) and worth a prototype once its embedding API stabilizes. **Do not** take a Blink fork unless site-compat pressure on Gecko/WebKit builds becomes existential; the maintenance tax is incompatible with a small atelier.

**Open question (owner):** confirm the second-build target OS (Linux-only at first, or Linux + one more).
