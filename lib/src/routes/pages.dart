import 'package:flutter/widgets.dart';

import 'package:ui_ux/src/routes/routes.dart';
import 'package:ui_ux/src/ui/pages/dish/dish_page.dart';
import 'package:ui_ux/src/ui/pages/home/home_page.dart';
import 'package:ui_ux/src/ui/pages/home/tabs/home_tab/home_tab.dart';
import 'package:ui_ux/src/ui/pages/my_cart/my_cart_page.dart';


abstract class Pages {
  // static const String INITIAL = Routes.SPLASH;
  static const String INITIAL = Routes.HOME;

  static final Map<String, Widget Function(BuildContext)> routes = {
    Routes.HOME: (_) => HomePage(),
    Routes.DISH: (_) => DishPage(),
    Routes.MY_CART: (_) => MyCartPage(),
    Routes.HOME_TAB: (_) => HomeTab(),
  };
}
