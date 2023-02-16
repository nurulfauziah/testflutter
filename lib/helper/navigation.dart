import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> myNavigatorKey = GlobalKey<NavigatorState>();
final ctx = myNavigatorKey.currentContext!;

class Navigation {

  static pushNoData(String routeName) {
    myNavigatorKey.currentState!.pushNamed(routeName);
  }

  static pushWithData(String routeName, Object arguments) {
    myNavigatorKey.currentState!.pushNamed(routeName, arguments: arguments);
  }

  static pushReplaceNoData(String routeName) {
    myNavigatorKey.currentState!.pushReplacementNamed(routeName);
  }

  static pushReplaceWithData(String routeName, Object arguments) {
    myNavigatorKey.currentState!.pushReplacementNamed(routeName, arguments: arguments);
  }

  static pushRemoveNoData(String routeName) {
    myNavigatorKey.currentState!.pushNamedAndRemoveUntil(
        routeName, (Route<dynamic> route) => false);
  }

  static pushRemoveWithData(String routeName, Object arguments) {
    myNavigatorKey.currentState!.pushNamedAndRemoveUntil(
        routeName, (Route<dynamic> route) => false, arguments: arguments);
  }

  static back() => myNavigatorKey.currentState!.pop();

  static backWithData(Object arguments) => myNavigatorKey.currentState!.pop(arguments);

}