################################################################################################
## ローカルで環境開発する際のコマンド
################################################################################################
.DEFAULT_GOAL := help

help: ## makeコマンドのサブコマンドリストと、各コマンドの説明を表示します
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: setup
setup: ## 環境の構築を行います
ifeq ($(shell uname), Darwin)
ifeq ($(shell uname -m), arm64)
	@sudo softwareupdate --install-rosetta --agree-to-license
endif
else
	$(error [ERROR] 現在MacOS以外は対応していません。)
endif

	@result_node=$(shell node --version &> /dev/null && echo $$?); \
	if [ "$$result_node" != 0 ]; then \
		brew install node; \
	fi;

	@result_cocoapods=$(shell pod --version &> /dev/null && echo $$?); \
	if [ "$$result_cocoapods" != 0 ]; then \
		brew install cocoapods; \
		brew link --overwrite cocoapods; \
	fi;

	@make git-setup
	@echo 'git setup finished'
	@npm install -g expo-cli
	@cd src && npm install
	@make devices
	@echo ''
	@make dev-ios

.PHONY: clean
clean: ## パッケージとキャッシュの削除を行います
	@cd src && rm -rf node_modules .expo
	@cd src && npm cache clean --force

.PHONY: dev-ios
dev-ios: ## iOSシミュレーターでプロジェクトを起動します
	@cd src && npm run ios

.PHONY: dev-android
dev-android: ## Androidエミュレーターでプロジェクトを起動します
	@cd src && npm run android

.PHONY: dev-web
dev-web: ## Webブラウザでプロジェクトを起動します
	@cd src && npm run web

.PHONY: start
start: ## Expo開発サーバーを起動します（対話的にプラットフォームを選択可能）
	@cd src && npm start

.PHONY: git-setup
git-setup: ## gitの設定を行います
	$(shell ./.make/setup_git.sh)

.PHONY: install
install: ## npm依存関係をインストールします
	@cd src && npm install

.PHONY: update
update: ## npm依存関係を更新します
	@cd src && npm update

.PHONY: lint
lint: ## TypeScriptの型チェックを行います
	@cd src && npx tsc --noEmit

.PHONY: format
format: ## Prettierでコードをフォーマットします（Prettierがインストールされている場合）
	@cd src && npx prettier --write "**/*.{js,jsx,ts,tsx,json}"

.PHONY: build-ios
build-ios: ## iOS用のビルドを作成します
	@cd src && expo build:ios

.PHONY: build-android
build-android: ## Android用のビルドを作成します
	@cd src && expo build:android
