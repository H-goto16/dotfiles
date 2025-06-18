# Variables
GIT_EMAIL ?= h.goto.engineer@gmail.com
GIT_NAME ?= H-goto16
NERD_FONTS_VERSION := v3.4.0
AQUA_VERSION := v2.3.0

# Colors
RED := \033[0;31m
GREEN := \033[0;32m
YELLOW := \033[0;33m
BLUE := \033[0;34m
NC := \033[0m # No Color

# Check if command exists
check_command = @if ! command -v $(1) >/dev/null 2>&1; then \
	echo "$(RED)Error: $(1) is required but not installed.$(NC)"; \
	exit 1; \
fi

# Error handling
define handle_error
	@if [ $$? -ne 0 ]; then \
		echo "$(RED)Error: $1$(NC)"; \
		exit 1; \
	fi
endef

# Default target
.PHONY: setup
setup: check-prerequisites lang get-git-config apt-update-upgrade install-packages brave-browser nerd-fonts stow nvim tmux zsh aqua git-ssh download-links

# Check prerequisites
.PHONY: check-prerequisites
check-prerequisites:
	@echo "$(BLUE)Checking prerequisites...$(NC)"
	$(call check_command,curl)
	$(call check_command,git)
	$(call check_command,sudo)
	@echo "$(GREEN)All prerequisites are satisfied$(NC)"

# System configuration
.PHONY: lang
lang:
	@echo "$(BLUE)Updating language settings...$(NC)"
	LANG=C xdg-user-dirs-gtk-update
	$(call handle_error,"Failed to update language settings")

# Git configuration
.PHONY: get-git-config
get-git-config:
	@echo "$(BLUE)Configuring Git...$(NC)"
	@read -p "Enter your git email [$(GIT_EMAIL)]: " gitEmail; \
	read -p "Enter your git name [$(GIT_NAME)]: " gitName; \
	gitEmail=$${gitEmail:-$(GIT_EMAIL)}; \
	gitName=$${gitName:-$(GIT_NAME)}; \
	git config --global user.email "$$gitEmail" ; \
	git config --global user.name "$$gitName"
	$(call handle_error,"Failed to configure Git")

# System updates
.PHONY: apt-update-upgrade
apt-update-upgrade:
	@echo "$(BLUE)Updating system packages...$(NC)"
	sudo apt update -y  && sudo apt upgrade -y
	$(call handle_error,"Failed to update system packages")

# Package installation
.PHONY: install-packages
install-packages:
	@echo "$(BLUE)Installing packages...$(NC)"
	sudo apt install -y \
		zsh \
		git \
		curl \
		software-properties-common \
		apt-transport-https \
		ca-certificates \
		libgtop2-dev \
		wget \
		gpg \
		htop \
		mpv \
		neovim \
		fzf \
		zoxide \
		bat \
		ripgrep \
		fd-find \
		tmux \
		stow
	$(call handle_error,"Failed to install packages")

# Browser installation
.PHONY: brave-browser
brave-browser:
	@echo "$(BLUE)Installing Brave Browser...$(NC)"
	curl -fsS https://dl.brave.com/install.sh | sh
	$(call handle_error,"Failed to install Brave Browser")

# Font installation
.PHONY: nerd-fonts
nerd-fonts:
	@echo "$(BLUE)Installing Nerd Fonts...$(NC)"
	mkdir -p ~/.local/share/fonts
	curl -L -O https://github.com/ryanoasis/nerd-fonts/releases/download/$(NERD_FONTS_VERSION)/Hack.zip
	unzip Hack.zip -d ~/.local/share/fonts
	fc-cache -fv
	rm Hack.zip
	$(call handle_error,"Failed to install Nerd Fonts")

# SSH configuration
.PHONY: git-ssh
git-ssh:
	@echo "$(BLUE)Configuring SSH...$(NC)"
	mkdir -p ~/.ssh
	touch ~/.ssh/config
	echo 'Host *\n\tIPQoS=0x00' >> ~/.ssh/config
	ssh-keygen -t ed25519 -C "$(GIT_EMAIL)"
	$(call handle_error,"Failed to configure SSH")

# Neovim setup
.PHONY: nvim
nvim:
	@echo "$(BLUE)Setting up Neovim...$(NC)"
	mkdir -p ~/.local/share/nvim/site/autoload
	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	$(call handle_error,"Failed to setup Neovim")

# Tmux setup
.PHONY: tmux
tmux:
	@echo "$(BLUE)Setting up Tmux...$(NC)"
	mkdir -p ~/.tmux/plugins
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
	$(call handle_error,"Failed to setup Tmux")

# Zsh setup
.PHONY: zsh
zsh:
	@echo "$(BLUE)Setting up Zsh...$(NC)"
	curl -sL https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
	$(call handle_error,"Failed to setup Zsh")

# Aqua installation
.PHONY: aqua
aqua:
	@echo "$(BLUE)Installing aqua...$(NC)"
	@if ! command -v aqua >/dev/null ; then \
		curl -sSfL https://raw.githubusercontent.com/aquaproj/aqua-installer/$(AQUA_VERSION)/aqua-installer | bash -s -- -v v2.22.0 ; \
		if [ $$? -ne 0 ]; then \
			echo "$(YELLOW)Retrying aqua installation with direct download...$(NC)"; \
			mkdir -p ~/.local/bin; \
			curl -L -o ~/.local/bin/aqua https://github.com/aquaproj/aqua/releases/download/v2.22.0/aqua_linux_amd64.tar.gz ; \
			tar xzf ~/.local/bin/aqua -C ~/.local/bin ; \
			chmod +x ~/.local/bin/aqua; \
		fi \
	fi
	@echo "$(GREEN)aqua installation completed$(NC)"

# Stow setup
.PHONY: stow
stow:
	@echo "$(BLUE)Setting up dotfiles with stow...$(NC)"
	stow -d stow -t ~ zsh nvim tmux
	$(call handle_error,"Failed to setup dotfiles with stow")

# Download links
.PHONY: download-links
download-links:
	@echo "$(BLUE)=== Download Links ===$(NC)"
	@echo "$(GREEN)Slack:$(NC) https://slack.com/intl/ja-jp/downloads/instructions/linux?ddl=1&build=deb"
	@echo "$(GREEN)Cursor:$(NC) https://www.cursor.com/ja"
	@echo "$(GREEN)Discord:$(NC) https://discord.com/download"
	@echo "$(GREEN)OBS Studio:$(NC) https://obsproject.com/download"