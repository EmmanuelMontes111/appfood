import 'package:flutter/widgets.dart';
import 'package:ui_ux/src/data/repositories/preferences_repository.dart';
import 'package:ui_ux/src/helpers/get.dart';

class SplashController extends ChangeNotifier {
  final _preferencesRepository = Get.i.find<PreferencesRepository>();
  // final _authenticationRepository = Get.i.find<AuthenticationRepository>();
  // final _accountRepository = Get.i.find<AccountRepository>();

  // void Function(User? user, bool isReady)? onAfterFirstLayout;

  void afterFirstLayout() async {
    await Future.delayed(Duration(milliseconds: 200));
    final isReady = _preferencesRepository.onboardAndWelcomeReady;
  }
}
