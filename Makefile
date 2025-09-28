.PHONY: setup_agents clean_agents install_codex_config \ 
		create-env build show-env \
		setup-vscode

# ClaudeCodeエージェントの各種設定ディレクトリ
AGENTS_DIR := .claude/agents
# ホストのユーザー情報を取得
USER_NAME := $(shell whoami)
USER_UID := $(shell id -u)
USER_GID := $(shell id -g)

# .envファイルのパス
ENV_FILE := ./.env

clean_agents:
	rm -rf $(AGENTS_DIR)
AGENTS_REPO := git@github.com:wshobson/agents.git

# ClaudeCodeのエージェントをセットアップする
setup_agents: clean_agents
	mkdir -p $(dir $(AGENTS_DIR))
	git clone $(AGENTS_REPO) $(AGENTS_DIR)
	rm -rf $(AGENTS_DIR)/.git $(AGENTS_DIR)/.github $(AGENTS_DIR)/.gitignore $(AGENTS_DIR)/examples $(AGENTS_DIR)/LICENSE $(AGENTS_DIR)/README.md

# CodeXの設定ファイルをホームディレクトリにコピーし、有効化する
install_codex_config:
	mkdir -p ~/.codex
	cp .codex/config.toml ~/.codex/config.toml

# 環境変数を.envファイルに書き出し
create-env:
	@echo "USER_NAME=$(USER_NAME)" > $(ENV_FILE)
	@echo "USER_UID=$(USER_UID)" >> $(ENV_FILE)
	@echo "USER_GID=$(USER_GID)" >> $(ENV_FILE)
	@echo ".envファイルを作成しました: $(ENV_FILE)"

# Dockerイメージのビルド
build: create-env
	@# Prefer Docker Compose v2; fall back to legacy docker-compose if needed
	@if docker compose version >/dev/null 2>&1; then \
		USER_NAME=$(USER_NAME) USER_UID=$(USER_UID) USER_GID=$(USER_GID) docker compose -f context/docker-compose.yaml build; \
	else \
		USER_NAME=$(USER_NAME) USER_UID=$(USER_UID) USER_GID=$(USER_GID) docker-compose -f context/docker-compose.yaml build; \
	fi

docker-up: build
	@# Prefer Docker Compose v2; fall back to legacy docker-compose if needed
	@if docker compose version >/dev/null 2>&1; then \
		USER_NAME=$(USER_NAME) USER_UID=$(USER_UID) USER_GID=$(USER_GID) docker compose -f context/docker-compose.yaml up -d; \
	else \
		USER_NAME=$(USER_NAME) USER_UID=$(USER_UID) USER_GID=$(USER_GID) docker-compose -f context/docker-compose.yaml up -d; \
	fi

# .envファイルの内容を表示
show-env:
	@echo "USER_NAME: $(USER_NAME)"
	@echo "USER_UID: $(USER_UID)"
	@echo "USER_GID: $(USER_GID)"


# VSCodeの拡張機能をインストールする
setup-vscode:
	@code --install-extension ms-python.python
	@code --install-extension ms-python.mypy-type-checker
	@code --install-extension charliermarsh.ruff
	@code --install-extension Gxl.git-graph-3
	@code --install-extension GitHub.copilot
	@code --install-extension ms-toolsai.jupyter
