import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:omegaui/app/home/domain/project_description.dart';
import 'package:omegaui/app/home/presentation/widgets/link_button.dart';
import 'package:omegaui/config/app_icons.dart';
import 'package:omegaui/config/app_theme.dart';
import 'package:video_player/video_player.dart';

class ProjectCard extends StatefulWidget {
  const ProjectCard({
    super.key,
    required this.gradientColors,
    required this.image,
    this.width = 490,
    this.height = 480,
    required this.imageWidth,
    required this.playbackVideoUrl,
    required this.description,
    required this.onVideoPlaying,
    this.mobileMode = false,
  });

  final List<Color> gradientColors;
  final ImageProvider image;
  final double width;
  final double height;
  final double imageWidth;
  final bool mobileMode;
  final String playbackVideoUrl;
  final ProjectDescription description;
  final void Function() onVideoPlaying;

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool hover = false;
  bool play = false;

  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    controller =
        VideoPlayerController.networkUrl(Uri.parse(widget.playbackVideoUrl));
    controller.initialize();
    controller.addListener(() {
      final length = controller.value.duration;
      final current = controller.value.position;
      if (length == current) {
        if (play) {
          setState(() {
            play = false;
          });
          controller.seekTo(Duration.zero);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var techs = [
      for (final tech in widget.description.technologies) ...[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: widget.gradientColors[1].withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            tech,
            style: AppTheme.fontSize(widget.mobileMode ? 12 : 14).makeBold(),
          ),
        ),
        FittedBox(
          child: Container(
            width: 5,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey.shade800,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
      ],
    ];
    techs = techs.sublist(0, techs.length - 1);
    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              if (play) {
                controller.pause();
              } else {
                controller.play();
              }
              play = !play;
              widget.onVideoPlaying();
              setState(() {});
            },
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              onEnter: (e) => setState(() => hover = true),
              onExit: (e) => setState(() => hover = false),
              child: AnimatedSize(
                duration: const Duration(milliseconds: 750),
                curve: Curves.easeInOut,
                child: play
                    ? SizedBox(
                        width: 1280,
                        height: widget.mobileMode ? 250 : 720,
                        child: Stack(
                          children: [
                            Align(
                              child: AspectRatio(
                                aspectRatio: 16 / 9,
                                child: VideoPlayer(controller),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: AnimatedOpacity(
                                duration: const Duration(milliseconds: 250),
                                curve: Curves.easeInOut,
                                opacity: hover ? 1.0 : 0.0,
                                child: Container(
                                  width: 1280,
                                  height: widget.mobileMode ? 250 : 720,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                  ),
                                  child: Center(
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade800
                                            .withOpacity(0.6),
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          Icons.pause_circle_filled_rounded,
                                          size: 32,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : SizedBox(
                        width: widget.width,
                        height: widget.height,
                        child: Stack(
                          children: [
                            Align(
                              child: Container(
                                width: widget.width,
                                height: widget.height,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: widget.gradientColors,
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Center(
                                  child: AnimatedScale(
                                    duration: const Duration(milliseconds: 250),
                                    curve: Curves.easeInOut,
                                    scale: hover ? 1.05 : 1.0,
                                    child: SizedBox(
                                      width: widget.imageWidth,
                                      child: Image(
                                        image: widget.image,
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: AnimatedOpacity(
                                duration: const Duration(milliseconds: 250),
                                curve: Curves.easeInOut,
                                opacity: hover ? 1.0 : 0.0,
                                child: Container(
                                  width: widget.width,
                                  height: 480,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Center(
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade800
                                            .withOpacity(0.6),
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          Icons.play_arrow_rounded,
                                          size: 32,
                                          color: Colors.white,
                                        ),
                                      ),
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
          ),
          const Gap(20),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.description.name,
                style:
                    AppTheme.fontSize(widget.mobileMode ? 16 : 21).makeBold(),
              ),
              const Gap(10),
              LinkButton(
                text: "Repository",
                image: AppIcons.github,
                url: widget.description.url,
              ),
            ],
          ),
          const Gap(5),
          Text(
            widget.description.info,
            style: AppTheme.fontSize(widget.mobileMode ? 12 : 16).makeMedium(),
          ),
          const Gap(8),
          Wrap(
            spacing: 5,
            runSpacing: 5,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: techs,
          ),
        ],
      ),
    );
  }
}
