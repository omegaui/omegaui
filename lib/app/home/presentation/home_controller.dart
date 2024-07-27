import 'package:flutter/cupertino.dart';
import 'package:omegaui/app/home/presentation/home_state_machine.dart';
import 'package:omegaui/config/app_artworks.dart';
import 'package:omegaui/config/app_icons.dart';
import 'package:omegaui/core/machine/controller.dart';
import 'package:omegaui/extensions/cat/cat.dart';

class HomeController extends Controller<HomeState, HomeEvent> {
  HomeController({required super.uiRebuildCallback})
      : super(stateMachine: HomeStateMachine());

  void initialize(BuildContext context) async {
    List<ImageProvider> images = [
      AppIcons.sponsor,
      AppArtworks.hero,
      AppArtworks.hey,
      AppIcons.avatar,
      ...Cat.getAllActivitySprites(),
    ];
    final futures = <Future>[];
    for (final provider in images) {
      futures.add(precacheImage(provider, context));
    }
    await Future.wait(futures);
    onEvent(HomeInitializedEvent());
  }
}
