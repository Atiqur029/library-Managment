import 'package:flutter/material.dart';

class UIConstrant {
  static double screenHeight = 640.0;
  static double screenWidth = 360.0;
  static _fitContext(BuildContext context, assumedValue, currentValue, value) =>
      (value / assumedValue) * currentValue;

  static fitToWidth(value, BuildContext context) => _fitContext(
      context, screenWidth, MediaQuery.of(context).size.width, value);

  static fitToHeight(value, BuildContext context) => _fitContext(
      context, screenHeight, MediaQuery.of(context).size.height, value);

  static const splashScreenLogo = 'asset/image/logo.png';
}
