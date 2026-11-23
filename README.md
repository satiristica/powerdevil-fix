# powerdevil-fix

Restarts KDE PowerDevil after suspend. Try using if `systemctl --user restart plasma-powerdevil.service` restores your display brightness (it did for me).

## Install

Reqs: KDE, systemd, `gdbus`. Run from the repo root:

```sh
install -Dm755 powerdevil-fix.sh "$HOME/.local/bin/powerdevil-fix"
install -Dm644 powerdevil-fix.service \
    "${XDG_CONFIG_HOME:-$HOME/.config}/systemd/user/powerdevil-fix.service"
systemctl --user daemon-reload
systemctl --user enable --now powerdevil-fix.service
```

## Configuration

powerdevil is restarted 3 seconds after resume. To change the delay:

```sh
systemctl --user edit powerdevil-fix.service
```

and add:

```ini
[Service]
Environment=POWERDEVIL_RESUME_DELAY=5
```

## Uninstall

```sh
systemctl --user disable --now powerdevil-fix.service
rm "$HOME/.local/bin/powerdevil-fix" \
    "${XDG_CONFIG_HOME:-$HOME/.config}/systemd/user/powerdevil-fix.service"
systemctl --user daemon-reload
```
