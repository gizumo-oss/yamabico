################################################################################################
## ローカルで環境開発する際のコマンド
################################################################################################

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

	@fvm use stable --force
	@fvm flutter doctor
	@fvm flutter doctor --android-licenses
	@cd src && fvm flutter pub get
	@make devices
	@echo ''
	@make dev-ios

.PHONY: devices
devices:
	@echo ''
	@echo '---------- 起動可能なデバイス ----------'
	@fvm flutter devices
	@echo ※iOS,Androidが表示されない場合は事前にシミュレーターを起動する必要があります
	@echo '----------------------------------------'

.PHONY: clean
clean:
	@fvm flutter clean

.PHONY: dev-ios
dev-ios:
	@open -a Simulator
	@cd src && fvm flutter run -d iPhone

.PHONY: dev-android
dev-android:
	@echo 'WIP'
