import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF5A606C),
      leadingWidth: 140,
      leading: Center(
        child: TextButton.icon(
          onPressed: () {
            Navigator.pushNamed(context, '/posts');
          },
          icon: SvgPicture.asset(
            'assets/image/gizumo-logo.svg',
            width: 30.0,
          ),
          label: const Text(
            'やまびこ',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        ),
      ),
      actions: const <Widget>[
        _CustomIconButton(
          icon: Icons.info_outline,
          label: '注目',
          moveTo: '/',
        ),
        _CustomIconButton(
          icon: Icons.manage_search_outlined,
          label: '探す',
          moveTo: '/',
        ),
        _CustomIconButton(
          icon: Icons.library_music_outlined,
          label: 'ライブラリ',
          moveTo: '/',
        ),
        _CustomIconButton(
          icon: Icons.account_box_outlined,
          label: 'マイページ',
          moveTo: '/',
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}

class _CustomIconButton extends StatelessWidget {
  final IconData icon;
  final String label;
  // TODO:`main.dart`の`routes`のキーのユニオン型に限定したい
  final String moveTo;

  const _CustomIconButton({required this.icon, required this.label, required this.moveTo});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Column(
        children: [
          Icon(
            icon,
            size: 25.0,
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 8.0,
            ),
          ),
        ],
      ),
      iconSize: 45.0,
      onPressed: () {
        safePrint('$label is clicked');
        Navigator.pushNamed(context, moveTo);
      },
    );
  }
}
