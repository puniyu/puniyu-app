import 'dart:ui';

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
