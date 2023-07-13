################################################################################################
## ローカルで環境開発する際のコマンド
################################################################################################

# setup
.PHONY: setup
setup:
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
	@echo ''
	@echo '---------- 起動可能なデバイス ----------'
	@fvm flutter devices
	@echo '----------------------------------------'
	@echo ''
	@echo 'セットアップ完了'
	@echo '以下のコマンドを実行してアプリを起動してください'
	@echo '-----------------------------------------------------------------'
	@echo 'cd src && fvm flutter run --device-id {起動したいデバイスのID}'
	@echo '-----------------------------------------------------------------'
