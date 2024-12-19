import 'dart:async';
import 'dart:math';

import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:omegaui/main.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:omegaui/app/home/domain/about_me.dart';
import 'package:omegaui/app/home/domain/project_description.dart';
import 'package:omegaui/app/home/domain/projects.dart';
import 'package:omegaui/app/home/domain/skill_entity.dart';
import 'package:omegaui/app/home/domain/technologies.dart';
import 'package:omegaui/app/home/presentation/home_controller.dart';
import 'package:omegaui/app/home/presentation/panels/top_panel.dart';
import 'package:omegaui/app/home/presentation/widgets/favourite_music_player.dart';
import 'package:omegaui/app/home/presentation/widgets/link_button.dart';
import 'package:omegaui/app/home/presentation/widgets/project_card.dart';
import 'package:omegaui/app/home/presentation/widgets/project_mini_card.dart';
import 'package:omegaui/app/home/presentation/widgets/skill_card.dart';
import 'package:omegaui/config/app_artworks.dart';
import 'package:omegaui/config/app_icons.dart';
import 'package:omegaui/config/app_images.dart';
import 'package:omegaui/config/app_theme.dart';
import 'package:omegaui/core/service/github_service.dart';
import 'package:omegaui/core/utils/utils.dart';
import 'package:omegaui/extensions/bird/message_bird.dart';
import 'package:omegaui/extensions/cat/cat.dart';
import 'package:omegaui/extensions/cat/loader/cat_activity.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DesktopHomeInitializedStateView extends StatefulWidget {
  const DesktopHomeInitializedStateView({super.key, required this.controller});

  final HomeController controller;

  @override
  State<DesktopHomeInitializedStateView> createState() =>
      _DesktopHomeInitializedStateViewState();
}

class _DesktopHomeInitializedStateViewState
    extends State<DesktopHomeInitializedStateView>
    with SingleTickerProviderStateMixin<DesktopHomeInitializedStateView> {
  final scrollController = ScrollController();
  final _service = Get.find<GithubService>();

  CatActivity activity = CatActivity.idle;
  late Timer catActivityTimer;
  double catX = 200.0;
  double catY = 200.0;
  double mouseX = 0.0;
  double mouseY = 0.0;
  bool flipCatOnXAxis = false;
  bool running = false;
  int cubic = 0;
  int catMovementDurationInSeconds = 6;

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(seconds: 1),
      () {
        Messenger.show(
          "Hey, Beware of My Cat",
        );
      },
    );
    catActivityTimer = Timer.periodic(
      Duration(seconds: 5),
      (timer) {
        cubic++;
        if (running) {
          return;
        }
        if (cubic.remainder(3) == 0) {
          moveRandom(context);
          return;
        }
        activity = _getRandomRestActivity();
        setState(() {});
      },
    );
    _service.onFetchComplete(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  void _scrollTo(double offset) async {
    await Future.delayed(const Duration(milliseconds: 500));
    scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void moveRandom(BuildContext context) {
    final random = Random();
    final size = MediaQuery.sizeOf(context);
    final x = random.nextInt(size.width.round() - 100) + 100;
    final y = random.nextInt(size.height.round() - 100) + 100;
    mouseX = x.toDouble();
    mouseY = y.toDouble();
    moveCat(mouseX, mouseY);
  }

  void moveCat(x, y) {
    final diff = sqrt(pow((x - catX), 2) + pow((x - catX), 2));
    if (diff <= 100) {
      catMovementDurationInSeconds = 1;
    } else if (diff <= 300) {
      catMovementDurationInSeconds = 2;
    } else if (diff <= 600) {
      catMovementDurationInSeconds = 3;
    } else if (diff <= 600) {
      catMovementDurationInSeconds = 8;
    } else if (diff <= 1000) {
      catMovementDurationInSeconds = 10;
    } else if (diff <= 1300) {
      catMovementDurationInSeconds = 12;
    } else if (diff <= 1700) {
      catMovementDurationInSeconds = 14;
    } else if (diff <= 1920) {
      catMovementDurationInSeconds = 17;
    }
    running = false;
    flipCat(x, y);
    catX = x - 50;
    catY = y - 50;
    activity = _getRandomMovementActivity();
    running = true;
    setState(() {});
  }

  void flipCat(x, y) {
    if (!running) {
      final currentFlipCatOnXAxisState = x < catX;
      if (flipCatOnXAxis != currentFlipCatOnXAxisState) {
        setState(() {
          flipCatOnXAxis = currentFlipCatOnXAxisState;
        });
      }
    }
  }

  CatActivity _getRandomMovementActivity() {
    final activities = [
      CatActivity.running,
      CatActivity.sprinting,
    ];
    activities.shuffle();
    return activities.first;
  }

  CatActivity _getRandomRestActivity() {
    final activities = [
      CatActivity.idle,
      CatActivity.sleeping,
      CatActivity.licking,
    ];
    activities.shuffle();
    return activities.first;
  }

  CatActivity _getRandomCloseActivity() {
    final activities = [
      CatActivity.scaring,
      CatActivity.attacking,
    ];
    activities.shuffle();
    return activities.first;
  }

  void _updateMouseLocation(event) {
    mouseX = event.localPosition.dx;
    mouseY = event.localPosition.dy;
    moveCat(mouseX, mouseY);
  }

  void jumpCat() async {
    activity = CatActivity.jumping;
    setState(() {});
    await Future.delayed(Duration(milliseconds: 1500));
    if (!running) {
      activity = _getRandomRestActivity();
      setState(() {});
    }
  }

  @override
  void dispose() {
    catActivityTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: GestureDetector(
        onTapUp: (details) {
          if (activity != CatActivity.jumping) {
            _updateMouseLocation(details);
          }
        },
        child: MouseRegion(
          onHover: (event) {
            flipCat(event.localPosition.dx, event.localPosition.dy);
          },
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width,
                        height: 160,
                      ),
                      Text(
                        "Hi! I'm Arham",
                        style: AppTheme.fontSize(56).makeBold(),
                      ),
                      Text(
                        "Designer. Developer. Creator.",
                        style: AppTheme.fontSize(36)
                            .makeMedium()
                            .withColor(AppTheme.foregroundLighter),
                      ),
                      const Gap(10),
                      Text(
                        "I thrive in crafting cutting-edge software and designs.",
                        style: AppTheme.fontSize(16).makeMedium(),
                      ),
                      const Image(
                        image: AppArtworks.hero,
                        width: 1280,
                      ),
                      Container(
                        width: MediaQuery.sizeOf(context).width,
                        decoration: BoxDecoration(
                          color: AppTheme.aboutBackground,
                        ),
                        child: Center(
                          child: SizedBox(
                            width: 1000,
                            height: 300,
                            child: Center(
                              child: Text(
                                "A passionate and self-made developer, known for unleashing the full potential of technology in its most exceptional form.",
                                textAlign: TextAlign.center,
                                style: AppTheme.fontSize(32).makeBold(),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 1280,
                        height: 600,
                        decoration: BoxDecoration(
                          color: AppTheme.background,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Image(
                                  image: AppArtworks.hey,
                                  width: 402,
                                ),
                                const Gap(20),
                                Text(
                                  "I love music, and Of Course, I sing too.",
                                  style: AppTheme.fontSize(14).makeMedium(),
                                ),
                                Text(
                                  "this one's my favourite",
                                  style: AppTheme.fontSize(14).makeMedium(),
                                ),
                                const Gap(20),
                                const FavouriteMusicPlayer(),
                                const Gap(20),
                                const LinkButton(
                                  text: "Instagram",
                                  image: AppIcons.instagram,
                                  hoverColor: Colors.pink,
                                  url: AboutMe.instagramUrl,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 600,
                              child: Wrap(
                                runSpacing: 25,
                                children: AboutMe.paragraphs.map(
                                  (e) {
                                    return Text(
                                      e,
                                      style: AppTheme.fontSize(14).makeMedium(),
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Gap(100),
                      Container(
                        width: MediaQuery.sizeOf(context).width,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppTheme.skillsBackground,
                              AppTheme.background
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Skill Exhibition",
                              style: AppTheme.fontSize(56).makeBold(),
                            ),
                            Text(
                              "“A perfect blend of the best”",
                              style: AppTheme.fontSize(21)
                                  .makeMedium()
                                  .makeItalic(),
                            ),
                            const Gap(50),
                            SizedBox(
                              width: 1280,
                              child: Center(
                                child: Wrap(
                                  spacing: 25,
                                  runSpacing: 25,
                                  alignment: WrapAlignment.center,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: SkillEntity.skillSet
                                      .map((e) => SkillCard(skill: e))
                                      .toList(),
                                ),
                              ),
                            ),
                            const Gap(20),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const LinkButton(
                                  text: "Whatsapp",
                                  url: AboutMe.whatsappUrl,
                                  image: AppIcons.whatsapp,
                                  hoverColor: Colors.green,
                                ),
                                const Gap(15),
                                LinkButton(
                                  text: "Gmail",
                                  url: AboutMe.gmailUrl,
                                  image: AppIcons.gmail,
                                  hoverColor: Colors.blue.shade200,
                                  hoverTextColor: AppTheme.foreground,
                                ),
                                const Gap(15),
                                LinkButton(
                                  text: "LinkedIn",
                                  url: AboutMe.linkedinUrl,
                                  image: AppIcons.linkedin,
                                  hoverColor: Colors.blueAccent,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Gap(100),
                      SizedBox(
                        width: 1280,
                        child: Column(
                          children: [
                            Text(
                              "Technologies",
                              style: AppTheme.fontSize(56).makeBold(),
                            ),
                            Text(
                              "“the bleeding edge collection”",
                              style: AppTheme.fontSize(21)
                                  .makeMedium()
                                  .makeItalic(),
                            ),
                            const Image(
                              image: AppArtworks.langCollage,
                              width: 960,
                            ),
                            const Gap(20),
                            SizedBox(
                              width: 800,
                              child: Text(
                                Technologies.short,
                                textAlign: TextAlign.center,
                                style: AppTheme.fontSize(14).makeMedium(),
                              ),
                            ),
                            const Gap(15),
                            Text(
                              "and counting, I am a confident individual who never stops learning. 😉",
                              style:
                                  AppTheme.fontSize(15).makeMedium().makeBold(),
                            ),
                          ],
                        ),
                      ),
                      const Gap(50),
                      Container(
                        width: MediaQuery.sizeOf(context).width,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppTheme.projectsBackground,
                              AppTheme.background,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: Center(
                          child: SizedBox(
                            width: 1280,
                            child: Column(
                              children: [
                                const Gap(50),
                                Text(
                                  "Project Gallery",
                                  style: AppTheme.fontSize(56).makeBold(),
                                ),
                                Text(
                                  "“mind blowing tech mixes”",
                                  style: AppTheme.fontSize(21)
                                      .makeMedium()
                                      .makeItalic(),
                                ),
                                const Gap(50),
                                Wrap(
                                  spacing: 50,
                                  runSpacing: 50,
                                  runAlignment: WrapAlignment.center,
                                  alignment: WrapAlignment.center,
                                  children: [
                                    ProjectCard(
                                      gradientColors: const [
                                        Color(0xFFEC8525),
                                        Color(0xFF7D14D0)
                                      ],
                                      image: AppImages.appFleet,
                                      imageWidth: 468.75,
                                      playbackVideoUrl:
                                          "https://firebasestorage.googleapis.com/v0/b/omegaui-io.appspot.com/o/videos%2Fapp-fleet.mp4?alt=media&token=c910964f-4157-450e-b554-2dcc351aa029",
                                      description: ProjectDescription(
                                        name: "App Fleet",
                                        technologies: [
                                          "Flutter",
                                          "Bash",
                                          "Linux",
                                          "Automation",
                                          "GNOME",
                                        ],
                                        info:
                                            "A Brilliant Workspace Manager & Launch Automation Tool.",
                                        url:
                                            'https://github.com/omegaui/app_fleet',
                                      ),
                                      onVideoPlaying: () {
                                        _scrollTo(4700);
                                      },
                                    ),
                                    ProjectCard(
                                      gradientColors: const [
                                        Color(0xFF0DB29F),
                                        Color(0xFFD0EF11)
                                      ],
                                      image: AppImages.cliptopia,
                                      imageWidth: 468.75,
                                      playbackVideoUrl:
                                          "https://firebasestorage.googleapis.com/v0/b/omegaui-io.appspot.com/o/videos%2Fcliptopia.mp4?alt=media&token=39c0dbd0-1f74-4509-8db4-80588e7ff904",
                                      description: ProjectDescription(
                                        name: "Cliptopia",
                                        technologies: [
                                          "Flutter",
                                          "Daemon",
                                          "Java",
                                          "Linux",
                                          "Wayland",
                                          "X11",
                                        ],
                                        info:
                                            "Turn your clipboard into your power house",
                                        url:
                                            'https://github.com/omegaui/cliptopia',
                                      ),
                                      onVideoPlaying: () {
                                        _scrollTo(5400);
                                      },
                                    ),
                                    ProjectCard(
                                      gradientColors: const [
                                        Color(0xFFE44F1F),
                                        Color(0xFFF91C86)
                                      ],
                                      image: AppImages.omegaide,
                                      width: 600,
                                      imageWidth: 528.5,
                                      playbackVideoUrl:
                                          "https://firebasestorage.googleapis.com/v0/b/omegaui-io.appspot.com/o/videos%2Fomegaide.mp4?alt=media&token=5273ca70-8f14-4f1f-8b36-39f21821b70a",
                                      description: ProjectDescription(
                                        name: "Omega IDE",
                                        technologies: [
                                          "Java",
                                          "Swing",
                                          "Shell Scripting",
                                          "Multiplatform",
                                          "Lightweight",
                                        ],
                                        info:
                                            "An Instant IDE for any programming language.",
                                        url:
                                            'https://github.com/omegaui/omegaide',
                                      ),
                                      onVideoPlaying: () {
                                        _scrollTo(5400);
                                      },
                                    ),
                                    ProjectCard(
                                      gradientColors: const [
                                        Color(0xFF4E9FEA),
                                        Color(0xFFF9C81C)
                                      ],
                                      image: AppImages.lvc,
                                      width: 600,
                                      imageWidth: 528.5,
                                      playbackVideoUrl:
                                          "https://firebasestorage.googleapis.com/v0/b/omegaui-io.appspot.com/o/videos%2Flvc.mp4?alt=media&token=ea0a15ea-3866-4bb2-8093-74f7bb03f212",
                                      description: ProjectDescription(
                                        name: "Linux Voice Control",
                                        technologies: [
                                          "Python",
                                          "Flutter",
                                          "Open AI",
                                          "Linux",
                                          "Master Control Mode",
                                        ],
                                        info:
                                            "Your personal, fully customization, Linux Voice Control Assistant.",
                                        url:
                                            'https://github.com/omegaui/linux-voice-control',
                                      ),
                                      onVideoPlaying: () {
                                        _scrollTo(6000);
                                      },
                                    ),
                                  ],
                                ),
                                const Gap(50),
                                Wrap(
                                  spacing: 25,
                                  runSpacing: 25,
                                  runAlignment: WrapAlignment.center,
                                  alignment: WrapAlignment.center,
                                  children: Projects.others
                                      .map((e) =>
                                          ProjectMiniCard(description: e))
                                      .toList(),
                                ),
                                const Gap(25),
                                const LinkButton(
                                  text: "Visit My Github Profile",
                                  url: 'https://github.com/omegaui',
                                  image: AppIcons.github,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Gap(50),
                      Container(
                        width: MediaQuery.sizeOf(context).width,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppTheme.experienceBackground,
                              AppTheme.background,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: Column(
                          children: [
                            const Gap(50),
                            Text(
                              "Experience",
                              style: AppTheme.fontSize(56).makeBold(),
                            ),
                            Text(
                              "“way more than my age”",
                              style: AppTheme.fontSize(21)
                                  .makeMedium()
                                  .makeItalic(),
                            ),
                            Gap(25),
                            LinkButton(
                              text: "Grab My Resume",
                              image: AppIcons.ai,
                              url: AboutMe.resumeUrl,
                            ),
                            const Gap(50),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 200,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "${_service.projects.toString().formatted}+",
                                        style: AppTheme.fontSize(56)
                                            .withColor(Colors.pink)
                                            .makeBold(),
                                      ),
                                      const Gap(10),
                                      Text(
                                        "open source projects",
                                        style: AppTheme.fontSize(16)
                                            .withColor(Colors.black)
                                            .makeMedium(),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 200,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "${_service.stars.toString().formatted}+",
                                        style: AppTheme.fontSize(56)
                                            .withColor(Colors.pink)
                                            .makeBold(),
                                      ),
                                      const Gap(10),
                                      Text(
                                        "stars on github",
                                        style: AppTheme.fontSize(16)
                                            .withColor(Colors.black)
                                            .makeMedium(),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 200,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "${_service.forks.toString().formatted}+",
                                        style: AppTheme.fontSize(56)
                                            .withColor(Colors.pink)
                                            .makeBold(),
                                      ),
                                      const Gap(10),
                                      Text(
                                        "forks of my projects",
                                        style: AppTheme.fontSize(16)
                                            .withColor(Colors.black)
                                            .makeMedium(),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const Gap(50),
                            Text(
                              "Contributed to",
                              style: AppTheme.fontSize(36).makeMedium(),
                            ),
                            const Gap(20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    launchUrlString(
                                        'https://github.com/omegaui?tab=overview&from=2022-12-01&to=2022-12-31&org=JetBrains');
                                  },
                                  child: const MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: Image(
                                      image: AppIcons.jetbrains,
                                      width: 96,
                                    ),
                                  ),
                                ),
                                const Gap(20),
                                GestureDetector(
                                  onTap: () {
                                    launchUrlString(
                                        'https://github.com/omegaui?from=2022-12-01&to=2022-12-31&org=openai&year_list=1');
                                  },
                                  child: const MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: Image(
                                      image: AppIcons.openai,
                                      width: 96,
                                    ),
                                  ),
                                ),
                                const Gap(20),
                                GestureDetector(
                                  onTap: () {
                                    launchUrlString(
                                        'https://github.com/omegaui?from=2023-12-01&to=2023-12-31&org=vlang&year_list=1');
                                  },
                                  child: const MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: Image(
                                      image: AppIcons.vlang,
                                      width: 96,
                                    ),
                                  ),
                                ),
                                const Gap(20),
                                GestureDetector(
                                  onTap: () {
                                    launchUrlString(
                                        'https://github.com/omegaui?tab=overview&from=2022-12-01&to=2022-12-31&org=flutter');
                                  },
                                  child: const MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: Image(
                                      image: AppIcons.flutter,
                                      width: 96,
                                    ),
                                  ),
                                ),
                                const Gap(20),
                                GestureDetector(
                                  onTap: () {
                                    launchUrlString(
                                        'https://github.com/omegaui?from=2020-12-01&to=2020-12-31&org=atom&year_list=1');
                                  },
                                  child: const MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: Image(
                                      image: AppIcons.atom,
                                      width: 96,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Gap(50),
                            GestureDetector(
                              onTap: () {
                                launchUrlString('https://kiranafast.com');
                              },
                              child: MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.25),
                                        blurRadius: 16,
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: const Image(
                                      image: AppIcons.kiranafast,
                                      width: 172.5,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Gap(20),
                            Text(
                              "I'm currently the Lead Developer at Kirana Fast",
                              style: AppTheme.fontSize(21).makeBold(),
                            ),
                            Text(
                              "It's an Inventory, Billing, Accounting and Online Store Management System for the Indian FMCG industry",
                              style: AppTheme.fontSize(16)
                                  .withColor(Colors.pink.shade800)
                                  .makeBold(),
                            ),
                          ],
                        ),
                      ),
                      const Gap(100),
                      Container(
                        width: MediaQuery.sizeOf(context).width,
                        color: AppTheme.background,
                        child: Center(
                          child: SizedBox(
                            width: 1000,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Image(
                                      image: AppIcons.avatar,
                                      width: 22,
                                    ),
                                    const Gap(4),
                                    Text(
                                      "omegaui",
                                      style: AppTheme.fontSize(21)
                                          .makeBold()
                                          .useSen(),
                                    ),
                                  ],
                                ),
                                const Gap(15),
                                Text(
                                  "omegaui22@gmail.com",
                                  style: AppTheme.fontSize(16)
                                      .makeMedium()
                                      .useSen(),
                                ),
                                const Gap(10),
                                Row(
                                  children: [
                                    Text(
                                      "Lucknow, Uttar Pradesh, India",
                                      style: AppTheme.fontSize(16)
                                          .makeMedium()
                                          .useSen()
                                          .withColor(
                                              AppTheme.foregroundLighter),
                                    ),
                                    Icon(
                                      Icons.location_on_outlined,
                                      color: AppTheme.foreground,
                                    ),
                                  ],
                                ),
                                const Gap(50),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    LinkButton(
                                      text: "Reddit",
                                      image: AppIcons.reddit,
                                      url: AboutMe.redditUrl,
                                    ),
                                    Gap(10),
                                    LinkButton(
                                      text: "Youtube",
                                      image: AppIcons.youtube,
                                      url: AboutMe.youtubeUrl,
                                    ),
                                    Gap(10),
                                    LinkButton(
                                      text: "Dev.to",
                                      image: AppIcons.devTo,
                                      url: AboutMe.devToUrl,
                                    ),
                                    Gap(10),
                                    LinkButton(
                                      text: "Github",
                                      image: AppIcons.github,
                                      url: AboutMe.githubUrl,
                                    ),
                                    const Gap(10),
                                    LinkButton(
                                      text: "LinkedIn",
                                      url: AboutMe.linkedinUrl,
                                      image: AppIcons.linkedin,
                                      hoverColor: Colors.blueAccent,
                                    ),
                                    const Gap(10),
                                    LinkButton(
                                      text: "Kaggle",
                                      url: AboutMe.kaggleUrl,
                                      image: AppIcons.kaggle,
                                    ),
                                    const Gap(10),
                                    LinkButton(
                                      text: "Instagram",
                                      image: AppIcons.instagram,
                                      url: AboutMe.instagramUrl,
                                      hoverColor: Colors.pink,
                                    ),
                                    Gap(10),
                                    LinkButton(
                                      text: "Whatsapp",
                                      image: AppIcons.whatsapp,
                                      url: AboutMe.whatsappUrl,
                                      hoverColor: Colors.green,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Gap(50),
                      Text(
                        "2024 © Omega UI. All rights reserved.",
                        style: AppTheme.fontSize(14).makeMedium(),
                      ),
                      const Gap(5),
                      Text(
                        "Last updated ${timeago.format(siteLastUpdated)}",
                        style: AppTheme.fontSize(12).makeMedium(),
                      ),
                      const Gap(10),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: TopPanel(
                  controller: widget.controller,
                  scrollController: scrollController,
                ),
              ),
              Align(
                child: AnimatedBackground(
                  vsync: this,
                  behaviour: RandomParticleBehaviour(
                    options: const ParticleOptions(
                      baseColor: Colors.black,
                      maxOpacity: 1.0,
                      minOpacity: 0.4,
                      spawnMinRadius: 1.0,
                      spawnMaxRadius: 1.2,
                      spawnMinSpeed: 2.0,
                      spawnMaxSpeed: 15.0,
                      particleCount: 50,
                    ),
                  ),
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    height: MediaQuery.sizeOf(context).height,
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: Duration(seconds: catMovementDurationInSeconds),
                left: catX,
                top: catY,
                onEnd: () {
                  setState(() {
                    activity = _getRandomRestActivity();
                    running = false;
                  });
                },
                child: Transform.flip(
                  flipX: flipCatOnXAxis,
                  child: GestureDetector(
                    onTapDown: (_) {
                      jumpCat();
                    },
                    child: MouseRegion(
                      onEnter: (event) {
                        if (!running) {
                          activity = _getRandomCloseActivity();
                          setState(() {});
                        }
                      },
                      child: Container(
                        width: 100,
                        height: 100,
                        child: Center(
                          child: Cat(
                            activity: activity,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: MessageBird.create(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
