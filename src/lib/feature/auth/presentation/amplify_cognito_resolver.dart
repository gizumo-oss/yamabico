import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:flutter/material.dart';

class CustomButtonResolver extends ButtonResolver {
  const CustomButtonResolver();

  @override
  String signIn(BuildContext context) {
    return 'ログイン';
  }

  @override
  String signUp(BuildContext context) {
    return 'アカウント登録';
  }

  @override
  String forgotPassword(BuildContext context) {
    return 'パスワードを忘れた場合';
  }

  @override
  String confirm(BuildContext context) {
    return '登録';
  }

  @override
  String submit(BuildContext context) {
    return '送信';
  }

  @override
  String sendCode(BuildContext context) {
    return '再送信';
  }

  @override
  String lostCode(BuildContext context) {
    return '検証コードが届かない場合';
  }

  @override
  String backTo(BuildContext context, AuthenticatorStep previousStep) {
    switch (previousStep) {
      case AuthenticatorStep.signIn:
        return "ログイン画面へ戻る";
      default:
        return "戻る";
    }
  }
}

class CustomInputResolver extends InputResolver {
  const CustomInputResolver();

  @override
  String title(BuildContext context, InputField field) {
    switch (field) {
      case InputField.username:
        return 'ユーザー名';
      case InputField.email:
        return 'メールアドレス';
      case InputField.password:
        return 'パスワード';
      case InputField.passwordConfirmation:
        return 'パスワード(確認)';
      case InputField.verificationCode:
        return '検証コード';
      default:
        return super.title(context, field);
    }
  }

  @override
  String hint(BuildContext context, InputField field) {
    final fieldName = title(context, field);
    return '$fieldNameを入力してください';
  }

  @override
  String confirmHint(BuildContext context, InputField field) {
    final fieldName = title(context, field);
    final replaceFieldName = fieldName.replaceFirst('(確認)', '');
    return '$replaceFieldNameを再度入力してください';
  }

  @override
  String empty(BuildContext context, InputField field) {
    final fieldName = title(context, field);
    return '$fieldNameを入力してください';
  }
}

class CustomMessagesResolver extends MessageResolver {
  const CustomMessagesResolver();
}

class CustomTitleResolver extends TitleResolver {
  const CustomTitleResolver();

  String signIn(BuildContext context) {
    return 'ログイン';
  }

  String signUp(BuildContext context) {
    return 'アカウント登録';
  }

  @override
  String confirmSignUp(BuildContext context) {
    return '確認';
  }
}

const stringResolver = AuthStringResolver(
  buttons: CustomButtonResolver(),
  inputs: CustomInputResolver(),
  messages: CustomMessagesResolver(),
  titles: CustomTitleResolver(),
);
