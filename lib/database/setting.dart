import 'package:cindel/cindel.dart';
import 'package:material_ui/material_ui.dart' hide Theme;
import 'package:puniyu_app/model/language_mode.dart';

part 'setting.g.dart';

@Collection()
class Setting {
  Id dbId = autoIncrement;

  AppearanceSetting appearance = AppearanceSetting();

  LocalizationSetting localization = LocalizationSetting();
}

@embedded
class AppearanceSetting {
  // 留空表示用户还没选过，由主题注册表回退到 isDefault 的那个
  String themeId = "";
  ThemeMode themeMode = ThemeMode.system;
}

@embedded
class LocalizationSetting {
  LanguageMode language = LanguageMode.system;
}
