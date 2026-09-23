import 'package:flutter/material.dart' hide Theme;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:window_manager/window_manager.dart';

import 'package:puniyu_app/l10n/generated/app_localizations.dart';
import 'package:puniyu_app/provider/window.dart';

class Window extends ConsumerStatefulWidget {
  const Window({super.key});

  @override
  ConsumerState<Window> createState() => _WindowState();
}

class _WindowState extends ConsumerState<Window> with WindowListener {
  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  void onWindowMaximize() => ref.read(windowControllerProvider.notifier).setMaximized();

  @override
  void onWindowUnmaximize() => ref.read(windowControllerProvider.notifier).setUnmaximized();

  @override
  Widget build(BuildContext context) {
    final actionAsync = ref.watch(windowControllerProvider);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _WindowButton(WindowAction.minimize),
        actionAsync.when(
          data: (action) => _WindowButton(action),
          loading: () => const SizedBox(width: 46, height: 36),
          error: (_, _) => _WindowButton(WindowAction.maximize),
        ),
        _WindowButton(WindowAction.close),
      ],
    );
  }
}

class _WindowButton extends StatefulWidget {
  const _WindowButton(this.action);

  final WindowAction action;

  @override
  State<_WindowButton> createState() => _WindowButtonState();
}

class _WindowButtonState extends State<_WindowButton> {
  bool _isHovered = false;

  VoidCallback get _onTap => switch (widget.action) {
        WindowAction.minimize => windowManager.minimize,
        WindowAction.maximize => windowManager.maximize,
        WindowAction.restore => windowManager.unmaximize,
        WindowAction.close => windowManager.close,
      };

  String get _label {
    final l10n = AppLocalizations.of(context);
    return switch (widget.action) {
      WindowAction.minimize => l10n.minimize,
      WindowAction.maximize => l10n.maximize,
      WindowAction.restore => l10n.restore,
      WindowAction.close => l10n.close,
    };
  }

  IconData get _icon => switch (widget.action) {
        WindowAction.minimize => FLucideIcons.minus,
        WindowAction.maximize => FLucideIcons.maximize2,
        WindowAction.restore => FLucideIcons.minimize2,
        WindowAction.close => FLucideIcons.x,
      };

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final action = widget.action;
    final label = _label;
    final idle = colors.foreground.withValues(alpha: 0.72);
    final (hoverBackground, hoverForeground) = switch (action) {
      WindowAction.close => (colors.destructive, colors.destructiveForeground),
      _ => (colors.secondary, idle),
    };

    return FTooltip(
      tipBuilder: (_, _) => Text(label),
      child: Semantics(
        button: true,
        label: label,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: _onTap,
            child: SizedBox(
              width: 46,
              height: 36,
              child: ColoredBox(
                color: _isHovered ? hoverBackground : Colors.transparent,
                child: Icon(
                  _icon,
                  size: 15,
                  color: _isHovered ? hoverForeground : idle,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
