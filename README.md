# AI Coding Agents Settings Repository

このリポジトリは、AIコーディングアシスタント「Claude Code」「Codex CLI」の動作設定とテストを行うための実験環境です。

## 概要

このリポジトリには、Claudeアシスタントの動作を定義するための設定ファイルが含まれています。

- `.claude/`: Claudeアシスタントの設定ファイルが格納されています。
  - `settings.json`: ファイルアクセスやコマンド実行の権限など、サンドボックス環境のセキュリティ設定を定義します。
  - `agents/`: Claudeに特定の役割（ペルソナ）を与えるためのプロンプト定義です。
- `.codex/`: Codexに関する設定ファイルが格納されています。
- `Makefile`: セットアップを簡単にするためのコマンドが定義されています。

## セットアップ方法

### 1. エージェントのセットアップ

以下のコマンドを実行すると、`wshobson/agents`リポジトリから最新のエージェント定義を取得し、`.claude/agents/`ディレクトリに配置します。

```bash
make setup_agents
```

### 2. Codex設定のインストール

以下のコマンドを実行すると、このリポジトリに含まれるCodexの設定ファイル（`.codex/config.toml`）をホームディレクトリ（`~/.codex/`）にコピーします。

```bash
make install_codex_config
```