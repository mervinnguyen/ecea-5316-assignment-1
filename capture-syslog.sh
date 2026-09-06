#!/bin/bash
# Build the Assignment 1 syslog file: uname -a on line 1, then tagged events
# from the most recent seqgenex0 run only.
set -euo pipefail

OUT="${1:-assignment1-syslog.txt}"
TAG='\[COURSE:2\]\[ASSIGNMENT:1\]'
SINCE="${CAPTURE_SINCE:-30 min ago}"

extract_latest_run() {
  local raw latest
  raw=$(journalctl -t seqgenex0 --since "$SINCE" --no-pager 2>/dev/null || true)
  latest=$(printf '%s\n' "$raw" | grep -oE 'seqgenex0\[[0-9]+\]' | tail -1 || true)
  if [ -n "$latest" ]; then
    printf '%s\n' "$raw" | grep -F "$latest" | grep -E "$TAG" || true
    return
  fi
  if [ -f /var/log/syslog ]; then
    latest=$(grep -E "$TAG" /var/log/syslog | grep -oE 'seqgenex0\[[0-9]+\]' | tail -1 || true)
    grep -E "$TAG" /var/log/syslog | grep -F "$latest" || true
  elif [ -f /var/log/messages ]; then
    latest=$(grep -E "$TAG" /var/log/messages | grep -oE 'seqgenex0\[[0-9]+\]' | tail -1 || true)
    grep -E "$TAG" /var/log/messages | grep -F "$latest" || true
  fi
}

{
  uname -a
  extract_latest_run
} > "$OUT"

echo "Wrote $OUT ($(wc -l < "$OUT") lines)"
echo "Thread 1 starts: $(grep -c 'Thread 1 start' "$OUT" || true)"
echo "Thread 2 starts: $(grep -c 'Thread 2 start' "$OUT" || true)"
echo "Thread 3 starts: $(grep -c 'Thread 3 start' "$OUT" || true)"
echo "---- first lines ----"
head -n 8 "$OUT"
