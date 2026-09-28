import 'package:forui/forui.dart';

abstract class Theme {
  String get id;
  bool get isDefault => false;
  FColors get light;
  FColors get dark;

  late final FThemeData lightTheme = _build(light);
  late final FThemeData darkTheme = _build(dark);

  static FThemeData _build(FColors colors) {
    final typeface = FTypeface.inherit(
      colors: colors,
      touch: false,
      fontFamily: 'DouyinSans',
    );
    return FThemeData(
      colors: colors,
      touch: false,
      typography: FTypography(display: typeface, body: typeface),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Theme && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => id;
}