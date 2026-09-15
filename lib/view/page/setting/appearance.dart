import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:material_ui/material_ui.dart' hide Theme;
import 'package:puniyu_app/l10n/generated/app_localizations.dart';
import 'package:puniyu_app/platform.dart';
import 'package:puniyu_app/provider/theme.dart';

class AppearanceSetting extends ConsumerWidget {
  const AppearanceSetting({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final managerAsync = ref.watch(themeControllerProvider);
    final controller = ref.read(themeControllerProvider.notifier);
    final l10n = AppLocalizations.of(context);

    return managerAsync.when(
      data: (manager) {
        final themeModeItems = [
          (mode: ThemeMode.light, icon: FLucideIcons.sun, label: l10n.themeModeLight),
          (mode: ThemeMode.dark, icon: FLucideIcons.moon, label: l10n.themeModeDark),
          (mode: ThemeMode.system, icon: FLucideIcons.monitor, label: l10n.themeModeSystem),
        ];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.appearance, style: context.theme.typography.display.lg),
            const SizedBox(height: 12),
            FCard(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSection(
                      context,
                      l10n.themeColor,
                      l10n.themeColorDesc,
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          for (final theme in manager.themes)
                            _ThemeColorItem(
                              color: theme.light.primary,
                              label: theme.name,
                              isSelected: manager.current == theme,
                              onTap: () => controller.setTheme(theme.id),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(height: 1, color: context.theme.colors.border),
                    const SizedBox(height: 16),
                    _buildSection(
                      context,
                      l10n.themeMode,
                      l10n.themeModeDesc,
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final cols = constraints.maxWidth > 400 ? themeModeItems.length : 2;
                          final w = (constraints.maxWidth - 8 * (cols - 1)) / cols;
                          return Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              for (final (i, item) in themeModeItems.indexed)
                                SizedBox(
                                  width: cols == 2 && themeModeItems.length.isOdd && i == themeModeItems.length - 1
                                      ? constraints.maxWidth
                                      : w,
                                  child: FButton(
                                    onPress: () => controller.setThemeMode(item.mode),
                                    selected: manager.themeMode == item.mode,
                                    semanticsLabel: item.label,
                                    variant: manager.themeMode == item.mode ? FButtonVariant.primary : FButtonVariant.outline,
                                    size: FButtonSizeVariant.lg,
                                    prefix: Icon(item.icon, size: 16),
                                    child: Text(item.label, maxLines: 1, overflow: TextOverflow.ellipsis),
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }

  Widget _buildSection(BuildContext context, String title, String subtitle, Widget content) {
    final header = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title, style: context.theme.typography.display.md),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: context.theme.typography.body.sm.copyWith(
            color: context.theme.colors.mutedForeground,
          ),
        ),
      ],
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

class _ThemeColorItem extends StatelessWidget {
  const _ThemeColorItem({
    required this.color,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final Color color;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;

    return Semantics(
      button: true,
      selected: isSelected,
      label: label,
      child: FTooltip(
        tipBuilder: (_, _) => Text(label),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? colors.primary : colors.border,
                width: isSelected ? 3 : 1.5,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: color.withValues(alpha: 0.4),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : null,
            ),
            child: isSelected
                ? Icon(FLucideIcons.check, size: 18, color: colors.background)
                : null,
          ),
        ),
      ),
    );
  }
}
