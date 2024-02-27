import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';

class MyMusicPlayer extends StatelessWidget {
  const MyMusicPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 25.0,
        vertical: 10.0,
      ),
      height: 140.0,
      decoration: BoxDecoration(
        color: const Color(0xFF13366B).withOpacity(0.9),
      ),
      child: Column(
        children: [
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  // TODO: アイコン差し替え
                  icon: const Icon(Icons.loop),
                  iconSize: 30.0,
                  color: Colors.white,
                  onPressed: () {
                    safePrint('fast forward');
                  },
                ),
                const SizedBox(width: 30.0),
                IconButton(
                  icon: const Icon(Icons.play_circle_outline),
                  iconSize: 40.0,
                  color: Colors.white,
                  onPressed: () {
                    safePrint('play');
                  },
                ),
                const SizedBox(width: 30.0),
                TextButton(
                  onPressed: () {
                    safePrint('change play speed');
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 3.0,
                      ),
                    ),
                    minimumSize: MaterialStateProperty.all(Size.zero),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                    ),
                  ),
                  child: const Text(
                    '1.5x',
                    style: TextStyle(color: Color(0xFF575757)),
                  ),
                ),
              ],
            ),
          ),
          const Center(
            child: Text(
              '音声タイトル',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.0,
              ),
            ),
          ),
          const _MySeekBar(),
        ],
      ),
    );
  }
}

class _MySeekBar extends StatefulWidget {
  const _MySeekBar();

  @override
  State<_MySeekBar> createState() => _MySeekBarState();
}

class _MySeekBarState extends State<_MySeekBar> {
  double? _dragValue;

  String _formatDuration(Duration? duration) {
    if (duration == null) {
      return '--:--';
    }

    String minutes = duration.inMinutes.toString();
    String seconds = duration.inSeconds.toString();

    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 4,
              activeTrackColor: Colors.white,
              inactiveTrackColor: Colors.white.withOpacity(0.2),
              thumbColor: Colors.white,
              thumbShape: const RoundSliderThumbShape(
                disabledThumbRadius: 4,
                enabledThumbRadius: 4,
              ),
              overlayColor: Colors.white,
              overlayShape: const RoundSliderOverlayShape(
                overlayRadius: 10,
              ),
            ),
            child: Slider(
              min: 0.0,
              max: 1,
              value: _dragValue ?? 0.0,
              onChanged: (value) {
                setState(() {
                  _dragValue = value;
                });
              },
            ),
          ),
        ),
        Text(
          _formatDuration(null),
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
