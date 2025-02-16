import 'package:omegaui/app/home/domain/project_description.dart';
import 'package:omegaui/config/app_icons.dart';

class Projects {
  Projects._();

  static List<ProjectShortDescription> get others => [
        ProjectShortDescription(
          icon: AppIcons.nakime,
          name: "Nakime",
          technologies: {
            AppIcons.visualStudio: "App's Core is a Windows Service",
            AppIcons.flutter: "App's UI is written in Flutter",
            AppIcons.console:
                "Comes with an extendable CLI named 'session-uptime'",
          },
          info:
              "Track your PC sessions and find out if someone tried to turn on your computer.",
          url: 'https://github.com/omegaui/nakime',
        ),
        ProjectShortDescription(
          icon: AppIcons.chatDesk,
          name: "Chat Desk",
          technologies: {
            AppIcons.flutter: "Implemented in Flutter",
            AppIcons.server: "Server Code written in Dart",
          },
          info: "A self-hosted chat application for the desktops.",
          url: 'https://github.com/omegaui/chat_desk',
        ),
        ProjectShortDescription(
          icon: AppIcons.alarms,
          name: "Alarms",
          technologies: {
            AppIcons.flutter: "Flutter",
            AppIcons.firebase: "Firebase",
          },
          info:
              "A mysterious personal gallery app, that has an un-lockable interface.",
        ),
        ProjectShortDescription(
          icon: AppIcons.archy,
          name: "Archy",
          technologies: {
            AppIcons.dart: "Dart",
          },
          info:
              "Flutter Clean Architecture based project's file structure generation program.",
          url: 'https://github.com/omegaui/archy',
        ),
        ProjectShortDescription(
          icon: AppIcons.linuxPlus,
          name: "Linux Plus",
          technologies: {
            AppIcons.dart: "Dart",
            AppIcons.linux: "Linux",
          },
          info:
              "Provides system information about the underlying host linux distribution.",
          url: 'https://github.com/omegaui/linux_plus',
        ),
        ProjectShortDescription(
          icon: AppIcons.gitDrive,
          name: "Git Drive",
          technologies: {
            AppIcons.flutter: "Flutter",
            AppIcons.dart: "Dart",
            AppIcons.github: "GitHub",
          },
          info:
              "An application that turns your Github into your ready-to-use dropbox.",
        ),
        // ProjectShortDescription(
        //   icon: AppIcons.curlyCreate,
        //   name: "Curly Create",
        //   technologies: {
        //     AppIcons.flutter: "Flutter",
        //     AppIcons.dart: "Dart",
        //     AppIcons.firebase: "Firebase",
        //   },
        //   info:
        //       "An art collection management application with master mode authentication.",
        //   url: 'https://github.com/omegaui/curly_create',
        // ),
        ProjectShortDescription(
          icon: AppIcons.linux,
          name: "Linux Storage Sense",
          technologies: {
            AppIcons.vlang: "V lang",
          },
          info:
              "Keep your Linux system storage clean and organized effortlessly.",
          url: 'https://github.com/omegaui/linux-storage-sense',
        ),
        ProjectShortDescription(
            icon: AppIcons.jsonDataStorage,
            name: "Json Data Storage",
            technologies: {
              AppIcons.java: "Java",
            },
            info:
                "The Ultimate Shared Preferences API for Java, Scala & Groovy.",
            url: 'https://github.com/omegaui/json-data-storage'),
        ProjectShortDescription(
          icon: AppIcons.miniGitDashboard,
          name: "Mini Git Dashboard",
          technologies: {
            AppIcons.flutter: "Flutter",
            AppIcons.graphQL: "Graph QL",
          },
          info:
              "Get your github profile overview floating in any corner of your screen.",
          url: 'https://github.com/omegaui/mini_git_dashboard',
        ),
        ProjectShortDescription(
          icon: AppIcons.geditPlugin,
          name: "Flutter Support for Gedit",
          technologies: {
            AppIcons.flutter: "Flutter",
            AppIcons.python: "Python",
            AppIcons.linux: "Linux",
          },
          info: "A plugins that enables building a flutter project on Gedit.",
          url: 'https://github.com/omegaui/gedit_flutter_hot_reload',
        ),
        ProjectShortDescription(
          icon: AppIcons.javaCompiler,
          name: "Java Instant Compiler",
          technologies: {
            AppIcons.java: "Java",
          },
          info:
              "A library for IDEs and Code Editors to compile java projects the fastest dynamically.",
          url: 'https://github.com/omegaui/fast-java-dynamic-compiler',
        ),
        ProjectShortDescription(
          icon: AppIcons.gpm,
          name: "Generic Package Manager",
          technologies: {
            AppIcons.dart: "Dart",
          },
          info:
              "Directly install applications from their GitHub repository with autoupdate support.",
          url: 'https://github.com/generic-package-manager',
        ),
        ProjectShortDescription(
          icon: AppIcons.androidBuildMaker,
          name: "Android Build Automation",
          technologies: {
            AppIcons.flutter: "Flutter",
            AppIcons.kiranafast: "Organization Product",
          },
          info:
              "Build Queue, Profiles, Automated App Icon Generation, Flutter and Git Config.",
          url: 'https://github.com/omegaui/android_build_maker',
        ),
      ];
}
