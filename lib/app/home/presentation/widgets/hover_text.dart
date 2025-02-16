import 'package:flutter/material.dart';

class HoverText extends StatefulWidget {
  const HoverText({
    super.key,
    required this.visibleChild,
    required this.hoverChild,
  });

  final Text visibleChild;
  final Text hoverChild;

  @override
  State<HoverText> createState() => _HoverTextState();
}

class _HoverTextState extends State<HoverText> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (e) {
        setState(() => _hover = true);
        Future.delayed(
          Duration(seconds: 2),
          () {
            setState(() => _hover = false);
          },
        );
      },
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 250),
        child: _hover
            ? SizedBox(key: ValueKey('visible'), child: widget.hoverChild)
            : SizedBox(key: ValueKey('hover'), child: widget.visibleChild),
      ),
    );
  }
}
