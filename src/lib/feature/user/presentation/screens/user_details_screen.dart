import 'package:flutter/material.dart';
import 'package:yamabico/feature/user/data/user_profile.dart';
import 'package:yamabico/feature/user/presentation/components/profile.dart';

class UserDetailsScreen extends StatefulWidget {
  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final user = UserProfile.myUser;

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            floating: false,
            pinned: true,
          ),
          // プロフィール
          SliverList(
            delegate: SliverChildListDelegate(
              [
                ProfileWidget(
                  image: user.image,
                ),
                Center(child: Text(user.name, style: TextStyle(fontSize: 24))),
                Center(child: Text(user.about)),
              ],
            ),
          ),
          // 投稿した音声の一覧
          SliverFixedExtentList(
            itemExtent: 100.0,
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ListTile(
                  title: Text('音声タイトル $index'),
                  subtitle: Text('詳細 $index'),
                );
              },
              childCount: 100,
            ),
          ),
        ],
      ),
    );
  }
}
