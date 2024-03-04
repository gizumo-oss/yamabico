import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yamabico/component/audio_post.dart';
import 'package:yamabico/component/my_app_bar.dart';
import 'package:yamabico/component/my_music_player.dart';
import 'package:yamabico/feature/posts/presentation/index_screen.dart';

class UserDetailScreen extends StatelessWidget {
  final User user;
  final List<AudioData> userPosts;

  const UserDetailScreen({
    super.key,
    required this.user,
    required this.userPosts,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ItemState>(
      create: (_) => ItemState(),
      child: Scaffold(
        appBar: const MyAppBar(),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Column(
                  children: [
                    Avatar(url: user.avatarUrl, width: 200, height: 200),
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        user.name,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Scrollbar(
                        child: ListView.separated(
                          itemCount: userPosts.length + 1,
                          separatorBuilder: (context, index) {
                            return const Divider();
                          },
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            if (index < userPosts.length) {
                              return AudioPost(
                                index: index,
                                isVisibleAvatar: false,
                                audioData: userPosts[index],
                              );
                            }

                            return const SizedBox(height: 100.0);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: const MyMusicPlayer(),
            ),
          ],
        ),
      ),
    );
  }
}

class User {
  final String _name;
  final String _avatarUrl;

  User(this._name, this._avatarUrl);

  String get name => _name;
  String get avatarUrl => _avatarUrl;
}
