import 'package:flutter/material.dart';

class Method {
  Color changeColorForString(String? str) {
    return (str?.isEmpty ?? true) ? Color(0xfff0f0f0) : Colors.white;
  }

  Color changeBorderColorForString(String? str) {
    return (str?.isEmpty ?? true) ? Colors.transparent : Color(0xffD2D2D2);
  }

  bool emptyString(String? str) {
    return str?.isEmpty ?? true;
  }

  bool notEmptyString(String? str) {
    return str?.isNotEmpty ?? false;
  }

  Color changeColor(TextEditingController controller) {
    return controller.text.isEmpty ? Color(0xfff0f0f0) : Colors.white;
  }

  Color changeBorderColor(TextEditingController controller) {
    return controller.text.isEmpty ? Colors.transparent : Color(0xffD2D2D2);
  }
}
