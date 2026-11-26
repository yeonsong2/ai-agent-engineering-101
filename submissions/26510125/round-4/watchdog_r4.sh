#!/usr/bin/env bash
# Keep the Round 4 agent alive: every 5 min, restart if the process is gone or the kit log is silent for 20 min.
#   setsid nohup ./watchdog_r4.sh > logs/watchdog.log 2>&1 &
HERE="$(cd "$(dirname "$0")" && pwd)"; LOG="$HERE/logs/agent-kit.log"
while true; do
  pid=$(cat "$HERE/kit.pid" 2>/dev/null); alive=0; [ -n "$pid" ] && kill -0 "$pid" 2>/dev/null && alive=1
  age=$(( $(date +%s) - $(stat -c %Y "$LOG" 2>/dev/null || echo 0) ))
  if [ "$alive" = 0 ] || [ "$age" -gt 1200 ]; then
    echo "$(date '+%F %T') restart: alive=$alive log_age=${age}s"
    [ -n "$pid" ] && kill "$pid" 2>/dev/null; sleep 5; "$HERE/run_r4.sh"; sleep 180
  fi
  sleep 300
done
