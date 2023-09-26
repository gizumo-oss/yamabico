import 'package:flutter/material.dart';

class PlayList extends StatelessWidget {
  final String title;
  final String playTime;
  final String playCount;
  final String postDate;
  final bool isPlaying;

  const PlayList({
    Key? key,
    required this.title,
    required this.playTime,
    required this.playCount,
    required this.postDate,
    this.isPlaying = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.access_time, size: 16),
                  Text(playTime),
                ],
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.video_library_outlined),
                    Text(playCount),
                  ],
                ),
                Text(postDate),
              ],
            ),
          ],
        ),
        trailing: IconButton(
          icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
          onPressed: () {
            // TODO 音声再生処理を追加
          },
        ),
      ),
    );
  }
}
