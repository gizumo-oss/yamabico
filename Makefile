################################################################################################
## ローカルで環境開発する際のコマンド
################################################################################################

# setup
.PHONY: setup
setup:
  # Apple Silicon Macの場合はRosettaが必要のため、下記コメントイン
  # sudo softwareupdate --install-rosetta --agree-to-license

  brew tap leoafarias/fvm
  brew install fvm
  brew install cocoapods
  brew link --overwrite cocoapods
  
  echo 'export PATH="$$PATH:$$HOME/.pub-cache/bin"' >> ~/.zshrc
  echo 'export PATH="$$HOME/fvm/default/bin:$$PATH"' >> ~/.zshrc
  source ~/.zshrc

  fvm use stable --force
  fvm global stable
  fvm flutter create .
  fvm flutter doctor
  fvm flutter doctor --android-licenses
