// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Theme)
final themeProvider = ThemeProvider._();

final class ThemeProvider extends $NotifierProvider<Theme, List<model.Theme>> {
  ThemeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'themeProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$themeHash();

  @$internal
  @override
  Theme create() => Theme();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<model.Theme> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<model.Theme>>(value),
    );
  }
}

String _$themeHash() => r'afb11413d793272a3e15049d20b7710cd7ced3d1';

abstract class _$Theme extends $Notifier<List<model.Theme>> {
  List<model.Theme> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<List<model.Theme>, List<model.Theme>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<model.Theme>, List<model.Theme>>,
              List<model.Theme>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
