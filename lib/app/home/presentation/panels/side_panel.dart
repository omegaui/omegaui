import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:omegaui/app/home/presentation/widgets/nav_button.dart';
import 'package:omegaui/config/app_theme.dart';

class SidePanel extends StatefulWidget {
  const SidePanel({super.key, required this.scrollController});

  final ScrollController scrollController;

  @override
  State<SidePanel> createState() => _SidePanelState();
}

class _SidePanelState extends State<SidePanel> {
  Map<String, VoidCallback> navs = {};
  bool show = true;

  @override
  void initState() {
    super.initState();
    navs = {
      "About": () => _scrollTo(640),
      "Skills": () => _scrollTo(1750),
      "Technologies": () => _scrollTo(4500),
      "Projects": () => _scrollTo(5250),
      "Experience": () => _scrollTo(10100),
    };
    widget.scrollController.addListener(() {
      final scrollingUp =
          widget.scrollController.position.userScrollDirection ==
              ScrollDirection.forward;
      if (show != scrollingUp) {
        setState(() {
          show = scrollingUp;
        });
      }
    });
  }

  void _scrollTo(double offset) async {
    Get.back();
    await Future.delayed(const Duration(milliseconds: 500));
    widget.scrollController.animateTo(
      offset,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "nav-menu",
      child: AnimatedOpacity(
        duration: Duration(milliseconds: 1200),
        curve: Curves.easeInOut,
        opacity: show ? 1.0 : 0.0,
        child: AnimatedScale(
          duration: Duration(milliseconds: 1200),
          curve: Curves.easeInOut,
          scale: show ? 1 : 2.7,
          child: AnimatedRotation(
            duration: Duration(milliseconds: 1200),
            curve: Curves.easeInOut,
            turns: show ? 0 : -1,
            child: AnimatedSlide(
              duration: Duration(milliseconds: 1200),
              curve: Curves.easeInOut,
              offset: show ? Offset(0, 0) : Offset(-1, -1),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: IconButton(
                  icon: Icon(
                    Icons.menu_rounded,
                  ),
                  onPressed: () {
                    Get.dialog(
                      _NavMenu(navs: navs),
                      barrierColor: Colors.transparent,
                      name: '',
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavMenu extends StatelessWidget {
  const _NavMenu({required this.navs});

  final Map<String, VoidCallback> navs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Hero(
          tag: "nav-menu",
          child: SizedBox(
            width: 320,
            height: 320,
            child: Stack(
              children: [
                Align(
                  child: Container(
                    width: 280,
                    height: 290,
                    decoration: BoxDecoration(
                      color: AppTheme.background,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 16,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: navs.entries
                          .map((e) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                child:
                                    NavButton(text: e.key, onPressed: e.value),
                              ))
                          .toList(),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20),
                          topLeft: Radius.circular(20),
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
