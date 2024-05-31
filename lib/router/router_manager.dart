import 'package:flutter/material.dart';
import 'package:webio/home_page.dart';
import 'package:webio/profile_page.dart';
import 'package:webio/zk_login_page.dart';

class Routes {
  static const String loginPage = "/";
  static const String mainPage = "/mainPage";
  static const String profilePage = "/profile";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    if (routeSettings.name != null &&
        routeSettings.name!.contains('id_token=')) {
      return MaterialPageRoute(
          settings: routeSettings, builder: (context) => const ZkLoginPage());
    }
    switch (routeSettings.name) {
      case Routes.loginPage:
        return MaterialPageRoute(
            settings: routeSettings, builder: (context) => const ZkLoginPage());
      case Routes.mainPage:
        return MaterialPageRoute(
            settings: routeSettings, builder: (context) => const MainPage());
      case Routes.profilePage:
        return MaterialPageRoute(
            settings: routeSettings, builder: (context) => const ProfilePage());
      default:
        print('routeSettings.name: ${routeSettings.name}');
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text('No route found'),
              ),
              body: const Center(
                  child: Text(
                'No route found',
                style: TextStyle(color: Colors.white),
              )),
            ));
  }
}
