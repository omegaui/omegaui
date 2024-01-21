abstract class StateMachine<State, Event> {
  State _currentState;

  StateMachine({required State initialState}) : _currentState = initialState;

  void changeStateOnEvent(Event event);

  set currentState(State currentState) {
    _currentState = currentState;
  }

  State getCurrentState() {
    return _currentState;
  }
}
