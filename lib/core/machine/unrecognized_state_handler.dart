import 'package:flutter/foundation.dart';

dynamic handleState<T>(T t) {
  debugPrint(">>> Unrecognized State ${t.runtimeType}");
  throw Error();
}
