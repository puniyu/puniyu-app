import 'package:material_ui/material_ui.dart' hide Theme;
import 'package:puniyu_app/database/setting.dart';
import 'package:puniyu_app/model/theme.dart';
import 'package:puniyu_app/provider/database.dart';
import 'package:puniyu_app/provider/theme.dart' show themeProvider;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme.g.dart';

@Riverpod(keepAlive: true)
class ThemeController extends _$ThemeController {
  @override
  Future<({Theme theme, ThemeMode themeMode})> build() async {
    final db = await ref.watch(dataBaseProvider.future);
    final theme = ref.watch(themeProvider);
    final s = await db.setting.all().findFirst() ?? Setting();

    listenSelf((previous, next) async {
      if (previous?.hasValue != true || !next.hasValue) return;

      final state = next.requireValue;
      final db = await ref.read(dataBaseProvider.future);
      final setting = await db.setting.all().findFirst() ?? Setting();
      setting.appearance
        ..themeId = state.theme.id
        ..themeMode = state.themeMode;
      await db.setting.put(setting);
    });

    return (
      theme: theme.firstWhere(
        (t) => t.id == s.appearance.themeId,
        orElse: () => theme.firstWhere((t) => t.isDefault),
      ),
      themeMode: s.appearance.themeMode,
    );
  }

  void setTheme(String id) {
    final s = state.value;
    if (s == null) return;

    final theme = ref
        .read(themeProvider)
        .firstWhere((t) => t.id == id, orElse: () => s.theme);
    if (theme == s.theme) return;

    state = AsyncData((theme: theme, themeMode: s.themeMode));
  }

  void setThemeMode(ThemeMode mode) {
    final s = state.value;
    if (s == null || s.themeMode == mode) return;
    state = AsyncData((theme: s.theme, themeMode: mode));
  }
}
