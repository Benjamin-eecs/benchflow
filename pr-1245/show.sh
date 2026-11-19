#!/bin/bash
# Prints two live Modal runs of one probe task (oracle, --sandbox modal):
# cpus=2, memory_mb=2048, image ENV OMP_NUM_THREADS=1, BENCHFLOW_MODAL_RLIMITS=1.
# What test.sh saw in the sandbox, on main and on this branch.
b=$'\e[1m'; d=$'\e[2m'; r=$'\e[31m'; g=$'\e[32m'; z=$'\e[0m'
echo "${d}live Modal runs, oracle: cpus=2 memory_mb=2048, Dockerfile ENV OMP_NUM_THREADS=1, BENCHFLOW_MODAL_RLIMITS=1${z}"
echo
echo "${b}main 5a29c66${z} ${d}(what test.sh saw)${z}"
while IFS= read -r l; do echo "  ${r}${l}${z}"; sleep 0.35; done < main.txt
echo
sleep 1
echo "${b}fix/1245-modal-docker-parity${z} ${d}(same task)${z}"
while IFS= read -r l; do echo "  ${g}${l}${z}"; sleep 0.35; done < branch.txt
echo
sleep 1
echo "${b}branch, memory_mb=512, oracle allocates 2 GiB${z}"
echo "  ${g}$(sed -E 's/ \(returncode ([0-9]+):.*/ (returncode \1)/' oom.txt)${z}"
