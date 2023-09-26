import 'package:flutter/material.dart';
import 'package:yamabico/feature/user/data/user_profile.dart';
import 'package:yamabico/feature/user/presentation/components/play_list.dart';
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
                return PlayList(
                  title: '音楽タイトル $index',
                  playTime: '15:40',
                  playCount: '1,000回',
                  postDate: '10/12',
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
