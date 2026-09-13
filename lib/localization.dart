import 'dart:ui';

import 'package:cindel/cindel.dart';
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
  LanguageMode build() {
    _load();
    return LanguageMode.system;
  }

  Future<CindelDatabase> _getDb() => ref.read(dataBaseProvider.future);

  Future<void> _load() async {
    final db = await _getDb();
    final s = await db.setting.all().findFirst();
    if (s == null) return;
    state = s.localization.language;
  }

  bool setLanguage(LanguageMode mode) {
    if (state == mode) return false;
    state = mode;
    _persist();
    return true;
  }

  Future<void> _persist() async {
    final db = await _getDb();
    final s = await db.setting.all().findFirst() ??
        (Setting()
          ..appearance = AppearanceSetting()
          ..localization = LocalizationSetting());
    s.localization.language = state;
    await db.setting.put(s);
  }
}
