import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:omegaui/app/home/domain/skill_entity.dart';
import 'package:omegaui/config/app_theme.dart';

class SkillCard extends StatefulWidget {
  const SkillCard({
    super.key,
    required this.skill,
  });

  final SkillEntity skill;

  @override
  State<SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<SkillCard> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (e) => setState(() => hover = true),
      onExit: (e) => setState(() => hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeIn,
        width: 325,
        height: 260,
        decoration: BoxDecoration(
          color: AppTheme.background,
          borderRadius: BorderRadius.circular(hover ? 10 : 30),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 16,
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              image: widget.skill.icon,
              width: 64,
            ),
            const Gap(5),
            Text(
              widget.skill.name,
              style: AppTheme.fontSize(18).makeBold(),
            ),
            const Gap(10),
            Wrap(
              spacing: 10,
              children: widget.skill.points.entries.map((e) {
                return SkillPoint(name: e.key, description: e.value);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class SkillPoint extends StatefulWidget {
  const SkillPoint({
    super.key,
    required this.name,
    required this.description,
  });

  final String name;
  final SkillDescription description;

  @override
  State<SkillPoint> createState() => _SkillPointState();
}

class _SkillPointState extends State<SkillPoint> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.description.tooltip ?? "",
      child: GestureDetector(
        onTap: () {},
        child: MouseRegion(
          cursor: widget.description.isNotEmpty
              ? SystemMouseCursors.click
              : SystemMouseCursors.basic,
          onEnter: (e) {
            if (widget.description.isNotEmpty) {
              setState(() => hover = true);
            }
          },
          onExit: (e) {
            if (widget.description.isNotEmpty) {
              setState(() => hover = false);
            }
          },
          child: SizedBox(
            height: 30,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.star,
                  size: 14,
                  color: Colors.blueGrey,
                ),
                const Gap(4),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: (hover && widget.description.isNotEmpty)
                      ? Text(
                          widget.name,
                          key: ValueKey(
                              "point-hover-${DateTime.now().millisecondsSinceEpoch}"),
                          style: AppTheme.fontSize(14)
                              .makeMedium()
                              .withColor(Colors.blue.shade800),
                        )
                      : Text(
                          widget.name,
                          key: ValueKey(
                              "point-idle-${DateTime.now().millisecondsSinceEpoch}"),
                          style: AppTheme.fontSize(14)
                              .makeMedium()
                              .withColor(AppTheme.foregroundLighter),
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
