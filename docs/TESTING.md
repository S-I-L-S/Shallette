# Testing — Shallette badge edition 0.0.1 (Linux x86_64)

Tested 2026-10-29/30 night on the primary host: **Mac Pro 5,1 — openSUSE Tumbleweed,
GNOME Wayland, kernel 7.3.0-1**, 2× Xeon E5620, 40 GiB RAM. Build under test:
`shallette-badge/work/shallette-pkg` (badge edition over upstream Zen 1.23.4b).

## Smoke tests

| # | Test | Result | Notes |
| --- | --- | --- | --- |
| 1 | `--version` exits 0 | **PASS** | Prints `Mozilla Zen 0.0.1` — known compiled-string limitation |
| 2 | Headless render `about:about` | **PASS** | Full page rendered |
| 3 | Headless render `about:support` | **PASS** | UI strings show "Shallette" |
| 4 | Preference persistence across restarts | **PASS** | `user.js` pref → `prefs.js` on run 1 → still present after run 2 |
| 5 | Network + TLS + page render (`https://example.com`) | **PASS** | Full multilingual page rendered headless |
| 6 | Window identity (WM_CLASS via XWayland) | **PASS** | `"Navigator", "shallette"` with `MOZ_APP_REMOTINGNAME=shallette` (wrapper sets it) |
| 7 | Profile isolation | **PASS** | Canonical profile `~/.shallette` via wrapper; no writes to `~/.zen`/`~/.config/zen` |
| 8 | Profile restore drill | **PASS** | 78 cookies (incl. claude.ai session) + 11 saved passwords adopted from `~/.shallette-test` |
| 9 | Desktop integration | **PASS** | `shallette.desktop` matched by GNOME via app-id; portrait icon from hicolor |

## Tuning-layer discipline (diff vs pristine Zen 1.23.4b)

- `browser/omni.ja` content: **221 files changed, 0 outside intended categories**
  (localization, branding assets, firefox-branding.js, window icons).
- Root `omni.ja`: **0 changes**.
- `zen-icons/` (159 UI SVGs) and `zen-components/`: **0 changes** — Zen's interface untouched.
- Localization: **0 files** still containing the word "Zen".
- Loose files: only `application.ini`, `updater.ini`, window icons, `updater.png`,
  renamed binary (`zen` → `shallette-bin` + wrapper), added `shallette.desktop`.

## Shallette 0.0.1 vs upstream Zen 1.23.4b

| Surface | Zen | Shallette 0.0.1 |
| --- | --- | --- |
| Display name (UI) | Zen Browser | Shallette |
| Vendor | Zen OSS Team | Shallette Atelier |
| Window class (app-id) | `zen` | `shallette` (env override) |
| Window title | "Zen" | "Shallette" (verified) |
| Profile root | `~/.zen` / XDG | `~/.shallette` (wrapper-enforced) |
| Icons | Zen circles | Portrait (dock/window), rune (about/private) |
| Updates | MAR `release` channel | Disabled, telemetry off |
| `--version` | `Mozilla Zen 1.23.4b` | `Mozilla Zen 0.0.1` (compiled prefix — source-build item) |
| User agent | Firefox-based | same (compiled — source-build item) |

## Known issues / observations

1. **`--version` prefix** — assembled at runtime from binary constants; no patchable
   literal exists in any `.so`. Changes only in a from-source build.
2. **"Wayland compositor unavailable (gnome)"** — observed graceful shutdowns after
   hours of uptime (log `/tmp/shallette-run*.log`). Environment issue (GNOME + driver,
   same family as the known r600 flicker on this machine); affects any Firefox-family
   browser here, not specific to Shallette.
3. `about:newtab` never settles under `--headless --screenshot` (interactive start page) —
   verify identity in real windows instead.
4. Test matrix beyond this host (Mac Pro 4,1, MSI laptop, HP 4540s) is **pending owner
   hardware access**.

## How to re-run

```bash
P=~/Проекти/shallette-badge/work/shallette-pkg
$P/shallette --version
timeout 60 $P/shallette-bin -profile /tmp/p1 --headless --screenshot /tmp/a.png about:about
timeout 90 $P/shallette-bin -profile /tmp/p1 --headless --screenshot /tmp/n.png https://example.com
# window identity:
GDK_BACKEND=x11 $P/shallette-bin -profile /tmp/p2 about:blank & then xprop WM_CLASS
```
