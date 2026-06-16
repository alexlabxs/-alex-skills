#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
SKILLS_TARGET="${HOME}/.claude/skills"
REMOVED=0

echo "=== Uninstalling alex-skills ==="

for skill_dir in "${REPO_DIR}"/skills/*/; do
  skill_name="$(basename "$skill_dir")"
  link_path="${SKILLS_TARGET}/${skill_name}"

  if [ -L "$link_path" ] && [ "$(readlink "$link_path")" = "$skill_dir" ]; then
    rm "$link_path"
    echo "  - ${skill_name} removed"
    REMOVED=$((REMOVED + 1))
  fi
done

echo ""
echo "Done: ${REMOVED} skills removed"
echo "Skills that were not ours were left untouched."
