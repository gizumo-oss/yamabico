import 'package:flutter/widgets.dart';
import 'package:yamabico/feature/user/domain/entity/user.dart';

class UserProfile {
  static const myUser = User(
    // TODO 画像のパスを変更する
    image: AssetImage('assets/image/main.jpeg'),
    name: 'やまびこやまびこ 太郎太郎',
    about: '高尾山で毎日やまびこの練習をしています。',
  );
}