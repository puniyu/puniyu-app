import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart' hide Theme;
import 'package:forui/forui.dart';
import 'package:window_manager/window_manager.dart';
import 'package:puniyu_app/l10n/generated/app_localizations.dart';
import 'package:puniyu_app/platform.dart';

enum _WindowAction {
  minimize,
  maximize,
  restore,
  close;

  String label(AppLocalizations l10n) => switch (this) {
    minimize => l10n.minimize,
    maximize => l10n.maximize,
    restore => l10n.restore,
    close => l10n.close,
  };

  IconData get icon => switch (this) {
    minimize => FLucideIcons.minus,
    maximize => FLucideIcons.maximize2,
    restore => FLucideIcons.copy,
    close => FLucideIcons.x,
  };
}

class TitleBar extends StatelessWidget {
  const TitleBar({super.key});

  @override
  Widget build(BuildContext context) {
    final title = isDesktop()
        ? AppLocalizations.of(context).appName
        : context.topRoute.title(context);
    return isDesktop() ? _DeskTop(title: title) : _Mobile(title: title);
  }
}

class _DeskTop extends StatelessWidget {
  const _DeskTop({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;

    return SizedBox(
      width: double.infinity,
      height: 36,
      child: ColoredBox(
        color: colors.background,
        child: Row(
          children: [
            Expanded(
              child: DragToMoveArea(
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Image.asset(
                          'assets/icons/icon.png',
                          width: 18,
                          height: 18,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.theme.typography.body.sm.copyWith(
                            color: colors.foreground,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            _Window(),
          ],
        ),
      ),
    );
  }
}

class _Window extends StatefulWidget {
  const _Window();

  @override
  State<_Window> createState() => _WindowState();
}

class _WindowState extends State<_Window> with WindowListener {
  _WindowAction _action = .maximize;

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
  void onWindowMaximize() => setState(() => _action = _WindowAction.restore);

  @override
  void onWindowUnmaximize() => setState(() => _action = _WindowAction.maximize);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _WindowButton(_WindowAction.minimize),
        _WindowButton(_action),
        _WindowButton(_WindowAction.close),
      ],
    );
  }
}

class _WindowButton extends StatefulWidget {
  const _WindowButton(this.action);

  final _WindowAction action;

  @override
  State<_WindowButton> createState() => _WindowButtonState();
}

class _WindowButtonState extends State<_WindowButton> {
  bool _isHovered = false;

  VoidCallback get _onTap => switch (widget.action) {
    _WindowAction.minimize => windowManager.minimize,
    _WindowAction.maximize => windowManager.maximize,
    _WindowAction.restore => windowManager.unmaximize,
    _WindowAction.close => windowManager.close,
  };

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final action = widget.action;
    final label = action.label(AppLocalizations.of(context));
    final idle = colors.foreground.withValues(alpha: 0.72);
    final (hoverBackground, hoverForeground) = switch (action) {
      _WindowAction.close => (colors.destructive, colors.destructiveForeground),
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
                  action.icon,
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

class _Mobile extends StatelessWidget {
  const _Mobile({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;

    return ColoredBox(
      color: colors.background,
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: 48,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.theme.typography.display.lg.copyWith(
                  color: colors.foreground,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
