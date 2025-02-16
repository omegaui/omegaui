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
import 'package:omegaui/app/home/presentation/panels/side_panel.dart';
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
import 'package:url_launcher/url_launcher_string.dart';

class MobileHomeInitializedStateView extends StatefulWidget {
  const MobileHomeInitializedStateView({super.key, required this.controller});

  final HomeController controller;

  @override
  State<MobileHomeInitializedStateView> createState() =>
      _MobileHomeInitializedStateViewState();
}

class _MobileHomeInitializedStateViewState
    extends State<MobileHomeInitializedStateView>
    with SingleTickerProviderStateMixin<MobileHomeInitializedStateView> {
  final scrollController = ScrollController();
  final _service = Get.find<GithubService>();

  @override
  void initState() {
    super.initState();
    _service.onFetchComplete(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  const Gap(30),
                  const Image(
                    image: AppIcons.avatar,
                    width: 64,
                  ),
                  const Gap(20),
                  Text(
                    "Hi! I'm Arham",
                    style: AppTheme.fontSize(36).makeBold(),
                  ),
                  Text(
                    "Designer. Developer. Creator.",
                    style: AppTheme.fontSize(20)
                        .makeMedium()
                        .withColor(AppTheme.foregroundLighter),
                  ),
                  const Gap(10),
                  Text(
                    "I thrive in crafting cutting-edge software and designs.",
                    style: AppTheme.fontSize(12).makeMedium(),
                  ),
                  const Image(
                    image: AppArtworks.hero,
                    width: 1280,
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width,
                    height: 160,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: AppTheme.aboutBackground,
                    ),
                    child: Center(
                      child: Text(
                        "A passionate and self-made developer, known for unleashing the full potential of technology in its most exceptional form.",
                        textAlign: TextAlign.center,
                        style: AppTheme.fontSize(16).makeBold(),
                      ),
                    ),
                  ),
                  const Gap(50),
                  Container(
                    width: 1280,
                    decoration: BoxDecoration(
                      color: AppTheme.background,
                    ),
                    child: Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Image(
                              image: AppArtworks.hey,
                              width: 402 / 2,
                            ),
                            const Gap(20),
                            Text(
                              "I love music, and Of Course, I sing too.",
                              style: AppTheme.fontSize(14).makeMedium(),
                            ),
                            Text(
                              "this one's my favourite theme",
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
                        const Gap(50),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 600,
                            child: Wrap(
                              runSpacing: 25,
                              children: AboutMe.paragraphs.map(
                                (e) {
                                  return Text(
                                    e,
                                    textAlign: TextAlign.center,
                                    style: AppTheme.fontSize(12).makeMedium(),
                                  );
                                },
                              ).toList(),
                            ),
                          ),
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
                          style: AppTheme.fontSize(36).makeBold(),
                        ),
                        Text(
                          "“A perfect blend of the best”",
                          style:
                              AppTheme.fontSize(16).makeMedium().makeItalic(),
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
                          ],
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
                  ),
                  const Gap(100),
                  SizedBox(
                    width: 1280,
                    child: Column(
                      children: [
                        Text(
                          "Technologies",
                          style: AppTheme.fontSize(36).makeBold(),
                        ),
                        Text(
                          "“the bleeding edge collection”",
                          style:
                              AppTheme.fontSize(16).makeMedium().makeItalic(),
                        ),
                        const Image(
                          image: AppArtworks.langCollage,
                          width: 960,
                        ),
                        const Gap(20),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 750,
                            child: Text(
                              Technologies.short,
                              textAlign: TextAlign.center,
                              style: AppTheme.fontSize(12).makeMedium(),
                            ),
                          ),
                        ),
                        const Gap(15),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "and counting, I am a confident individual who never stops learning. 😉",
                            textAlign: TextAlign.center,
                            style:
                                AppTheme.fontSize(13).makeMedium().makeBold(),
                          ),
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
                              style: AppTheme.fontSize(36).makeBold(),
                            ),
                            Text(
                              "“mind blowing tech mixes”",
                              style: AppTheme.fontSize(16)
                                  .makeMedium()
                                  .makeItalic(),
                            ),
                            const Gap(50),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Wrap(
                                spacing: 50,
                                runSpacing: 50,
                                runAlignment: WrapAlignment.center,
                                alignment: WrapAlignment.center,
                                children: [
                                  ProjectCard(
                                    mobileMode: true,
                                    gradientColors: const [
                                      Color(0xFFEC8525),
                                      Color(0xFF7D14D0)
                                    ],
                                    image: AppImages.appFleet,
                                    height: 350,
                                    imageWidth: 468.75 * .9,
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
                                    onVideoPlaying: () {},
                                  ),
                                  ProjectCard(
                                    mobileMode: true,
                                    gradientColors: const [
                                      Color(0xFF0DB29F),
                                      Color(0xFFD0EF11)
                                    ],
                                    image: AppImages.cliptopia,
                                    height: 350,
                                    imageWidth: 468.75 * .9,
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
                                    onVideoPlaying: () {},
                                  ),
                                  ProjectCard(
                                    mobileMode: true,
                                    gradientColors: const [
                                      Color(0xFFE44F1F),
                                      Color(0xFFF91C86)
                                    ],
                                    image: AppImages.omegaide,
                                    height: 350,
                                    imageWidth: 528.5 * 0.7,
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
                                    onVideoPlaying: () {},
                                  ),
                                  ProjectCard(
                                    mobileMode: true,
                                    gradientColors: const [
                                      Color(0xFF4E9FEA),
                                      Color(0xFFF9C81C)
                                    ],
                                    image: AppImages.lvc,
                                    height: 350,
                                    imageWidth: 528.5 * 0.7,
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
                                    onVideoPlaying: () {},
                                  ),
                                ],
                              ),
                            ),
                            const Gap(50),
                            Wrap(
                              spacing: 25,
                              runSpacing: 25,
                              runAlignment: WrapAlignment.center,
                              alignment: WrapAlignment.center,
                              children: Projects.others
                                  .map((e) => ProjectMiniCard(description: e))
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
                          style: AppTheme.fontSize(36).makeBold(),
                        ),
                        Text(
                          "“way more than my age”",
                          style:
                              AppTheme.fontSize(16).makeMedium().makeItalic(),
                        ),
                        Gap(25),
                        LinkButton(
                          text: "Grab My Resume",
                          image: AppIcons.ai,
                          url: AboutMe.resumeUrl,
                        ),
                        const Gap(25),
                        Wrap(
                          spacing: 25,
                          runSpacing: 25,
                          runAlignment: WrapAlignment.center,
                          alignment: WrapAlignment.center,
                          children: [
                            SizedBox(
                              width: 200,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "${_service.projects.toString().formatted}+",
                                    style: AppTheme.fontSize(36)
                                        .withColor(Colors.pink)
                                        .makeBold(),
                                  ),
                                  const Gap(5),
                                  Text(
                                    "open source projects",
                                    style: AppTheme.fontSize(14)
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
                                    style: AppTheme.fontSize(36)
                                        .withColor(Colors.pink)
                                        .makeBold(),
                                  ),
                                  const Gap(5),
                                  Text(
                                    "stars on github",
                                    style: AppTheme.fontSize(14)
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
                                    style: AppTheme.fontSize(36)
                                        .withColor(Colors.pink)
                                        .makeBold(),
                                  ),
                                  const Gap(5),
                                  Text(
                                    "forks of my projects",
                                    style: AppTheme.fontSize(14)
                                        .withColor(Colors.black)
                                        .makeMedium(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Gap(25),
                        Text(
                          "Contributed to",
                          style: AppTheme.fontSize(22).makeMedium(),
                        ),
                        const Gap(20),
                        Wrap(
                          spacing: 20,
                          runSpacing: 20,
                          runAlignment: WrapAlignment.center,
                          alignment: WrapAlignment.center,
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
                                  width: 48,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                launchUrlString(
                                    'https://github.com/omegaui?from=2022-12-01&to=2022-12-31&org=openai&year_list=1');
                              },
                              child: const MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: Image(
                                  image: AppIcons.openai,
                                  width: 48,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                launchUrlString(
                                    'https://github.com/omegaui?from=2023-12-01&to=2023-12-31&org=vlang&year_list=1');
                              },
                              child: const MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: Image(
                                  image: AppIcons.vlang,
                                  width: 48,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                launchUrlString(
                                    'https://github.com/omegaui?tab=overview&from=2022-12-01&to=2022-12-31&org=flutter');
                              },
                              child: const MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: Image(
                                  image: AppIcons.flutter,
                                  width: 48,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                launchUrlString(
                                    'https://github.com/omegaui?from=2020-12-01&to=2020-12-31&org=atom&year_list=1');
                              },
                              child: const MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: Image(
                                  image: AppIcons.atom,
                                  width: 48,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Gap(25),
                        GestureDetector(
                          onTap: () {
                            launchUrlString('https://kiranafast.com');
                          },
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.25),
                                        blurRadius: 16,
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: const Image(
                                      image: AppIcons.kiranafast,
                                      width: 172.5 / 2,
                                    ),
                                  ),
                                ),
                                Gap(20),
                                Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.25),
                                        blurRadius: 16,
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: const Image(
                                      image: AppIcons.billingfast,
                                      width: 172.5 / 2,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Gap(20),
                        Text(
                          "I'm currently the Lead Developer at Kirana Fast (now \"Billing Fast\")",
                          textAlign: TextAlign.center,
                          style: AppTheme.fontSize(14).makeBold(),
                        ),
                        SizedBox(
                          width: 750,
                          child: Text(
                            "It's an Inventory, Billing, Accounting and Online Store Management System for the Indian FMCG industry",
                            textAlign: TextAlign.center,
                            style: AppTheme.fontSize(12)
                                .withColor(Colors.pink.shade800)
                                .makeBold(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(100),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width,
                      color: AppTheme.background,
                      child: Center(
                        child: SizedBox(
                          width: 700,
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
                                    style: AppTheme.fontSize(16)
                                        .makeBold()
                                        .useSen(),
                                  ),
                                ],
                              ),
                              const Gap(15),
                              Text(
                                "omegaui22@gmail.com",
                                style:
                                    AppTheme.fontSize(14).makeMedium().useSen(),
                              ),
                              const Gap(10),
                              Row(
                                children: [
                                  Text(
                                    "Lucknow, Uttar Pradesh, India",
                                    style: AppTheme.fontSize(14)
                                        .makeMedium()
                                        .useSen()
                                        .withColor(AppTheme.foregroundLighter),
                                  ),
                                  Icon(
                                    Icons.location_on_outlined,
                                    color: AppTheme.foreground,
                                  ),
                                ],
                              ),
                              const Gap(50),
                              SizedBox(
                                width: MediaQuery.sizeOf(context).width,
                                child: const Center(
                                  child: Wrap(
                                    spacing: 10,
                                    runSpacing: 10,
                                    runAlignment: WrapAlignment.center,
                                    alignment: WrapAlignment.center,
                                    children: <Widget>[
                                      LinkButton(
                                        text: "Reddit",
                                        image: AppIcons.reddit,
                                        url: AboutMe.redditUrl,
                                      ),
                                      LinkButton(
                                        text: "Youtube",
                                        image: AppIcons.youtube,
                                        url: AboutMe.youtubeUrl,
                                      ),
                                      LinkButton(
                                        text: "Dev.to",
                                        image: AppIcons.devTo,
                                        url: AboutMe.devToUrl,
                                      ),
                                      LinkButton(
                                        text: "Github",
                                        image: AppIcons.github,
                                        url: AboutMe.githubUrl,
                                      ),
                                      LinkButton(
                                        text: "LinkedIn",
                                        url: AboutMe.linkedinUrl,
                                        image: AppIcons.linkedin,
                                        hoverColor: Colors.blueAccent,
                                      ),
                                      LinkButton(
                                        text: "Kaggle",
                                        url: AboutMe.kaggleUrl,
                                        image: AppIcons.kaggle,
                                      ),
                                      LinkButton(
                                        text: "Instagram",
                                        image: AppIcons.instagram,
                                        url: AboutMe.instagramUrl,
                                        hoverColor: Colors.pink,
                                      ),
                                      LinkButton(
                                        text: "Whatsapp",
                                        image: AppIcons.whatsapp,
                                        url: AboutMe.whatsappUrl,
                                        hoverColor: Colors.green,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Gap(50),
                  Text(
                    "2024-2025 © omegaui",
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
            alignment: Alignment.topLeft,
            child: SidePanel(
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
                  particleCount: 20,
                ),
              ),
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
