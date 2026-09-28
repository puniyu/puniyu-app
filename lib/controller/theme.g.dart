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
    extends
        $AsyncNotifierProvider<
          ThemeController,
          ({Theme theme, ThemeMode themeMode})
        > {
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

String _$themeControllerHash() => r'7a3309b8be8ccdd0540a09c34ad78a9100168b2a';

abstract class _$ThemeController
    extends $AsyncNotifier<({Theme theme, ThemeMode themeMode})> {
  FutureOr<({Theme theme, ThemeMode themeMode})> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<({Theme theme, ThemeMode themeMode})>,
              ({Theme theme, ThemeMode themeMode})
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<({Theme theme, ThemeMode themeMode})>,
                ({Theme theme, ThemeMode themeMode})
              >,
              AsyncValue<({Theme theme, ThemeMode themeMode})>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
