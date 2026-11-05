#!/usr/bin/env bash
#
# Bootstrap a new macOS machine from this dotfiles repo.
#
# Run these by hand first — this script cannot install them, because
# without them you would not have this file:
#
#   1. Homebrew:  /bin/bash -c "$(curl -fsSL \
#        https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
#      ...then run the `brew shellenv` lines it prints.
#   2. chezmoi:   brew install chezmoi
#   3. An SSH key added to GitHub (this repo is private).
#   4. chezmoi init --ssh --apply Bento688
#
# Then:  bash ~/.local/share/chezmoi/bootstrap.sh
#
# Cask installs will prompt for your password. Safe to re-run.

set -uo pipefail

# .zshenv is not read by bash, and the shell that ran `chezmoi init`
# started before .zshenv existed. Without this, `brew bundle --global`
# looks in the wrong place and brew writes its trust store to
# ~/.homebrew/trust.json, which our zsh shells never read.
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

# Don't depend on the caller's PATH.
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

BREWFILE="$XDG_CONFIG_HOME/homebrew/Brewfile"
TPM_DIR="$XDG_CONFIG_HOME/tmux/plugins/tpm"
MASON_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/nvim/mason/packages"

# Mason has no ensure_installed, so the package list lives here.
# Delete this array and the mason step if you'd rather manage it in nvim.
MASON_PACKAGES=(
  black clang-format clangd csharp-language-server css-lsp debugpy delve
  eslint_d gitlab-ci-ls go-debug-adapter goimports google-java-format gopls
  html-lsp intelephense isort java-debug-adapter jdtls js-debug-adapter
  lua-language-server marksman prettier pyright shfmt stylua
  tailwindcss-language-server typescript-language-server yaml-language-server
)

failed=()

say() { printf '\n==> %s\n' "$1"; }

# Steps run in the main shell, not a subshell, so PATH changes from
# brew shellenv and nvm survive into later steps.
run_step() {
  local name="$1"
  shift
  say "$name"
  if "$@"; then
    return 0
  fi
  printf '!!! %s failed\n' "$name" >&2
  failed+=("$name")
  return 1
}

preflight() {
  [ "$(uname -s)" = "Darwin" ] || { echo "macOS only." >&2; return 1; }
  command -v brew >/dev/null || { echo "Homebrew not found. See header." >&2; return 1; }
  [ -f "$BREWFILE" ] || { echo "No Brewfile at $BREWFILE. Run chezmoi init --apply first." >&2; return 1; }
  return 0
}

# --no-upgrade keeps a re-run from upgrading everything already installed.
brew_bundle() {
  brew bundle install --file="$BREWFILE" --no-upgrade
}

setup_node() {
  export NVM_DIR="$HOME/.nvm"
  mkdir -p "$NVM_DIR"
  local nvm_sh
  nvm_sh="$(brew --prefix nvm 2>/dev/null)/nvm.sh"
  [ -s "$nvm_sh" ] || { echo "nvm.sh not found at $nvm_sh" >&2; return 1; }
  # nvm misbehaves under `set -u`.
  set +u
  # shellcheck disable=SC1090
  . "$nvm_sh"
  if ! nvm which default >/dev/null 2>&1; then
    nvm install --lts
  else
    echo "node already present: $(nvm which default)"
  fi
  nvm use default >/dev/null 2>&1 || true
  set -u
}

setup_tmux() {
  if [ ! -d "$TPM_DIR" ]; then
    git clone --depth 1 https://github.com/tmux-plugins/tpm "$TPM_DIR"
  else
    echo "tpm already present"
  fi
  "$TPM_DIR/bin/install_plugins"
}

# `Lazy!` with the bang sets wait=true, so these block until done.
#
# On a machine with no plugins yet, lazy clones everything at HEAD and
# rewrites lazy-lock.json with those commits -- which would silently
# throw away the pinned versions. So keep a copy, let it install, put
# the pinned lockfile back, then restore to it.
setup_nvim_plugins() {
  local lock="$XDG_CONFIG_HOME/nvim/lazy-lock.json"
  local keep
  keep="$(mktemp)"
  cp "$lock" "$keep"

  nvim --headless "+Lazy! install" +qa || true
  cp "$keep" "$lock"
  nvim --headless "+Lazy! restore" +qa
  local rc=$?

  # A successful restore leaves the lockfile alone. If it didn't, the
  # pins weren't applied -- say so instead of quietly papering over it.
  if ! cmp -s "$keep" "$lock"; then
    echo "warning: restore rewrote lazy-lock.json; plugin pins not applied" >&2
    cp "$keep" "$lock"
    rc=1
  fi
  rm -f "$keep"
  return $rc
}

# mason.nvim detects headless mode and installs synchronously,
# exiting non-zero if any package fails.
setup_mason() {
  local missing=()
  local pkg
  for pkg in "${MASON_PACKAGES[@]}"; do
    [ -d "$MASON_DIR/$pkg" ] || missing+=("$pkg")
  done
  if [ ${#missing[@]} -eq 0 ]; then
    echo "all ${#MASON_PACKAGES[@]} mason packages already installed"
    return 0
  fi
  echo "installing ${#missing[@]} missing: ${missing[*]}"
  nvim --headless "+MasonInstall ${missing[*]}" +qa
}

main() {
  preflight || exit 1

  # node must exist before the Brewfile's npm entries can install,
  # and nvm itself comes from the Brewfile — so bundle runs twice.
  run_step "Homebrew packages"      brew_bundle
  run_step "Node (nvm)"             setup_node
  run_step "Homebrew npm packages"  brew_bundle
  run_step "tmux plugins"           setup_tmux
  run_step "nvim plugins"           setup_nvim_plugins
  run_step "nvim LSP/DAP/formatters" setup_mason

  say "Done"
  if [ ${#failed[@]} -gt 0 ]; then
    printf 'Failed steps: %s\n' "${failed[*]}" >&2
    echo "Re-run this script in a NEW shell — some steps need tools that" >&2
    echo "were only just added to PATH (java, dotnet)." >&2
  fi

  cat <<'EOF'

Still manual:
  - Grant Karabiner-Elements and AeroSpace their macOS permissions
    (System Settings > Privacy & Security > Input Monitoring / Accessibility).
  - Open nvim once to let treesitter finish compiling parsers.
EOF

  [ ${#failed[@]} -eq 0 ]
}

main "$@"
