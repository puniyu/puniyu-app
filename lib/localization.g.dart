// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'localization.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LocalizationController)
final localizationControllerProvider = LocalizationControllerProvider._();

final class LocalizationControllerProvider
    extends $NotifierProvider<LocalizationController, LanguageMode> {
  LocalizationControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localizationControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localizationControllerHash();

  @$internal
  @override
  LocalizationController create() => LocalizationController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LanguageMode value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LanguageMode>(value),
    );
  }
}

String _$localizationControllerHash() =>
    r'0878b65fb53ef3e13409966c229518db5b80e0d2';

abstract class _$LocalizationController extends $Notifier<LanguageMode> {
  LanguageMode build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<LanguageMode, LanguageMode>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<LanguageMode, LanguageMode>,
              LanguageMode,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
