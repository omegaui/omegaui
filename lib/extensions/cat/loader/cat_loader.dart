import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omegaui/extensions/cat/loader/cat_activity.dart';

class CatLoader {
  final CatActivity activity;
  final int frames;
  late List<AssetImage> images;

  CatLoader({required this.activity, required this.frames}) {
    load();
  }

  CatLoader load() {
    images = [];
    for (int i = 1; i < frames; i++) {
      images.add(AssetImage('assets/cat/${activity.name}/${activity.name}-$i.png'));
    }
    return this;
  }
}
