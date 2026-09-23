// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'window.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(WindowController)
final windowControllerProvider = WindowControllerProvider._();

final class WindowControllerProvider
    extends $AsyncNotifierProvider<WindowController, WindowAction> {
  WindowControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'windowControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$windowControllerHash();

  @$internal
  @override
  WindowController create() => WindowController();
}

String _$windowControllerHash() => r'af31f27dec168e8da23bfe3a37975234bb8e13f3';

abstract class _$WindowController extends $AsyncNotifier<WindowAction> {
  FutureOr<WindowAction> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<WindowAction>, WindowAction>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<WindowAction>, WindowAction>,
              AsyncValue<WindowAction>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
