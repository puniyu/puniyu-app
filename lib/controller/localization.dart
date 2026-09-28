import 'package:puniyu_app/database/setting.dart';
import 'package:puniyu_app/model/language_mode.dart';
import 'package:puniyu_app/provider/database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'localization.g.dart';

@Riverpod(keepAlive: true)
class LocalizationController extends _$LocalizationController {
  @override
  Future<LanguageMode> build() async {
    final db = await ref.watch(dataBaseProvider.future);
    final s = await db.setting.all().findFirst() ?? Setting();

    listenSelf((previous, next) async {
      if (previous?.hasValue != true || !next.hasValue) return;

      final mode = next.requireValue;
      final db = await ref.read(dataBaseProvider.future);
      final setting = await db.setting.all().findFirst() ?? Setting();
      setting.localization.language = mode;
      await db.setting.put(setting);
    });

    return s.localization.language;
  }

  void setLanguage(LanguageMode mode) {
    if (state.value == mode) return;
    state = AsyncData(mode);
  }
}
