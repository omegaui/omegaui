import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class GithubService {
  final String readOnlyToken =
      "omegaui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";
  VoidCallback? onLoaded;
  int _projects = 89;
  int _forks = 430;
  int _stars = 31;

  int get projects => _projects;
  int get forks => _forks;
  int get stars => _stars;

  GithubService() {
    init();
  }

  void onFetchComplete(onLoaded) {
    this.onLoaded = onLoaded;
  }

  void init() async {
    await _calcTotalProjects();
    await _calcTotalForksAndStars();
    onLoaded?.call();
  }

  Future<void> _calcTotalProjects() async {
    // Getting total projects count
    final response = await http.get(
      Uri.parse('https://api.github.com/users/omegaui'),
      headers: {
        "Authorization": "Bearer ${readOnlyToken.substring(7)}",
      },
    );
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      _projects = body['public_repos'] + body['total_private_repos'];
    } else {
      debugPrint("GitHub Service Request Failed: ${response.statusCode}");
    }
  }

  Future<void> _calcTotalForksAndStars() async {
    // Getting all repos as list
    final response = await http.get(
      Uri.parse('https://api.github.com/users/omegaui/repos?per_page=100'),
      headers: {
        "Authorization": "Bearer ${readOnlyToken.substring(7)}",
      },
    );
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      _stars = 0;
      _forks = 0;
      for (final repo in body) {
        final forks = int.parse(repo['forks_count'].toString());
        final stars = int.parse(repo['stargazers_count'].toString());
        _forks += forks;
        _stars += stars;
      }
    } else {
      debugPrint("GitHub Service Request Failed: ${response.statusCode}");
    }
  }
}
