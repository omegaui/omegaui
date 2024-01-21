import 'package:flutter/material.dart';

class LinearShadedText extends StatelessWidget {
  const LinearShadedText(
    this.text, {
    super.key,
    required this.style,
    required this.colors,
    this.begin = Alignment.topCenter,
    this.end = Alignment.bottomCenter,
  });

  final String text;
  final TextStyle style;
  final List<Color> colors;
  final Alignment begin;
  final Alignment end;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) {
        final gradient = LinearGradient(
          colors: colors,
          begin: begin,
          end: end,
        );
        return gradient.createShader(bounds);
      },
      child: Text(
        text,
        style: style,
      ),
    );
  }
}
