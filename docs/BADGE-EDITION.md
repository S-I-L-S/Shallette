# Badge edition — rebranding a shipped Zen release without building from source

What it is: take the official Zen tarball, replace the identity layer (strings, logos,
icons, update policy), repack, ship as Shallette. This is the fastest honest path to a
usable Shallette while the from-source build pipeline (see ROADMAP, Milestone 1) matures.
The engine and all Zen functionality remain untouched upstream code.

Proven 2026-10-29 on Zen 1.23.4b Linux x86_64: the result starts, renders, and reports
"Shallette" in UI strings; packaged as `shallette-1.23.4b-linux-x86_64.tar.xz`.

## Procedure

Work on a copy of the unpacked app (`zen/zen/` from the upstream tarball).

1. **Unpack** `browser/omni.ja` (the only archive that carries identity; the root
   `omni.ja` contains no brand strings — leave it untouched). `unzip` warns about
   Mozilla's optimized-zip prelude; extraction completes, exit code is non-zero — ignore.
2. **Locale strings.** For every `localization/<locale>/branding/brand.ftl`, set:
   `-brand-shorter-name/-brand-short-name/-brand-full-name/-brand-product-name` →
   `Shallette`, `-vendor-short-name` → `Shallette Atelier`.
   Then replace the word `Zen` → `Shallette` in all other `.ftl/.dtd/.properties`
   (165+ files; CJK locales need a plain non-boundary replace because `Zen` is glued
   to CJK glyphs). Lowercase `zen` (prefs, CSS) must NOT be touched.
3. **Update policy.** `defaults/preferences/firefox-branding.js`: replace
   `zen-browser.app` → a reserved placeholder domain and append
   `app.update.auto=false`, `app.update.enabled=false`, `app.update.url=""`,
   `zen.updates.show-update-notification=false`.
4. **App metadata.** `application.ini`: `Name=Shallette`, `Vendor=Shallette Project`
   (`RemotingName` handling was revised later — see Round 2 and Round 3b).
   `updater.ini` strings → Shallette.
5. **Assets.** Render the rune mark (single source of truth: the measured vector in
   `assets/logo/`) into every slot: `icon16/32/48/64/128.png`, `about-logo.png(+@2x)`,
   `about-logo-private.png(+@2x)` (indigo tint), `about.png`, `updater.png`,
   window icons at `browser/chrome/icons/default/default*.png`; rewrite
   `about-logo.svg` (white), `document_pdf.svg` (grey), blank `about-wordmark.svg`,
   remove leftover `firefox-wordmark.svg`.
6. **Repack** `browser/omni.ja` as a standard deflate zip (python `zipfile`,
   per-entry `ZipInfo` with 0644 attrs, no zip64, sorted paths). Mozilla's reader
   accepts it; verified by launch.
7. **Rename.** `zen` → `shallette` (binary and top dir) — safe, libs resolve via
   `$ORIGIN`. Add `shallette.desktop` (StartupWMClass=zen; Round 2 sets it to `shallette`).
8. **Verify.** `./shallette --version` (exit 0); headless screenshots of `about:about`
   and `about:support` with an isolated `-profile`; grep the rendered UI for "Shallette".
9. **Package.** `tar cJf shallette-<ver>-linux-x86_64.tar.xz shallette-pkg/`.

## Known limits of the badge edition (honest list)

- `--version` prints the compiled-in display name ("Mozilla Zen …") — binary-level
  string, only changes in a from-source build.
- Remoting/WM class stays `zen`; profile root stays `~/.zen` — run it with an
  explicit `-profile` or accept shared profiles for now.
- Any internal `Zen` strings in compiled JS modules (class names, pref names) are
  deliberately untouched: they are not user-facing and renaming risks breakage.
- The `shallette.example` URLs do not resolve until Shallette web pages exist.

## Round 2 — desktop integration fixes (2026-10-29)

After first launch the owner still saw Zen: the Wayland desktop matched the running
window's app-id `zen` to the installed Zen flatpak, so the dock showed Zen's icon and
"Zen Browser" as the app name — everything *around* the window, not inside it. Fixes:

1. `application.ini` → `RemotingName=shallette` (Wayland app-id; compiled default was `zen`).
2. Installed user-level `shallette.desktop` (`StartupWMClass=shallette`) and the rune
   into `~/.local/share/icons/hicolor/{16..256}/apps/shallette.png`.
3. `about-logo.svg` recolored to `currentColor` (the original Zen asset renders black;
   the white replacement was invisible on light surfaces).
4. Start-page/onboarding strings go through `{ -brand-short-name }` → already Shallette;
   no dedicated start-page logo asset exists in the bundle.

Note: `about:newtab` never finishes rendering under `--headless --screenshot` (Zen start
page waits on interactive state) — verify identity changes in a real window, not headless.

## Round 3 — identity consolidation (2026-10-29, evening)

- **Version 0.0.1**: badge editions are versioned independently from upstream; `application.ini Version=0.0.1`.
- **Canonical profile fixed at `~/.shallette`**: the `shallette` executable is now a wrapper script
  (`shallette` → `shallette-bin -profile ~/.shallette`), so every launch — terminal or desktop file —
  uses the same store. Cause of the "doesn't save anything" report: desktop-file launches without an
  explicit `-profile` created a fresh profile under `~/.config/zen/` (XDG path derived from the compiled
  app name), so data landed in a different profile each time.
- **Panel/taskbar icon**: the owner's watercolor portrait (teal-haired figure) cropped to a face
  square, circular-masked, rendered into icon16–256, window icons, hicolor; the rune stays on
  about-dialog logos and as the text-mark alternative (`assets/logo/`).
- `firefox-wordmark.svg` restored as a blank stub (removing it produced a chrome-URL warning).
- Known compiled-level leftovers: `--version` prints "Mozilla Zen 0.0.1" (string assembled at runtime
  from binary constants), user-agent remains Firefox-based — both change only in a from-source build.

### Round 3b — the real fix for the desktop identity

`RemotingName` in `application.ini` does NOT affect WM_CLASS/Wayland app-id in this build
(verified via an XWayland test window: WM_CLASS stayed `"Navigator", "zen"`). What works is
the environment variable — the wrapper now sets:

```bash
export MOZ_APP_REMOTINGNAME=shallette
```

Verified: WM_CLASS becomes `"Navigator", "shallette"`, so the dock matches
`shallette.desktop` and shows the portrait icon instead of the installed Zen flatpak.
If GNOME still shows a stale icon after this, a relogin refreshes the shell icon cache.
