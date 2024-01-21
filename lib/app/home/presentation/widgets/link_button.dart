import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:omegaui/config/app_theme.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LinkButton extends StatefulWidget {
  const LinkButton({
    super.key,
    required this.text,
    required this.image,
    this.url,
    this.onPressed,
    this.hoverColor,
    this.hoverTextColor,
  }) : assert(url == null || onPressed == null);

  final String text;
  final String? url;
  final ImageProvider image;
  final VoidCallback? onPressed;
  final Color? hoverColor;
  final Color? hoverTextColor;

  @override
  State<LinkButton> createState() => _LinkButtonState();
}

class _LinkButtonState extends State<LinkButton> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.onPressed == null) {
          // launching
          launchUrlString(widget.url!);
        } else {
          widget.onPressed?.call();
        }
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (e) => setState(() => hover = true),
        onExit: (e) => setState(() => hover = false),
        child: AnimatedScale(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          scale: hover ? 1.1 : 1.0,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.decelerate,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: hover
                  ? (widget.hoverColor ?? Colors.grey.shade700)
                  : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image(
                  image: widget.image,
                  width: 24,
                ),
                const Gap(5),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: hover
                      ? Text(
                          widget.text,
                          key: ValueKey(
                              "link-hover-${DateTime.now().millisecondsSinceEpoch}-$hashCode"),
                          style: AppTheme.fontSize(13)
                              .useSen()
                              .withColor(widget.hoverTextColor ?? Colors.white)
                              .makeMedium(),
                        )
                      : Text(
                          widget.text,
                          key: ValueKey(
                              "link-idle-${DateTime.now().millisecondsSinceEpoch}-$hashCode"),
                          style: AppTheme.fontSize(13)
                              .useSen()
                              .withColor(AppTheme.foreground)
                              .makeMedium(),
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
