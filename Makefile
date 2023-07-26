################################################################################################
## ローカルで環境開発する際のコマンド
################################################################################################
.DEFAULT_GOAL := help

help: ## makeコマンドのサブコマンドリストと、各コマンドの説明を表示します
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY := setup
setup: ## 環境の構築を行います
ifeq ($(shell uname), Darwin)
ifeq ($(shell uname -m), arm64)
	@sudo softwareupdate --install-rosetta --agree-to-license
endif
else
	$(error [ERROR] 現在MacOS以外は対応していません。)
endif

	@result_fvm=$(shell fvm --version &> /dev/null && echo $$?); \
	if [ "$$result_fvm" != 0 ]; then \
		brew tap leoafarias/fvm; \
		brew install fvm; \
	fi;

	@result_cocoapods=$(shell pod --version &> /dev/null && echo $$?); \
	if [ "$$result_cocoapods" != 0 ]; then \
		brew install cocoapods; \
		brew link --overwrite cocoapods; \
	fi;

	@echo 'export PATH="$$PATH:$$HOME/.pub-cache/bin"' >> $(ZDOTDIR)/.zshrc
	@echo 'export PATH="$$HOME/fvm/default/bin:$$PATH"' >> $(ZDOTDIR)/.zshrc
	$(shell source ${ZDOTDIR}/.zshrc)

	@fvm use stable --force
	@fvm flutter doctor
	@fvm flutter doctor --android-licenses
	@cd src && fvm flutter pub get
	@make devices
	@echo ''
	@make dev-ios

.PHONY := devices
devices: ## 起動可能なデバイスを表示します
	@echo ''
	@echo '---------- 起動可能なデバイス ----------'
	@fvm flutter devices
	@echo ※iOS,Androidが表示されない場合は事前にシミュレーターを起動する必要があります
	@echo '----------------------------------------'

.PHONY := clean
clean: ## パッケージの削除を行います
	@fvm flutter clean

.PHONY: dev-ios
dev-ios: ## iOSシミュレーターでプロジェクトを起動します
	@open -a Simulator
	@cd src && fvm flutter run -d iPhone

.PHONY := dev-android
dev-android: ## WIP:Androidエミュレーターでプロジェクトを起動します
	@echo 'WIP'
