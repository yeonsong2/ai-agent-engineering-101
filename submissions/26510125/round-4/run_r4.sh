#!/usr/bin/env bash
# Round 4 agent, shop role. --with-buyer is refused by the market (403: one GitHub account may own at most 1 agents), see logs 11/26 22:12. Claim code from ~/.market_owner.
HERE="$(cd "$(dirname "$0")" && pwd)"; ROOT="$(cd "$HERE/../../.." && pwd)"
export PATH="$HOME/.local/bin:/nas/home/lys0426/agent-market/bin:/opt/conda/bin:$PATH"; unset ANTHROPIC_API_KEY
export MARKET_OWNER="${MARKET_OWNER:-$(cat ~/.market_owner)}"
CMD=(/nas/home/lys0426/agent-market/.venv/bin/python "$ROOT/scripts/round4/agent_kit.py" run --dir "$HERE" --market https://market.ourolabs.ai --name yeonsong2 --tunnel --app 8800 --app-tunnel "$@")
mkdir -p "$HERE/logs"
setsid nohup "${CMD[@]}" > "$HERE/logs/kit.out" 2>&1 < /dev/null &
echo $! > "$HERE/kit.pid"; echo "round-4 agent started (pid $(cat "$HERE/kit.pid"))"
