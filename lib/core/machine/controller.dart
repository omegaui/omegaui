import 'package:omegaui/constants/typedefs.dart';
import 'package:omegaui/core/machine/state_machine.dart';

class Controller<State, Event> {
  final UIRebuildCallback _uiRebuildCallback;
  final StateMachine<State, Event> _stateMachine;

  Controller({
    required UIRebuildCallback uiRebuildCallback,
    required StateMachine<State, Event> stateMachine,
  })  : _uiRebuildCallback = uiRebuildCallback,
        _stateMachine = stateMachine;

  void onEvent(Event event) {
    _stateMachine.changeStateOnEvent(event);
    _uiRebuildCallback();
  }

  State getCurrentState() {
    return _stateMachine.getCurrentState();
  }
}
