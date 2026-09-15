import 'package:forui/forui.dart';
import 'package:material_ui/material_ui.dart' hide Theme;
import 'package:puniyu_app/theme/theme.dart';

class ThemeManager {
  ThemeManager({
    required List<Theme> themes,
    required this.currentId,
    this.themeMode = ThemeMode.system,
  }) : themes = List.unmodifiable(themes),
       current = themes.firstWhere((theme) => theme.id == currentId);

  final List<Theme> themes;
  final String currentId;
  final ThemeMode themeMode;
  final Theme current;

  late final FThemeData lightTheme = () {
    final typeface = FTypeface.inherit(
      colors: current.light,
      touch: false,
      fontFamily: 'DouyinSans',
    );
    return FThemeData(
      colors: current.light,
      touch: false,
      typography: FTypography(display: typeface, body: typeface),
    );
  }();

  late final FThemeData darkTheme = () {
    final typeface = FTypeface.inherit(
      colors: current.dark,
      touch: false,
      fontFamily: 'DouyinSans',
    );
    return FThemeData(
      colors: current.dark,
      touch: false,
      typography: FTypography(display: typeface, body: typeface),
    );
  }();
}
