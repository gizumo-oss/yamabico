#!/bin/bash
git config commit.template .gitmessage
git remote add git@github.com:gizumo-oss/yamabico.git

read -p "Gitのローカル設定を行います。名字と名前をアンダースコア区切りで入力して下さい(ex. Company_Taro): " name
git config user.name $name

read -p "emailアドレスを入力して下さい: " email
git config user.email $email
