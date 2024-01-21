import 'package:flutter/cupertino.dart';
import 'package:omegaui/config/app_icons.dart';

class SkillDescription {
  final String? tooltip;
  final String? url;

  SkillDescription({this.tooltip, this.url});

  bool get isNotEmpty => tooltip != null || url != null;
}

class SkillEntity {
  final String name;
  final ImageProvider icon;
  final Map<String, SkillDescription> points;

  SkillEntity({
    required this.name,
    required this.icon,
    required this.points,
  });

  static List<SkillEntity> get skillSet => [
        SkillEntity(
          name: "Dart & Flutter",
          icon: AppIcons.flutter,
          points: {
            'Method Channels': SkillDescription(
                tooltip: "Like custom file picking channel for Android"),
            'Responsive Designs':
                SkillDescription(tooltip: "This page too, is responsive"),
            'Payment Integrations':
                SkillDescription(tooltip: "Stripe and Razorpay"),
            'Worked with All platforms': SkillDescription(),
            'Crafted Cutting-edge Desktop Apps':
                SkillDescription(tooltip: "See the projects section below"),
          },
        ),
        SkillEntity(
          name: "Firebase",
          icon: AppIcons.firebase,
          points: {
            'Cloud Firestore': SkillDescription(),
            'Realtime Database': SkillDescription(),
            'Authentication plus Open ID Connect': SkillDescription(),
            'Cloud Hosting': SkillDescription(),
            'Remote Config': SkillDescription(),
            'Cloud Functions': SkillDescription(),
          },
        ),
        SkillEntity(
          name: "Google Cloud Platform",
          icon: AppIcons.gcp,
          points: {
            'Cloud DNS': SkillDescription(),
            'Custom Domain Connection': SkillDescription(),
            'Cloud Functions': SkillDescription(),
            'Cloud Domains': SkillDescription(),
            'Load Balancing': SkillDescription(),
          },
        ),
        SkillEntity(
          name: "Linux Platform",
          icon: AppIcons.linux,
          points: {
            'Shell Scripting': SkillDescription(),
            'System Administration': SkillDescription(),
            'Written System Daemon Services': SkillDescription(
                tooltip: "A full-fledged storage and clipboard manager"),
            'Crafted Apps with Native Integrations':
                SkillDescription(tooltip: "Yes, Flutter + Python + Bash"),
            'Linux is my home platform': SkillDescription(
                tooltip:
                    "⚡ Ubuntu, Arch or Fedora, I have worked with all of them"),
          },
        ),
        SkillEntity(
          name: "Java",
          icon: AppIcons.java,
          points: {
            'Crafted a java IDE & plugin system': SkillDescription(
                tooltip: "It supports any programming language"),
            'Java Swing UI and NoSQL Libraries': SkillDescription(),
            'Created Fast Dynamic Compiler Library': SkillDescription(
                tooltip: "My own custom compilation technique"),
            'Support Plugins (Kotlin, Python, etc)': SkillDescription(
                tooltip: "Language support plugins for Omega IDE"),
          },
        ),
        SkillEntity(
          name: "Android",
          icon: AppIcons.android,
          points: {
            'Crafted Android Apps with Flutter':
                SkillDescription(tooltip: "with Firebase Integration"),
            'Custom File Picking Method Channels': SkillDescription(),
            'An app to use Github as Dropbox':
                SkillDescription(tooltip: "It's called Git-Drive"),
            'A secret gallery app disguised as Alarm': SkillDescription(
                tooltip:
                    "with a secure tap based activated UI with three factor authentication."),
          },
        ),
        SkillEntity(
          name: "Artificial Intelligence & Python",
          icon: AppIcons.ai,
          points: {
            'Creator of Linux Voice Control':
                SkillDescription(tooltip: "It can do anything"),
            'Remote File Transfer Program': SkillDescription(
                tooltip:
                    "A program to copy files between Android's Termux and Desktop"),
            'Flutter Hot Reload plugin for Gedit': SkillDescription(
                tooltip: "Awesome Flutter support for Gnome's Gedit"),
            'Master Mode Voice Control with Python':
                SkillDescription(tooltip: "Yeah, this is your personal jarvis"),
          },
        ),
        SkillEntity(
          name: "Web & Database",
          icon: AppIcons.web,
          points: {
            'Web Apps written with Flutter':
                SkillDescription(tooltip: "I wrote an entire App Store"),
            'Adaptive Web Designing': SkillDescription(),
            'Crafted Shelf Plus Server': SkillDescription(
                tooltip: "plus I contributed code to shelf_plus too"),
            'SQL, Drift & NoSQL Databases': SkillDescription(
                tooltip: "plus my own custom JSON based dialect"),
          },
        ),
        SkillEntity(
          name: "Figma",
          icon: AppIcons.figma,
          points: {
            'Desktop, Tablet & Mobile App Designs': SkillDescription(),
            'My Own Design Implementations': SkillDescription(),
            'Neomorphism & Glass Designs': SkillDescription(),
            'UI to Code, perfect cloning': SkillDescription(
                tooltip: "I can give life to any design with Flutter"),
          },
        ),
      ];
}
