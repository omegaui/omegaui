import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:omegaui/app/home/domain/project_description.dart';
import 'package:omegaui/app/home/presentation/widgets/link_button.dart';
import 'package:omegaui/config/app_icons.dart';
import 'package:omegaui/config/app_theme.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ProjectMiniCard extends StatefulWidget {
  const ProjectMiniCard({
    super.key,
    required this.description,
  });

  final ProjectShortDescription description;

  @override
  State<ProjectMiniCard> createState() => _ProjectMiniCardState();
}

class _ProjectMiniCardState extends State<ProjectMiniCard> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.description.url != null) {
          launchUrlString(widget.description.url!);
        }
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (e) => setState(() => hover = true),
        onExit: (e) => setState(() => hover = false),
        child: AnimatedContainer(
          width: 300,
          height: 200,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: hover ? Colors.grey.shade100 : Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 16,
              ),
            ],
          ),
          child: Stack(
            children: [
              Align(
                child: Column(
                  children: [
                    const Gap(15),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image(
                        image: widget.description.icon,
                        height: 48,
                      ),
                    ),
                    const Gap(10),
                    Text(
                      widget.description.name,
                      style: AppTheme.fontSize(16).makeMedium(),
                    ),
                    const Gap(10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        widget.description.info,
                        textAlign: TextAlign.center,
                        style: AppTheme.fontSize(13)
                            .makeMedium()
                            .withColor(AppTheme.foregroundLighter),
                      ),
                    ),
                    const Gap(10),
                    Wrap(
                      spacing: 6,
                      children:
                          widget.description.technologies.entries.map((e) {
                        return MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Tooltip(
                            message: e.value,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image(
                                image: e.key,
                                width: 32,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    opacity: hover ? 1.0 : 0.0,
                    child: FittedBox(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              blurRadius: 16,
                            ),
                          ],
                        ),
                        child: Center(
                          child: LinkButton(
                            text: widget.description.url != null
                                ? "Repo"
                                : "Private",
                            url: widget.description.url,
                            onPressed:
                                widget.description.url == null ? () {} : null,
                            image: AppIcons.github,
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
    );
  }
}
