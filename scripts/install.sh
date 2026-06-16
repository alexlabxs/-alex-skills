#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
SKILLS_TARGET="${HOME}/.claude/skills"
INSTALLED=0
SKIPPED=0

mkdir -p "$SKILLS_TARGET"

echo "=== Installing alex-skills ==="
echo "Source: ${REPO_DIR}/skills"
echo "Target: ${SKILLS_TARGET}"
echo ""

for skill_dir in "${REPO_DIR}"/skills/*/; do
  skill_name="$(basename "$skill_dir")"
  link_path="${SKILLS_TARGET}/${skill_name}"

  if [ -L "$link_path" ] && [ "$(readlink "$link_path")" = "$skill_dir" ]; then
    echo "  ✓ ${skill_name} already installed"
    SKIPPED=$((SKIPPED + 1))
    continue
  fi

  if [ -e "$link_path" ]; then
    echo "  ⚠ ${skill_name}: target exists but is not our symlink — skipping"
    SKIPPED=$((SKIPPED + 1))
    continue
  fi

  ln -s "$skill_dir" "$link_path"
  echo "  + ${skill_name} installed"
  INSTALLED=$((INSTALLED + 1))
done

echo ""
echo "Done: ${INSTALLED} installed, ${SKIPPED} skipped"
echo "Skills are available at ~/.claude/skills/"
echo "Restart Claude Code or type / to see available skills."
