import 'package:flutter/widgets.dart';

class User {
  final ImageProvider image;
  final String name;
  final String about;

  const User({
    required this.image,
    required this.name,
    required this.about,
  });
}