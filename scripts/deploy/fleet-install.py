#!/usr/bin/env python3
"""Fleet installer: Shallette on all LAN machines via SSH password.
Usage: python3 fleet-install.py <ssh-password> [ips...]
Default IPs: 192.168.0.4 192.168.0.12 192.168.0.13 192.168.0.100
Installs Shallette (user-level) AND authorizes the dev host key permanently."""
import sys, os
import paramiko

IPS = sys.argv[2:] or ["192.168.0.4", "192.168.0.12", "192.168.0.13", "192.168.0.100"]
PASSWORD = sys.argv[1]
PUBKEY = open(os.path.expanduser("~/.ssh/id_ed25519.pub")).read().strip()
USER = "liada"
INSTALLER = "curl -sL http://192.168.0.14:8000/install.sh | bash"

def run(ssh, cmd):
    _, out, err = ssh.exec_command(cmd, timeout=300)
    o, e = out.read().decode(errors="replace"), err.read().decode(errors="replace")
    return o + e

for ip in IPS:
    print(f"=== {ip} ===")
    try:
        ssh = paramiko.SSHClient()
        ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        ssh.connect(ip, username=USER, password=PASSWORD, timeout=15, allow_agent=False, look_for_keys=False)
        print(" auth:", run(ssh, "whoami@$(hostname)").strip())
        # навсегда авторизуем наш ключ
        run(ssh, "mkdir -p ~/.ssh && chmod 700 ~/.ssh && grep -qF '%s' ~/.ssh/authorized_keys 2>/dev/null || echo '%s' >> ~/.ssh/authorized_keys; chmod 600 ~/.ssh/authorized_keys" % (PUBKEY, PUBKEY))
        print(" install:", run(ssh, INSTALLER).strip()[:300])
        print(" verify:", run(ssh, "~/shallette/shallette-bin --version 2>&1 | head -1").strip())
        ssh.close()
    except Exception as e:
        print(" FAIL:", str(e)[:120])
