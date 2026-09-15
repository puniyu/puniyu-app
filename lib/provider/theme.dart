import 'package:material_ui/material_ui.dart' hide Theme;
import 'package:puniyu_app/database.dart';
import 'package:puniyu_app/database/setting.dart';
import 'package:puniyu_app/model/theme_manager.dart';
import 'package:puniyu_app/theme/blue.dart';
import 'package:puniyu_app/theme/pink.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme.g.dart';

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
