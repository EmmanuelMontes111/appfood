import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_ux/src/data/models/dish.dart';
import 'package:ui_ux/src/data/repositories/websocket_repository.dart';
import 'package:ui_ux/src/helpers/get.dart';
import 'package:ui_ux/src/ui/global_controllers/notifications_controller.dart';

class HomeController extends ChangeNotifier {
  final NotificationsController notificationsController;
  HomeController(this.notificationsController);

  final _wsRepository = Get.i.find<WebsocketRepository>(lazy: true);

  @visibleForTesting
  bool disposed = false;

  int _currentPage = 0;

  int get currentPage => _currentPage;

  Map<int, Dish> _favorites = {};

  Map<int, Dish> get favorites => _favorites;

  bool isFavorite(Dish dish) => _favorites.containsKey(dish.id);

  void Function()? onDispose;

  final TabController tabController = TabController(
    length: 2,
    vsync: NavigatorState(),
  );

  StreamSubscription? _notificationsSubscription;

  List<BottomBarItem> _menuItems = [
    BottomBarItem(
      icon: 'assets/pages/home/home.svg',
      label: 'Home',
    ),
    BottomBarItem(
      icon: 'assets/pages/home/favorite.svg',
      label: 'Favorites',
    ),
  ];

  List<BottomBarItem> get menuItems => _menuItems;


  void toggleFavorite(Dish dish) {
    Map<int, Dish> copy = Map<int, Dish>.from(_favorites);
    if (isFavorite(dish)) {
      copy.remove(dish.id);
    } else {
      copy[dish.id] = dish;
    }
    _favorites = copy;
    notifyListeners();
  }

  void deleteFavorite(Dish dish) {
    Map<int, Dish> copy = Map<int, Dish>.from(_favorites);
    if (isFavorite(dish)) {
      copy.remove(dish.id);
      _favorites = copy;
      notifyListeners();
    }
  }

  @override
  Future<void> dispose() async {
    await this._notificationsSubscription?.cancel();
    this.tabController.dispose();
    if (this.onDispose != null) {
      this.onDispose!();
    }
    await _wsRepository.disconnect();
    disposed = true;
    super.dispose();
  }
}

class BottomBarItem {
  final String icon, label;
  final int badgeCount;

  BottomBarItem({
    required this.icon,
    required this.label,
    this.badgeCount = 0,
  });

  BottomBarItem copyWith({String? icon, String? label, int? badgeCount}) {
    return BottomBarItem(
      icon: icon ?? this.icon,
      label: label ?? this.label,
      badgeCount: badgeCount ?? this.badgeCount,
    );
  }
}
