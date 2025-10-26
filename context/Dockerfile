FROM ubuntu:22.04

# 環境変数を読み込む
ARG USER_NAME
ARG USER_UID
ARG USER_GID

# 必要なパッケージのインストール
RUN apt-get update && \
    apt-get install -y curl \
    git \
    make \
    sudo \
    unzip \
    build-essential \
    && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# ユーザーとグループの作成（既存のGID/UIDがある場合にも対応）
RUN set -eux; \
    if ! getent group "${USER_GID}" >/dev/null; then \
        groupadd --gid "${USER_GID}" "${USER_NAME}"; \
    fi; \
    if ! id -u "${USER_NAME}" >/dev/null 2>&1; then \
        useradd --uid "${USER_UID}" --gid "${USER_GID}" -m -s /bin/bash "${USER_NAME}"; \
    else \
        usermod -u "${USER_UID}" -g "${USER_GID}" "${USER_NAME}" || true; \
    fi; \
    echo "${USER_NAME} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# ユーザー切り替え
USER ${USER_NAME}
WORKDIR /home/${USER_NAME}

# nvm + Node.js インストール
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
ENV NVM_DIR="/home/${USER_NAME}/.nvm"
RUN \. "$NVM_DIR/nvm.sh" && nvm install 22

# ユーザーのローカルbinをPATHに追加（uvなどのローカルインストール用）
ENV PATH="/home/${USER_NAME}/.local/bin:$PATH"

# uv インストール
RUN curl -LsSf https://astral.sh/uv/install.sh | sh

# Python 3.12 インストール
RUN \. "$NVM_DIR/nvm.sh" && uv python install 3.12

# 各AI CLIツールのインストール
RUN \. "$NVM_DIR/nvm.sh" && nvm use 22 && npm install -g @google/gemini-cli @anthropic-ai/claude-code @openai/codex @github/copilot

# OpenCode AI インストール
RUN curl -fsSL https://opencode.ai/install | bash

# Jupyterのインストール（uvで仮想環境を作成してインストール）
ENV VENV_DIR=/home/${USER_NAME}/.venv/jupyter
RUN uv venv "$VENV_DIR" && \
    uv pip install --python "$VENV_DIR/bin/python" jupyterlab ipykernel
ENV PATH="$VENV_DIR/bin:$PATH"

# ✅ Jupyter の設定ファイルを生成して永続化（これをしておいた方がリモートサーバでjupyter接続でつまづかずに済む）
RUN jupyter server --generate-config && \
    echo "c.ServerApp.ip = '0.0.0.0'\n\
c.ServerApp.port = 8888\n\
c.ServerApp.allow_origin = '*'\n\
c.ServerApp.allow_remote_access = True\n\
c.ServerApp.disable_check_xsrf = True\n\
c.ServerApp.open_browser = False\n\
c.ServerApp.token = ''" >> /home/${USER_NAME}/.jupyter/jupyter_server_config.py

# ワークスペースに移動（バインドマウント先）
WORKDIR /home/${USER_NAME}/workspace