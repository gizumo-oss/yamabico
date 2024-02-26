import 'package:flutter/material.dart';
import 'package:yamabico/component/my_app_bar.dart';
import 'package:yamabico/feature/posts/presentation/index_screen.dart';
import 'package:yamabico/component/audio_post.dart';
import 'package:yamabico/component/my_music_player.dart';

class UserDetailScreen extends StatelessWidget {
  final User user;
  final List<AudioData> userPosts;

  const UserDetailScreen(
      {Key? key, required this.user, required this.userPosts})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(),
        body: Stack(children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
                child: Column(children: [
              Avatar(url: user.avatarUrl, width: 200, height: 200),
              Container(
                padding: const EdgeInsets.all(20),
                child: Text(
                  user.name,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Scrollbar(
                      child: ListView.separated(
                    itemCount: userPosts.length + 1,
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    itemBuilder: (context, index) {
                      if (index < userPosts.length) {
                        return Row(children: [
                          SizedBox(
                            width: 300,
                            child: Content(
                                title: userPosts[index].title,
                                name: userPosts[index].user.name,
                                time: userPosts[index].playTime,
                                count: userPosts[index].count,
                                date: userPosts[index].date),
                          ),
                          Container(
                            width: 70,
                            alignment: Alignment.centerRight,
                            child: const AudioPostWidget(),
                          )
                        ]);
                      }
                      return const SizedBox(height: 100.0);
                    },
                  )),
                ),
              )
            ])),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: const MyMusicPlayer(),
          ),
        ]));
  }
}

class User {
  final String _name;
  final String _avatarUrl;

  User(this._name, this._avatarUrl);

  String get name => _name;
  String get avatarUrl => _avatarUrl;
}

class AudioPostWidget extends StatefulWidget {
  const AudioPostWidget({super.key});

  @override
  UserDetailScreenState createState() => UserDetailScreenState();
}

class UserDetailScreenState extends State<AudioPostWidget> {
  bool _isPlaying = false;

  void isPlaying() {
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: _isPlaying
            ? const Icon(Icons.pause_circle_filled)
            : const Icon(Icons.play_circle_filled),
        color: const Color.fromRGBO(124, 122, 122, 1.0),
        iconSize: 40,
        onPressed: () => isPlaying());
  }
}
