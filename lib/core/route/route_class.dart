import 'package:flutter/material.dart';

class NavigationRoutes {
  void navigateToWidget(BuildContext context, Widget widget) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (Route<dynamic> route) => false,
    );
  }

  Future<void> navigateToFuture(BuildContext context, Widget widget) async {
    await Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (Route<dynamic> route) => false,
    );
  }
}
