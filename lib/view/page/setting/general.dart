import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:puniyu_app/l10n/generated/app_localizations.dart';
import 'package:puniyu_app/localization.dart';
import 'package:puniyu_app/platform.dart';

class GeneralSetting extends StatelessWidget {
  const GeneralSetting({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.general, style: context.theme.typography.display.lg),
        const SizedBox(height: 12),
        FCard(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: const _LanguageView(),
          ),
        ),
      ],
    );
  }
}

class _LanguageView extends ConsumerWidget {
  const _LanguageView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final language = ref.watch(localizationControllerProvider).requireValue;
    final controller = ref.read(localizationControllerProvider.notifier);
    final l10n = AppLocalizations.of(context);

    final items = [
      (mode: LanguageMode.zh, icon: FLucideIcons.languages, label: l10n.languageZhLocale),
      (mode: LanguageMode.en, icon: FLucideIcons.globe, label: l10n.languageEnLocale),
      (mode: LanguageMode.system, icon: FLucideIcons.monitor, label: l10n.languageSystemLocale),
    ];

    final header = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(l10n.language, style: context.theme.typography.display.md),
        const SizedBox(height: 4),
        Text(
          items.firstWhere((item) => item.mode == language).label,
          style: context.theme.typography.body.sm.copyWith(
            color: context.theme.colors.mutedForeground,
          ),
        ),
      ],
    );

    final content = LayoutBuilder(
      builder: (context, constraints) {
        final cols = constraints.maxWidth > 400 ? items.length : 2;
        final w = (constraints.maxWidth - 8 * (cols - 1)) / cols;
        return Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final (i, item) in items.indexed)
              SizedBox(
                width: cols == 2 && items.length.isOdd && i == items.length - 1
                    ? constraints.maxWidth
                    : w,
                child: FButton(
                  onPress: () => controller.setLanguage(item.mode),
                  selected: language == item.mode,
                  semanticsLabel: item.label,
                  variant: language == item.mode ? FButtonVariant.primary : FButtonVariant.outline,
                  size: FButtonSizeVariant.lg,
                  prefix: Icon(item.icon, size: 16),
                  child: Text(item.label, maxLines: 1, overflow: TextOverflow.ellipsis),
                ),
              ),
          ],
        );
      },
    );

    if (isDesktop()) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(flex: 2, child: header),
          const SizedBox(width: 24),
          Flexible(
            flex: 3,
            child: Align(alignment: Alignment.centerRight, child: content),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [header, const SizedBox(height: 16), content],
    );
  }
}


