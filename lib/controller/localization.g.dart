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
    extends $AsyncNotifierProvider<LocalizationController, LanguageMode> {
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
}

String _$localizationControllerHash() =>
    r'458db9c501e3af1ba436221d756ebdd9b7a0b162';

abstract class _$LocalizationController extends $AsyncNotifier<LanguageMode> {
  FutureOr<LanguageMode> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<LanguageMode>, LanguageMode>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<LanguageMode>, LanguageMode>,
              AsyncValue<LanguageMode>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
