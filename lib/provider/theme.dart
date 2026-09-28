import 'package:puniyu_app/model/theme.dart' as model;
import 'package:puniyu_app/theme/blue.dart';
import 'package:puniyu_app/theme/pink.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme.g.dart';

@Riverpod(keepAlive: true)
class Theme extends _$Theme {
  @override
  List<model.Theme> build() => List.unmodifiable([Pink(), Blue()]);
}
