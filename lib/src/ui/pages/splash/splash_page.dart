import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_ux/src/routes/routes.dart';
import 'package:ui_ux/src/ui/pages/splash/splash_controller.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SplashController>(
      lazy: false,
      create: (_) {
        final controller = SplashController();
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          controller.afterFirstLayout();
        });
        String routeName = Routes.ONBOARD;

        Navigator.pushReplacementNamed(context, routeName);
        return controller;
      },
      builder: (_, __) => Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
