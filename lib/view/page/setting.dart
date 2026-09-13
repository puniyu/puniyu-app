import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:puniyu_app/view/page/setting/about.dart';
import 'package:puniyu_app/view/page/setting/appearance.dart';
import 'package:puniyu_app/view/page/setting/general.dart';

@RoutePage()
class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 24,
        children: [
          const GeneralSetting(),
          const AppearanceSetting(),
          const AboutSetting(),
        ],
      ),
    );
  }
}
