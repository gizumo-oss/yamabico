import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AudioPost extends StatelessWidget {
  final int index;

  const AudioPost({
    super.key,
    required this.index
  });

  @override
  Widget build(BuildContext context) {
    final itemState = Provider.of<ItemState>(context);
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const Avatar(),
          const Content(),
          IconButton(
            icon: itemState.isPlaying(index) ? const Icon(Icons.pause_circle_filled) : const Icon(Icons.play_circle_filled),
            color: const Color.fromRGBO(124, 122, 122, 1.0),
            iconSize: 40,
            onPressed: () => itemState.updatePressed(index)
          )
        ],
      )
    );
  }
}

class ItemState extends ChangeNotifier {
  final Map<int, bool> _playedMap = {};

  bool isPlaying(int index) {
    return _playedMap[index] ?? false;
  }

  void updatePressed(int index) {
    _playedMap[index] = !isPlaying(index);
    _playedMap.forEach((key, value) {
      if(key != index) {
        _playedMap[key] = false;
      }
    });
    safePrint("$index番目の音声再生中");
    notifyListeners();
  }
}


// 投稿者アバター
class Avatar extends StatelessWidget {
  const Avatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 13.0),
      child: const SizedBox(
        width: 70,
        height: 60,
        child: CircleAvatar(
          // TODO: プロフィール画像へ
          backgroundImage: NetworkImage('https://loremflickr.com/320/240'),
        ),
      ),
    );
  }
}

// 投稿内容
class Content extends StatelessWidget {
  const Content({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: const Text('音声タイトル音声タイトル音音声タイトル'),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  flex: 3,
                  child: Contributor()
                ),
                Flexible(
                  flex: 2,
                  child: SizedBox(
                    width: 65,
                    child: PlayTime(),
                  )
                )
              ],
            ),
          ),
          const Row(
            children: [
              Expanded(
                flex: 3,
                child: TotalPlay()
              ),
              Expanded(
                flex: 2,
                child: PostDate()
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// アイコン＋投稿者名
class Contributor extends StatelessWidget {
  const Contributor({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 3.0),
          child: Icon(
            Icons.record_voice_over,
            size: 15
          ),
        ),
        Expanded(
          child: Text(
            'Contributor',
            softWrap: true,
            style: TextStyle(
              fontSize: 15
            ),
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}

// アイコン＋再生時間
class PlayTime extends StatelessWidget {
  const PlayTime({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromRGBO(237, 237, 237, 1.0),
      ),
      padding: const EdgeInsets.fromLTRB(3, 1, 3, 1),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.only(right: 3.0),
            child: const Icon(
              Icons.access_time,
              size: 15,
            ),
          ),
          const Text(
            '15:29',
            style: TextStyle(
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}

// アイコン＋総再生回数
class TotalPlay extends StatelessWidget {
  const TotalPlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.only(right: 3.0),
          child: const Icon(
            Icons.video_library_outlined,
            size: 15
          ),
        ),
        const Expanded(
          child: Text(
            '56',
            softWrap: true,
            style: TextStyle(
              fontSize: 15
            )
          ),
        )
      ],
    );
  }
}

// アイコン＋投稿日時
class PostDate extends StatelessWidget {
  const PostDate({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.only(right: 3.0),
          child: const Text(
            '06/16',
            style: TextStyle(
              fontSize: 15
            ),
          ),
        ),
      ],
    );
  }
}
