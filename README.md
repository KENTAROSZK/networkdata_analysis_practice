# ネットワークデータ解析 実習リポジトリ

このリポジトリは、PyTorch GeometricとNetworkXを使用したネットワークデータ解析の実習用リポジトリです。

## 概要

このリポジトリでは、グラフニューラルネットワーク（GNN）とネットワーク解析の基礎を学習するためのJupyter Notebookが含まれています。

### ディレクトリ構成

- `notebook/`: Jupyter Notebookファイルが格納されています
  - `01.ipynb`: 基本的な実習ノートブック
  - `chap5/`: 第5章の実習
    - `notebook.ipynb`: Coraデータセットを使用したグラフ解析
    - `dataset/`: PyTorch Geometricのデータセット（Coraなど）
- `context/`: Docker環境の設定ファイル
  - `Dockerfile`: 開発環境の定義
  - `docker-compose.yaml`: Docker Compose設定
- `pyproject.toml`: Python依存関係の定義（uvで管理）

### 使用技術

- **Python 3.12**: プログラミング言語
- **PyTorch & PyTorch Geometric**: グラフニューラルネットワークのライブラリ
- **NetworkX**: ネットワーク解析ライブラリ
- **JupyterLab**: インタラクティブな開発環境
- **その他**: pandas, scikit-learn, matplotlib, numpy

## セットアップ方法

### ローカル環境でのセットアップ

このリポジトリはuvを使用してPython環境を管理しています。

```bash
# uvがインストールされていない場合
pip install uv

# 依存関係のインストール
uv sync
```

### Dockerを使ったセットアップ

Dockerコンテナを使って開発環境を構築することもできます。

#### 前提条件

- DockerとDocker Composeがインストールされていること

#### 環境変数の設定とビルド

以下のコマンドで環境変数を設定し、Dockerイメージをビルドして起動します：

```bash
# .envファイルの生成とDockerイメージのビルド・起動
make docker-up
```

または手動で設定する場合：

```bash
# .envファイルを作成
make create-env

# Dockerイメージのビルド
make build

# コンテナの起動（Docker Compose v2の場合）
docker compose -f context/docker-compose.yaml up -d
```

#### コンテナへの接続

```bash
docker compose -f context/docker-compose.yaml exec dev bash
```

コンテナ内には以下のツールがインストールされています：
- Python 3.12 (uv経由で依存関係管理)
- PyTorch & PyTorch Geometric
- JupyterLab
- NetworkX、pandas、scikit-learn、matplotlib等

## Jupyter Notebookの実行

### ローカル環境

```bash
# JupyterLabの起動
uv run jupyter lab
```

### Docker環境

コンテナ内で以下を実行：

```bash
jupyter lab --ip=0.0.0.0 --allow-root
```

ブラウザで `http://localhost:8888` にアクセスしてJupyterLabを使用できます。

## 実習内容

### Chapter 5: グラフデータ解析

`notebook/chap5/notebook.ipynb` では、以下の内容を学習できます：

- PyTorch GeometricのPlanetoidデータセット（Cora）の読み込み
- グラフデータの基本的な操作
- PyTorch GeometricとNetworkX間のデータ変換
- ネットワークの可視化と解析

## 開発環境のカスタマイズ

このリポジトリには、AI支援開発ツールの設定も含まれています：

- `.claude/`: Claude Code の設定
- `.codex/`: Codex CLI の設定
- `Makefile`: 各種セットアップコマンド

### VSCode拡張機能のインストール

```bash
make setup-vscode
```

このコマンドで以下の拡張機能がインストールされます：
- Python関連（ms-python.python, charliermarsh.ruff, ms-python.mypy-type-checker）
- Jupyter（ms-toolsai.jupyter）
- Git Graph
- GitHub Copilot