import 'package:omegaui/extensions/cat/loader/cat_loader.dart';
import 'package:flutter/material.dart';

class CatPlayer extends StatefulWidget {
  final CatLoader loader;
  final Duration duration;

  const CatPlayer({
    super.key,
    required this.loader,
    required this.duration,
  });

  @override
  State<CatPlayer> createState() => _CatPlayerState();
}

class _CatPlayerState extends State<CatPlayer>
    with SingleTickerProviderStateMixin<CatPlayer> {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: widget.duration,
      lowerBound: 1,
      upperBound: widget.loader.frames.toDouble(),
    )
      ..animateTo(
        widget.loader.frames.toDouble(),
        curve: Curves.easeIn,
      )
      ..addStatusListener(
        (status) {
          if(status == AnimationStatus.completed) {
            controller.reset();
            controller.animateTo(
              widget.loader.frames.toDouble(),
              curve: Curves.easeIn,
            );
          }
        },
      );
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final value = controller.value;
        var frame = (value - 1).round();
        if (frame >= widget.loader.images.length) {
          frame = widget.loader.images.length - 1;
        }
        final target = widget.loader.images[frame];
        return Transform.scale(
          scale: 0.5,
          child: Image(
            image: target,
            isAntiAlias: true,
            filterQuality: FilterQuality.high,
          ),
        );
      },
    );
  }
}
