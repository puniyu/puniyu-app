// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RouterController)
final routerControllerProvider = RouterControllerProvider._();

final class RouterControllerProvider
    extends $NotifierProvider<RouterController, AppRouter> {
  RouterControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'routerControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$routerControllerHash();

  @$internal
  @override
  RouterController create() => RouterController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppRouter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppRouter>(value),
    );
  }
}

String _$routerControllerHash() => r'a394168785ffbe853bb24323bad54b626eead644';

abstract class _$RouterController extends $Notifier<AppRouter> {
  AppRouter build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AppRouter, AppRouter>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AppRouter, AppRouter>,
              AppRouter,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
