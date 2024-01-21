import 'package:flutter/material.dart';

abstract class AppPage<View extends StatefulWidget> extends State<View> {
  Widget get desktopView;

  Widget get tabletView;

  Widget get mobileView;

  void rebuild() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        if (screenWidth > 1024) {
          return desktopView;
        } else if (screenWidth > 425) {
          return tabletView;
        }
        return mobileView;
      },
    );
  }
}
