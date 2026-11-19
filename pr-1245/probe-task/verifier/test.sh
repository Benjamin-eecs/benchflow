#!/bin/bash
probe() {
  echo "[$1] visible CPUs: $(python3 -c 'import os; print(len(os.sched_getaffinity(0)))')"
  echo "[$1] MemTotal: $(( $(awk '/MemTotal/{print $2}' /proc/meminfo) / 1024 )) MiB"
  echo "[$1] OMP_NUM_THREADS=${OMP_NUM_THREADS-unset} PYTHONHASHSEED=${PYTHONHASHSEED-unset} PYTHONPATH=${PYTHONPATH-unset}"
  python3 -c 'import sys; print("['"$1"'] Modal folders on sys.path:", [p for p in sys.path if p.rstrip("/") in ("/pkg", "/root")])'
  echo "[$1] nofile $(ulimit -Sn)/$(ulimit -Hn), stack $(ulimit -Ss)/$(ulimit -Hs) KiB"
  su -s /bin/sh nobody -c 'echo "['"$1"'] su nobody: nofile $(ulimit -Sn)/$(ulimit -Hn), stack $(ulimit -Ss)/$(ulimit -Hs) KiB"' 2>&1
}
mkdir -p /logs/verifier; { cat /app/answer.txt; probe test.sh; } > /logs/verifier/probe.txt 2>&1; echo 1 > /logs/verifier/reward.txt
