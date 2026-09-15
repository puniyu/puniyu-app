import 'dart:ui';

import 'package:puniyu_app/database.dart';
import 'package:puniyu_app/database/setting.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'localization.g.dart';

enum LanguageMode {
  system,
  zh,
  en;

  Locale? get locale => switch (this) {
    system => null,
    zh => const Locale('zh'),
    en => const Locale('en'),
  };
}

@Riverpod(keepAlive: true)
class LocalizationController extends _$LocalizationController {
  @override
  Future<LanguageMode> build() async {
    final db = await ref.watch(dataBaseProvider.future);
    final s = await db.setting.all().findFirst() ?? Setting();

    ref.listen(localizationControllerProvider, (previous, next) async {
      if (previous?.hasValue == true && next.hasValue) {
        final mode = next.requireValue;
        final db = await ref.read(dataBaseProvider.future);
        final s = await db.setting.all().findFirst() ?? Setting();
        s.localization.language = mode;
        await db.setting.put(s);
      }
    });

    return s.localization.language;
  }

  bool setLanguage(LanguageMode mode) {
    final current = state.value;
    if (current == mode) return false;
    state = AsyncData(mode);
    return true;
  }
}
