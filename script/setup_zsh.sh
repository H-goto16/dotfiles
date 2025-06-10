#!/bin/bash

set -e

echo "🛠️ Installing dependencies..."

# zplug
if [ ! -d "$HOME/.zplug" ]; then
  echo "📦 Installing zplug..."
  curl -sL https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi

# CLI Tools
echo "📦 Installing CLI tools..."
if command -v apt &> /dev/null; then
  sudo apt update
  sudo apt install -y fzf zoxide bat exa ripgrep fd-find tmux
elif command -v brew &> /dev/null; then
  brew install fzf zoxide bat exa ripgrep fd tmux
fi

# Zsh plugin completion
mkdir -p ~/.zsh
curl -sL https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh -o ~/.zsh/git-completion.zsh
# p10k 設定（初回のみ）
if [ ! -f "$HOME/.p10k.zsh" ]; then
  echo "🎨 Running p10k configure (press q to skip if you want)..."
  zsh -i -c "p10k configure"
fi

echo "✅ Setup complete! Please run:"
echo ""
echo "    source ~/.zshrc"
echo ""
echo "or restart your terminal."
