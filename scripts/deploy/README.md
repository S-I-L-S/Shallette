# Deploy

## Linux (x86_64, user-level, no root)
On any Linux machine in the LAN:
    curl -sL http://192.168.0.14:8000/install.sh | bash
Requires the share server on the dev host: `python3 -m http.server 8000` in `~/www-shallette`.

## FreeBSD (ZOTAC, 15.1)
As root on the machine, after `pkg install firefox zip`:
    fetch http://192.168.0.14:8000/freebsd-branding-kit.tar.gz
    tar xzf freebsd-branding-kit.tar.gz -C /tmp && sh /tmp/apply.sh
Applies the Shallette brand to the FreeBSD Firefox package (omni.ja sweep, assets,
ini edits, wrapper `/usr/local/bin/shallette`, profile pin `~/.shallette`).
