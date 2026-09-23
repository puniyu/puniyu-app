import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:window_manager/window_manager.dart';

part 'window.g.dart';

enum WindowAction { minimize, maximize, restore, close }

@Riverpod(keepAlive: true)
class WindowController extends _$WindowController {
  @override
  Future<WindowAction> build() async {
    final isMaximized = await windowManager.isMaximized();
    return isMaximized ? WindowAction.restore : WindowAction.maximize;
  }

  void setMaximized() {
    state = const AsyncData(WindowAction.restore);
  }

  void setUnmaximized() {
    state = const AsyncData(WindowAction.maximize);
  }
}
