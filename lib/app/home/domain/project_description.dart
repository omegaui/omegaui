import 'package:flutter/cupertino.dart';

class ProjectDescription {
  final String name;
  final List<String> technologies;
  final String info;
  final String url;

  ProjectDescription({
    required this.name,
    required this.technologies,
    required this.info,
    required this.url,
  });
}

class ProjectShortDescription {
  final ImageProvider icon;
  final String name;
  final Map<ImageProvider, String> technologies;
  final String info;
  final String? url;

  ProjectShortDescription({
    required this.icon,
    required this.name,
    required this.technologies,
    required this.info,
    this.url,
  });
}
