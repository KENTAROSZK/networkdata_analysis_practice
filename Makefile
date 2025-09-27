.PHONY: setup_agents clean_agents install_codex_config

AGENTS_DIR := .claude/agents

clean_agents:
	rm -rf $(AGENTS_DIR)
AGENTS_REPO := git@github.com:wshobson/agents.git

setup_agents: clean_agents
	mkdir -p $(dir $(AGENTS_DIR))
	git clone $(AGENTS_REPO) $(AGENTS_DIR)
	rm -rf $(AGENTS_DIR)/.git $(AGENTS_DIR)/.github $(AGENTS_DIR)/.gitignore $(AGENTS_DIR)/examples $(AGENTS_DIR)/LICENSE $(AGENTS_DIR)/README.md

install_codex_config:
	mkdir -p ~/.codex
	cp .codex/config.toml ~/.codex/config.toml
