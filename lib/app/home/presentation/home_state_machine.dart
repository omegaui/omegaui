import 'package:omegaui/core/machine/state_machine.dart';

class HomeStateMachine extends StateMachine<HomeState, HomeEvent> {
  HomeStateMachine() : super(initialState: HomeLoadingState());

  @override
  void changeStateOnEvent(HomeEvent event) {
    switch (event.runtimeType) {
      case const (HomeLoadingEvent):
        currentState = HomeLoadingState();
        break;
      case const (HomeInitializedEvent):
        currentState = HomeInitializedState();
    }
  }
}

class HomeEvent {}

class HomeLoadingEvent extends HomeEvent {}

class HomeInitializedEvent extends HomeEvent {}

class HomeState {}

class HomeLoadingState extends HomeState {}

class HomeInitializedState extends HomeState {}
