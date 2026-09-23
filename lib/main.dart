import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sys_proxy/flutter_sys_proxy.dart';
import 'package:puniyu_app/app.dart';
import 'package:puniyu_app/platform.dart';
import 'package:puniyu_app/proxy.dart';
import 'package:puniyu_app/window.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final proxy = await getSystemProxy();
  if (proxy case SystemProxy(
    enabled: true,
    host: final host?,
    port: final port?,
  ) when host.isNotEmpty && port > 0) {
    HttpOverrides.global = Http(proxy);
  }

  if (isDesktop()) {
    await WindowManger.initialize();
  }

  runApp(const ProviderScope(child: App()));
}
