import 'package:forui/forui.dart';

abstract class Theme {
  String get id => name;
  String get name;
  FColors get light;
  FColors get dark;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Theme && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => name;
}
