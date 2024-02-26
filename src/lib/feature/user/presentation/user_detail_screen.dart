import 'package:flutter/material.dart';
import 'package:yamabico/feature/posts/presentation/index_screen.dart'; // AudioDataを利用するため

class UserDetailScreen extends StatelessWidget {
  final User user; // 表示するユーザー情報
  final List<AudioData> userPosts; // ユーザーの投稿一覧

  const UserDetailScreen(
      {Key? key, required this.user, required this.userPosts})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name), // ユーザー名を表示
      ),
      body: Column(
        children: [
          Text(user.avatarUrl),
          Text(user.name),
          Expanded(
            child: ListView(
              children: userPosts
                  .map((post) => ListTile(
                        leading:
                            Image.network(user.avatarUrl), // ユーザーのプロフィール画像を表示
                        title: Text(post.title), // 投稿のタイトルを表示
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
