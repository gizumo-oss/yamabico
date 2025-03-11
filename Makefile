################################################################################################
## ローカルで環境開発する際のコマンド
################################################################################################
.DEFAULT_GOAL := help

help: ## makeコマンドのサブコマンドリストと、各コマンドの説明を表示します
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: setup
setup: ## 環境の構築を行います
	@make git-setup
	@echo 'git setup finished'
	@pnpm install
	@cd client && pnpm install
	@make dev

.PHONY: clean
clean: ## パッケージ・キャッシュの削除を行います
	@cd client && rm -rf node_modules

.PHONY: dev
dev: ## 開発サーバーを起動します(実機で動作確認時に使用)
	@cd client && pnpm run start

.PHONY: dev-i
dev-ios: ## iOSシミュレーターでプロジェクトを起動します
	@open -a Simulator
	@cd client && pnpm run ios

.PHONY: dev-a
dev-android: ## WIP:Androidエミュレーターでプロジェクトを起動します
	@cd client && pnpm run android

.PHONY: test
test: ## テストを実行します
	@cd client && pnpm run test

.PHONY: git-setup
git-setup: ## gitの設定を行います
	$(shell ./.make/setup_git.sh)
