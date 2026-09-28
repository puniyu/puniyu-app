import 'package:puniyu_app/router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

@Riverpod(keepAlive: true)
class RouterController extends _$RouterController {
  @override
  AppRouter build() {
    final router = AppRouter();
    ref.onDispose(router.dispose);
    return router;
  }
}
