import 'package:intl/intl.dart';

extension Formatter on String {
  static final _format = NumberFormat("###,###", "en_US");

  String get formatted {
    return _format.format(int.parse(this));
  }
}
