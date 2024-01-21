import 'package:flutter/material.dart';
import 'package:omegaui/config/app_theme.dart';

class NavButton extends StatefulWidget {
  const NavButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final VoidCallback onPressed;

  @override
  State<NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<NavButton> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (e) => setState(() => hover = true),
        onExit: (e) => setState(() => hover = false),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: AppTheme.background,
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: hover
                ? Text(
                    widget.text,
                    key: ValueKey(
                        "nav-hover-${DateTime.now().millisecondsSinceEpoch}-$hashCode"),
                    style: AppTheme.fontSize(14)
                        .useSen()
                        .withColor(Colors.pink)
                        .makeMedium(),
                  )
                : Text(
                    widget.text,
                    key: ValueKey(
                        "nav-idle-${DateTime.now().millisecondsSinceEpoch}-$hashCode"),
                    style: AppTheme.fontSize(14)
                        .useSen()
                        .withColor(AppTheme.foreground)
                        .makeMedium(),
                  ),
          ),
        ),
      ),
    );
  }
}
