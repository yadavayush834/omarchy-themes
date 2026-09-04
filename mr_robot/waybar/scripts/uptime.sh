#!/bin/bash

set -euo pipefail

read -r uptime_seconds _ </proc/uptime
uptime_seconds="${uptime_seconds%%.*}"

days=$((uptime_seconds / 86400))
hours=$(((uptime_seconds % 86400) / 3600))
minutes=$(((uptime_seconds % 3600) / 60))

if ((days > 0)); then
  printf 'UP %02dD:%02dH\n' "${days}" "${hours}"
else
  printf 'UP %02dH:%02dM\n' "${hours}" "${minutes}"
fi
