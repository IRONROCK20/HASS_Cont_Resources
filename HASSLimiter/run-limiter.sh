#!/usr/bin/env bash
set -e

# Load user options
OPTS=$(cat /data/options.json)
DELAY=$(jq -r '.delay' <<< "$OPTS")

# Build CPU/MEM maps
declare -A CPUS MEM
for name in $(jq -r '.limits | keys[]' <<< "$OPTS"); do
  CPUS[$name]=$(jq -r --arg n "$name" '.limits[$n].cpus' <<< "$OPTS")
  MEM[$name]=$(jq -r --arg n "$name" '.limits[$n].memory' <<< "$OPTS")
done

apply_limits() {
  local cid=$1
  local cname
  cname=$(docker inspect --format='{{.Name}}' "$cid" | sed 's#^/##')
  if [[ -n "${CPUS[$cname]}" ]]; then
    docker update --cpus="${CPUS[$cname]}" --memory="${MEM[$cname]}" "$cid"
  fi
}

# Initial pass
sleep "$DELAY"
for cid in $(docker ps -q); do
  apply_limits "$cid"
done

# Watch for new/updated containers
docker events --filter 'event=start' --filter 'event=update' --format '{{.ID}}' \
  | while read cid; do
      apply_limits "$cid"
    done
