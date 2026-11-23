#!/bin/sh

gdbus monitor --system --dest org.freedesktop.login1 \
    --object-path /org/freedesktop/login1 |
while IFS= read -r line; do
    case "$line" in
        '/org/freedesktop/login1: org.freedesktop.login1.Manager.PrepareForSleep (false,)')
            sleep "${POWERDEVIL_RESUME_DELAY:-3}"
            printf '%s\n' 'Resumed. Restarting PowerDevil if active.'
            systemctl --user try-restart plasma-powerdevil.service
            ;;
    esac
done

exit 1
