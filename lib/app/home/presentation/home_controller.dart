import 'package:flutter/cupertino.dart';
import 'package:omegaui/app/home/presentation/home_state_machine.dart';
import 'package:omegaui/config/app_artworks.dart';
import 'package:omegaui/config/app_icons.dart';
import 'package:omegaui/core/machine/controller.dart';

class HomeController extends Controller<HomeState, HomeEvent> {
  HomeController({required super.uiRebuildCallback})
      : super(stateMachine: HomeStateMachine());

  void initialize(BuildContext context) async {
    await precacheImage(AppIcons.sponsor, context);
    await precacheImage(AppArtworks.hero, context);
    await precacheImage(AppArtworks.hey, context);
    await precacheImage(AppIcons.avatar, context);
    onEvent(HomeInitializedEvent());
  }
}
