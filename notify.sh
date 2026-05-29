#!/usr/bin/env bash
# Cross-platform desktop notification for Claude Code hooks
# Usage: notify.sh <title> <message>
# - Windows 11: BurntToast (pwsh)
# - macOS: osascript
# - Linux: notify-send

TITLE="${1:-Claude Code}"
MESSAGE="${2:-Notification}"

case "$(uname -s)" in
  MINGW*|MSYS*|CYGWIN*|Windows_NT)
    # Windows: use BurntToast via pwsh (native Win11 toast)
    pwsh.exe -NoProfile -Command \
      "New-BurntToastNotification -Text '$TITLE','$MESSAGE' -Sound Default" 2>/dev/null
    ;;
  Darwin)
    # macOS: osascript
    osascript -e "display notification \"$MESSAGE\" with title \"$TITLE\"" 2>/dev/null
    ;;
  Linux)
    # Linux: notify-send
    notify-send --app-name "Claude Code" --expire-time 5000 "$TITLE" "$MESSAGE" 2>/dev/null
    ;;
  *)
    echo "[notification] $TITLE: $MESSAGE"
    ;;
esac

# Push to ntfy
curl -k -d "$TITLE: $MESSAGE" https://qhl123.wicp.net:9265/7VVmF1Zzfmvkn1jY 2>/dev/null &
