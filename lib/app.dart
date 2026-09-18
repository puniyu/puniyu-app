import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:material_ui/material_ui.dart' show MaterialApp, Theme;
import 'package:puniyu_app/l10n/generated/app_localizations.dart';
import 'package:puniyu_app/provider/localization.dart';
import 'package:puniyu_app/provider/router.dart';
import 'package:puniyu_app/provider/theme.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.read(routerControllerProvider);
    final manager = ref.watch(themeControllerProvider);
    final language = ref.watch(localizationControllerProvider);

    final error = manager.error ?? language.error;
    if (error != null) {
      debugPrint(
        '应用初始化失败: $error\n${manager.stackTrace ?? language.stackTrace}',
      );
      return const SizedBox.shrink();
    }

    return switch ((manager, language)) {
      (AsyncData(value: final manager), AsyncData(value: final language)) =>
        MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: router.config(),
          locale: language.locale,
          theme: manager.lightTheme.toApproximateMaterialTheme(),
          darkTheme: manager.darkTheme.toApproximateMaterialTheme(),
          themeMode: manager.themeMode,
          builder: (context, child) {
            final brightness = Theme.of(context).brightness;
            final theme = brightness == Brightness.dark
                ? manager.darkTheme
                : manager.lightTheme;

            return FTheme(data: theme, child: child ?? const SizedBox.shrink());
          },
          localizationsDelegates: [
            AppLocalizations.delegate,
            ...FLocalizations.localizationsDelegates,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      _ => const SizedBox.shrink(),
    };
  }
}
