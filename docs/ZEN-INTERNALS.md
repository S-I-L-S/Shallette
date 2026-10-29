# Zen Browser internals — reverse-engineering notes

Source: official Zen release **1.23.4b** (BuildID 20261020090730), `zen.linux-x86_64.tar.xz` (113 MB → 408 MB unpacked), dissected on 2026-10-29. Working copy: `~/Проекти/reverse/`. These notes map every place the product identity lives, so the Shallette tuning layer can be written as a precise, checkable checklist.

## 1. Package layout

```
zen/zen/                     ← app root (MOZ_APP_NAME=zen → profile lives in ~/.zen)
  application.ini            ← Name=Zen, Version, Vendor, BuildID, SourceRepository, ID
  update-settings.ini        ← ACCEPTED_MAR_CHANNEL_IDS=release
  updater, updater.ini       ← Mozilla MAR updater binary (ships in the tarball)
  omni.ja                    ← toolkit-level archive (greprefs.js, modules, actors…)
  browser/omni.ja            ← browser UI archive (Zen's real payload)
  libxul-adjacent .so files  ← incl. libmozinference.so, libonnxruntime.so (local AI/ONNX runtime)
```

**Surprise 1:** `Vendor=Mozilla` (not "Zen") in application.ini.
**Surprise 2:** the app ID is Firefox's own `{ec8030f7-c20a-464f-9b0e-13a3a9e97384}`.
**Shallette action:** decide our own app ID deliberately. A unique ID avoids profile/add-on/sync collisions with Firefox and Zen; reusing Firefox's ID buys add-on-compatibility side benefits but is exactly the kind of borrowed identity a tuning house should not keep. Recommendation: own ID + own profile dir (`~/.shallette`).

## 2. The branding surface (complete list)

### 2.1 Strings — one file per locale
`browser/omni.ja → localization/<locale>/branding/brand.ftl` (100+ locales):

```ftl
-brand-shorter-name = Zen
-brand-short-name = Zen
-brand-full-name = Zen Browser
-brand-product-name = Zen Browser
-vendor-short-name = Zen OSS Team
trademarkInfo = { " " }
```

Everything user-visible derives from these five keys. This is the highest-leverage file in the whole operation: rename here and most of the UI follows.

### 2.2 Default prefs — `browser/omni.ja → defaults/preferences/firefox-branding.js`
Startup and update-facing URLs (all on `zen-browser.app`):

- `startup.homepage_override_url` → `/whatsnew?v=%VERSION%`
- `startup.homepage_welcome_url` → `/welcome/`, `…welcome_url.additional` → `/privacy-policy/`
- `app.update.url.manual` → `/download/`, `app.update.url.details` → `/release-notes/latest/`
- `app.releaseNotesURL*` (3 keys) → `/release-notes/…`
- `app.update.promptWaitTime = 691200`

### 2.3 All external endpoints found in both archives
`zen-browser.app`: `/`, `/about`, `/download/`, `/welcome/`, `/whatsnew`, `/privacy-policy/`, `/release-notes/`, `/release-notes/latest/`, `/mods/`, `/donate` (×2), plus `zen-browser.github.io/theme-store/themes/` and `share.zen-browser.app` (Zen share/pocket-like feature). **15 URLs total** — each needs a Shallette decision (own page, neutral page, or removed feature).

### 2.4 Logos and wordmarks — `chrome/browser/content/branding/`
`about-logo.svg`, `about-logo.png/@2x`, `about-logo-private.png/@2x` (private-window variant!), `about-wordmark.svg`, `icon128.png` (+smaller sizes), `document_pdf.svg` (PDF viewer watermark), `updater.png`, and a leftover `firefox-wordmark.svg`. **Shallette action:** the rune mark must be produced in all these slots, including the private-mode variant and the PDF watermark.

### 2.5 UI icon set — `chrome/browser/skin/classic/browser/zen-icons/`
159 generic UI SVGs (back/bookmark/bolt/…). These are **Zen's interface, not Zen's brand** — keep them all untouched. Only the product mark (2.4) changes. This is the concrete line between "atelier respray" and "counterfeit".

## 3. What is actually "Zen" inside (keep list)

- `modules/Zen*.sys.mjs` — 10 system modules (ZenCustomizableUI, ZenUB* URL-bar providers, ZenUIMigration, ZenActorsManager…)
- `chrome/browser/content/browser/zen-components/` — ~25 UI modules (ZenCompactMode, ZenSidebarNotification, ZenGlanceManager, ZenPinnedTabManager, ZenFolders, ZenMods, ZenSessionStore…)
- `zen-styles/zen-theme.css`, `zenThemeModifier.js` (theme palette machinery — our palette hook), `zen-fonts/`, `zen-images/`, `ZenStartup.mjs`, `ZenUIManager.mjs`
- `defaults/preferences/firefox.js` carries the compiled Zen pref set (source: `browser/app/profile/zen.js` + repo's `prefs/zen/*.yaml`), incl. `zen.updates.last-version`, `zen.updates.last-build-id`, `zen.updates.show-update-notification`.

None of this should be touched by Shallette beyond what brand strings reference.

## 4. Update pipeline (how it really works)

- Shipping artifacts include `.mar` files (`linux.mar` 116 MB) + the `updater` binary; `update-settings.ini` locks `ACCEPTED_MAR_CHANNEL_IDS=release`.
- No `app.update.url` pref exists inside the archives — the update URL is **baked at build time** (this is what the source repo's `prefs/zen/updates.yaml` configures; the earlier branding session already patched that file).
- `ZenUpdates.mjs` adds a UX layer: post-update sweep animation + sidebar notification with a **donate link** (remove or repoint for Shallette).

**Shallette action (matches ARCHITECTURE.md "updates later"):** first builds ship with updates off (`app.update.enabled=false`), own MAR channel id (e.g. `shallette-release`) reserved in `update-settings.ini` so a future update server can be introduced without re-shipping. Infrastructure needed later: MAR signing + a Balrog-like update metadata service — the single largest deferred cost of the whole plan.

## 5. Facts to keep in mind

- Zen ships `libonnxruntime.so` + `libmozinference.so` — local inference is inside the binary already; if we don't use it, a build knob may drop it (smaller tarball) — unverified, check `mach` config options.
- Leftover `firefox-wordmark.svg` in branding shows even upstream doesn't fully clean their brand layer — our checklist should sweep, not eyeball.
- `about-logo-private.png` proves a separate private-window logo exists — easy to forget in a rebrand.

## 6. Shallette tuning checklist (derived)

1. `application.ini`: Name=Shallette, Vendor, own app ID, own SourceRepository.
2. `brand.ftl` ×all locales: 5 keys → Shallette strings (scriptable, one pass).
3. `firefox-branding.js`: all `zen-browser.app` URLs → shallette pages or `about:blank` for phase 1.
4. 15 endpoint URLs across both omni.ja — grep-driven sweep, not manual.
5. Branding assets: rune mark into every slot in 2.4 (incl. private + PDF watermark + wordmark).
6. `update-settings.ini`: own channel id; updates disabled until infra exists.
7. Keep untouched: zen-icons/, zen-components/, Zen*.sys.mjs, zen-theme.css — verified by diff-after-patch = only branding files changed.
8. Profile dir `~/.shallette` (MOZ_APP_NAME) — no collision with `~/.zen`.
