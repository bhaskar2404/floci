#!/usr/bin/env bash
# Usage: source scripts/kubeconfig-floci.sh demo-dev-eks
set -euo pipefail

CLUSTER="${1:-demo-dev-eks}"
OUT="$HOME/floci-k3s.yaml"

CONTAINER=$(docker ps --format '{{.Names}}' | grep "eks-${CLUSTER}" | head -n1)
[ -n "$CONTAINER" ] || { echo "No k3s container found for $CLUSTER"; return 1 2>/dev/null || exit 1; }

PORT=$(docker port "$CONTAINER" 6443/tcp | head -n1 | sed 's/.*://')

docker exec "$CONTAINER" cat /etc/rancher/k3s/k3s.yaml > "$OUT"
sed -i '' "s#https://127.0.0.1:6443#https://localhost:${PORT}#" "$OUT"

export KUBECONFIG="$OUT"
echo "KUBECONFIG=$OUT (container: $CONTAINER, port: $PORT)"
kubectl get nodes