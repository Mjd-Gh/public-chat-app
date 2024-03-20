import 'package:flutter/material.dart';

extension Screen on BuildContext {
  // ---- Size Extensions ---------
  getWidth() {
    return MediaQuery.of(this).size.width;
  }

  getHigh() {
    return MediaQuery.of(this).size.height;
  }

  // ---- Navigation Extensions ---------
  pushTo(Widget screen) {
    Navigator.push(this, MaterialPageRoute(builder: (context) => screen));
  }

  popNavigator() {
    Navigator.pop(this);
  }

  pushAndRemove(Widget screen) {
    Navigator.pushAndRemoveUntil(this,
        MaterialPageRoute(builder: (context) => screen), (route) => false);
  }

  showSnackBar(String msg,
      {Color color = const Color.fromARGB(255, 51, 51, 51)}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: color,
      ),
    );
  }

  /// ----------- Snack Bar extensions ---------
  showErrorSnackBar(String message) {
    showSnackBar(
      message,
      color: Colors.red,
    );
  }
}
