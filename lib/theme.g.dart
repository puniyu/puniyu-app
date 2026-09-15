// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ThemeController)
final themeControllerProvider = ThemeControllerProvider._();

final class ThemeControllerProvider
    extends $AsyncNotifierProvider<ThemeController, ThemeManager> {
  ThemeControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'themeControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$themeControllerHash();

  @$internal
  @override
  ThemeController create() => ThemeController();
}

String _$themeControllerHash() => r'dc63af8d67e204997c22bcaf22f6539e7cc044fa';

abstract class _$ThemeController extends $AsyncNotifier<ThemeManager> {
  FutureOr<ThemeManager> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<ThemeManager>, ThemeManager>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ThemeManager>, ThemeManager>,
              AsyncValue<ThemeManager>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
