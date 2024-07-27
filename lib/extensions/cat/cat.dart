import 'package:omegaui/extensions/cat/loader/cat_activity.dart';
import 'package:omegaui/extensions/cat/loader/cat_loader.dart';
import 'package:omegaui/extensions/cat/player/cat_player.dart';
import 'package:flutter/material.dart';

Map<CatActivity, int> _catFrameIndex = {
  CatActivity.attacking: 6,
  CatActivity.idle: 8,
  CatActivity.jumping: 7,
  CatActivity.licking: 8,
  CatActivity.running: 8,
  CatActivity.scaring: 8,
  CatActivity.sleeping: 4,
  CatActivity.sprinting: 8,
};

Map<CatActivity, Duration> _catTimeIndex = {
  CatActivity.attacking: const Duration(seconds: 1),
  CatActivity.idle: const Duration(seconds: 1),
  CatActivity.jumping: const Duration(milliseconds: 500),
  CatActivity.licking: const Duration(seconds: 1),
  CatActivity.running: const Duration(milliseconds: 500),
  CatActivity.scaring: const Duration(seconds: 1),
  CatActivity.sleeping: const Duration(milliseconds: 500),
  CatActivity.sprinting: const Duration(seconds: 1),
};

class Cat extends StatelessWidget {
  const Cat({
    super.key,
    required this.activity,
  });

  final CatActivity activity;

  @override
  Widget build(BuildContext context) {
    return CatPlayer(
      loader: CatLoader(activity: activity, frames: _catFrameIndex[activity]!),
      duration: _catTimeIndex[activity]!,
    );
  }

  static Iterable<ImageProvider> getAllActivitySprites() sync* {
    for (final entry in _catFrameIndex.entries) {
      final loader = CatLoader(activity: entry.key, frames: entry.value);
      for (final provider in loader.images) {
        yield provider;
      }
    }
  }
}
