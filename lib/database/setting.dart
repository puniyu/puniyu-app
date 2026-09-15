import 'package:cindel/cindel.dart';
import 'package:material_ui/material_ui.dart' hide Theme;
import 'package:puniyu_app/model/language_mode.dart';
import 'package:puniyu_app/theme/pink.dart';

part 'setting.g.dart';

@Collection()
class Setting {
  Id dbId = autoIncrement;

  AppearanceSetting appearance = AppearanceSetting();

  LocalizationSetting localization = LocalizationSetting();
}

@embedded
class AppearanceSetting {
  String themeId = Pink().name;
  ThemeMode themeMode = ThemeMode.system;
}

@embedded
class LocalizationSetting {
  LanguageMode language = LanguageMode.system;
}
