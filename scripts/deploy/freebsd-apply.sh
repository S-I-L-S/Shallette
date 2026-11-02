#!/bin/sh
# Shallette branding for FreeBSD Firefox. Run as root AFTER: pkg install firefox zip
FF=/usr/local/lib/firefox
[ -d "$FF" ] || { echo "firefox не установлен: pkg install firefox zip"; exit 1; }
KIT="$(cd "$(dirname "$0")" && pwd)"
# 1) строковый проход (BSD sed: -i '')
mkdir -p /tmp/shomni && cd /tmp/shomni && rm -rf * && unzip -qo "$FF/browser/omni.ja"
find localization -type f \( -name "*.ftl" -o -name "*.properties" -o -name "*.dtd" \) \
  -exec sed -i '' -E -e 's/^(-brand-(shorter|short|full|product)-name[[:space:]]*=[[:space:]]*).*/\1Shallette/' \
                    -e 's/^(-vendor-short-name[[:space:]]*=[[:space:]]*).*/\1Shallette Atelier/' \
                    -e 's/\bZen\b/Shallette/g' {} +
grep -rl "zen-browser.app" defaults/preferences/firefox-branding.js | xargs sed -i '' 's/zen-browser.app/shallette.example/g'
cat >> defaults/preferences/firefox-branding.js << 'PREFS'

// Shallette badge: updates and telemetry off.
pref("app.update.auto", false);
pref("app.update.enabled", false);
pref("app.update.url", "");
pref("toolkit.telemetry.enabled", false);
pref("toolkit.telemetry.unified", false);
pref("datareporting.healthreport.uploadEnabled", false);
pref("datareporting.policy.dataSubmissionEnabled", false);
PREFS
# 2) бренд-ассеты
cp "$KIT"/branding/* chrome/browser/content/branding/
cp "$KIT"/icons/* browser/chrome/icons/default/ 2>/dev/null || true
# 3) переупаковка
rm "$FF/browser/omni.ja"
zip -qr9X "$FF/browser/omni.ja" .
# 4) ini
sed -i '' -E 's/^Name=Zen$/Name=Shallette/; s/^Vendor=Mozilla$/Vendor=Shallette Project/' "$FF/application.ini"
sed -i '' -E 's/\bZen\b/Shallette/g' "$FF/updater.ini" 2>/dev/null
# 5) обёртка и меню
cat > /usr/local/bin/shallette << 'WRAP'
#!/bin/sh
export MOZ_APP_REMOTINGNAME=shallette
exec /usr/local/bin/firefox -profile "$HOME/.shallette" "$@"
WRAP
chmod 755 /usr/local/bin/shallette
mkdir -p /usr/local/share/applications
sed 's|Exec=.*|Exec=/usr/local/bin/shallette %u|; s|Icon=.*|Icon=shallette|' "$KIT/branding/../shallette.desktop" > /usr/local/share/applications/shallette.desktop 2>/dev/null || cat > /usr/local/share/applications/shallette.desktop << 'DESK'
[Desktop Entry]
Name=Shallette
Comment=Shallette — tuned build of Zen Browser (FreeBSD)
Exec=/usr/local/bin/shallette %u
Terminal=false
Type=Application
Categories=Network;WebBrowser;
Icon=shallette
DESK
mkdir -p /usr/local/share/icons/hicolor/128x128/apps
cp "$KIT/icons/default128.png" /usr/local/share/icons/hicolor/128x128/apps/shallette.png
# 6) пин профиля для прямых запусков
mkdir -p "$HOME/.config/zen"
cat > "$HOME/.config/zen/profiles.ini" << 'INI'
[General]
StartWithLastProfile=1
Version=2

[Profile0]
Name=Shallette
IsRelative=0
Path=/home/shallette-profile
Default=1
INI
echo "Готово. Запуск: shallette (иконка в меню). Профиль: ~/.shallette"
