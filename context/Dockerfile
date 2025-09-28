Dockerfile
# syntax=docker/dockerfile:1
FROM ubuntu:22.04

# 環境変数を読み込む
ARG USER_NAME
ARG USER_UID
ARG USER_GID

# 必要なパッケージのインストール
RUN apt-get update && \
    apt-get install -y curl git make sudo && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# ユーザーとグループの作成
RUN groupadd --gid ${USER_GID} ${USER_NAME} && \
    useradd --uid ${USER_UID} --gid ${USER_GID} -m -s /bin/bash ${USER_NAME} && \
    echo "${USER_NAME} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# ユーザー切り替え
USER ${USER_NAME}
WORKDIR /home/${USER_NAME}

# nvm + Node.js インストール
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
ENV NVM_DIR="/home/${USER_NAME}/.nvm"
RUN \. "$NVM_DIR/nvm.sh" && nvm install 22

# PATHにNode.jsとnpmを追加
ENV PATH="$NVM_DIR/versions/node/v22.20.0/bin:$PATH"

# uv インストール
RUN curl -LsSf https://astral.sh/uv/install.sh | sh

# Python 3.12 インストール
RUN \. "$NVM_DIR/nvm.sh" && uv python install 3.12

# 各AI CLIツールのインストール
RUN npm install -g @google/gemini-cli @anthropic-ai/claude-code @openai/codex @github/copilot

# Jupyterのインストール（uv経由で）
RUN \. "$NVM_DIR/nvm.sh" && uv pip install jupyter

# ワークスペースに移動（バインドマウント先）
WORKDIR /workspace