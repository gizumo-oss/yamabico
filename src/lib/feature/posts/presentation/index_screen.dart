import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yamabico/component/audio_post.dart';
import 'package:yamabico/component/my_app_bar.dart';
import 'package:yamabico/component/my_music_player.dart';

class IndexScreen extends StatelessWidget {
  const IndexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<AudioData> audioPost = [
      AudioData(
          '音声タイトル音声タイトル音音声タイトル',
          User('Contributor', 'https://loremflickr.com/320/240'),
          '56',
          '15:29',
          '06/16'),
      AudioData(
          '音声タイトル音声タイトル音音声タイトル',
          User('Contributor', 'https://loremflickr.com/320/240'),
          '56',
          '15:29',
          '06/16'),
    ];
    return ChangeNotifierProvider<ItemState>(
      create: (_) => ItemState(),
      child: Scaffold(
        appBar: const MyAppBar(),
        body: Stack(
          children: [
            Scrollbar(
                child: ListView.separated(
              itemCount: audioPost.length + 1,
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemBuilder: (context, index) {
                if (index < audioPost.length) {
                  return AudioPost(
                    index: index,
                    audioData: audioPost[index],
                  );
                }
                return const SizedBox(height: 100.0);
              },
            )),
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

class AudioData {
  final String _title;
  final User _user;
  final String _count;
  final String _playTime;
  final String _date;

  AudioData(
    this._title,
    this._user,
    this._count,
    this._playTime,
    this._date,
  );

  String get title => _title;
  User get user => _user;
  String get count => _count;
  String get playTime => _playTime;
  String get date => _date;
}

class User {
  final String _name;
  final String _avatarUrl;

  User(this._name, this._avatarUrl);

  String get name => _name;
  String get avatarUrl => _avatarUrl;
}
