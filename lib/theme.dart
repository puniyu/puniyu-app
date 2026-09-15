import 'package:forui/forui.dart';
import 'package:material_ui/material_ui.dart' hide Theme;
import 'package:puniyu_app/database.dart';
import 'package:puniyu_app/database/setting.dart';
import 'package:puniyu_app/theme/blue.dart';
import 'package:puniyu_app/theme/pink.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme.g.dart';

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

@Riverpod(keepAlive: true)
class ThemeController extends _$ThemeController {
  @override
  Future<ThemeManager> build() async {
    final defaultTheme = Pink();
    final themes = [defaultTheme, Blue()];
    final db = await ref.watch(dataBaseProvider.future);
    final s = await db.setting.all().findFirst() ?? Setting();

    ref.listen(themeControllerProvider, (previous, next) async {
      if (previous?.hasValue == true && next.hasValue) {
        final manager = next.requireValue;
        final db = await ref.read(dataBaseProvider.future);
        final s = await db.setting.all().findFirst() ?? Setting();
        s.appearance.themeId = manager.currentId;
        s.appearance.themeMode = manager.themeMode;
        await db.setting.put(s);
      }
    });

    return ThemeManager(
      themes: themes,
      currentId: s.appearance.themeId,
      themeMode: s.appearance.themeMode,
    );
  }

  bool setTheme(String id) {
    final s = state.value;
    if (s == null || s.currentId == id) return false;
    if (!s.themes.any((t) => t.id == id)) return false;
    state = AsyncData(ThemeManager(
      themes: s.themes,
      currentId: id,
      themeMode: s.themeMode,
    ));
    return true;
  }

  bool setThemeMode(ThemeMode mode) {
    final s = state.value;
    if (s == null || s.themeMode == mode) return false;
    state = AsyncData(ThemeManager(
      themes: s.themes,
      currentId: s.currentId,
      themeMode: mode,
    ));
    return true;
  }
}
