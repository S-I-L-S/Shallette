# Scrinium — the old and rare systems line

Scrinium is Shallette's separate product line for old and rare systems. It exists because the main line follows current engines, and current engines drop old platforms. This document fixes the policy and the honest platform map. Facts marked *(unverified)* need a fresh check before any build promise.

## Policy (Decided)

1. A Scrinium build is **supported for web use only while its engine still receives security updates**. When the engine's upstream stops patching, the build moves to *frozen*: usable offline/for trusted intranets, explicitly flagged as unsafe for the public web in its release notes and UI.
2. Scrinium builds **do not hold back the main line**: no shared release train, no feature parity promise with current Shallette.
3. Every Scrinium release names its engine and the exact last security-patched revision it carries.
4. No claims of "modern web on any hardware". The line's identity is *honest longevity*, not nostalgia marketing.

## Platform map (2026 snapshot)

| Platform | Last engine with security patches | Status | Practical route |
| --- | --- | --- | --- |
| Windows 10+ x64 | current Gecko/Chromium/WebKit | supported (main line) | main Shallette builds |
| Windows 10+ x86 (32-bit) | Chromium dropped 32-bit Win; Firefox ESR status *(unverified)* | limited | Gecko ESR 32-bit if still shipped; else frozen |
| Windows 7/8.1 | Firefox ESR 115 ended updates 2024–2025 *(unverified exact end)* | frozen for web | final ESR build, clearly flagged |
| macOS 11+ (incl. Mac Pro 4,1/5,1 via OpenCore/patched) | current Firefox-family builds; Metal-capable GPUs required by newer versions *(unverified cutoffs)* | supported | main-line Gecko; test on 4,1/5,1 with patched macOS |
| macOS 10.x stock (Mac Pro 4,1/5,1 without OpenCore) | Firefox ESR 115-era | frozen for web | legacy build line |
| Linux x86_64 | current everything | supported (main line) | primary dev target |
| Linux x86 32-bit | community; Firefox 32-bit Linux builds status *(unverified)* | limited/frozen | WebKitGTK or Gecko where distro still ships |
| Linux ARM (armv7/aarch64) | current | supported | WebKitGTK path (see ENGINES.md) |
| RISC-V | experimental upstreams | experimental | no promises; prototype track only |

## Community precedents (reference only, not Shallette products)

- Post-ESR "keep it running" projects for XP/Vista era existed on Firefox and Chromium bases; all ended at *frozen*, which is precisely the state our policy names honestly.
- OpenCore Legacy Patcher community keeps 2008–2012 Macs on current macOS — relevant for Mac Pro 4,1/5,1 owners who want a *main-line* browser rather than Scrinium.

## What Scrinium is NOT

- Not a promise to run the current engine on unsupported hardware.
- Not a security product: a frozen build is a compromise, stated plainly.
- Not a dumping ground: each Scrinium target needs one named maintainer or it ships frozen-only.
