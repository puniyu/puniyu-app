import 'package:flutter/widgets.dart';
import 'package:window_manager/window_manager.dart';

const Size _size = Size(1024, 768);

class WindowManger {
  static Future<void> initialize() async {
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = WindowOptions(
      size: _size,
      minimumSize: Size(800, 600),
      center: true,
      backgroundColor: const Color(0x00000000),
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.hidden,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }
}
