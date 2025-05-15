import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyles {
  final AppColors appColors = AppColors();

  TextStyle headingText(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth * 0.065; // ~6.5% of screen width

    return TextStyle(
      color: appColors.primaryColor,
      fontSize: fontSize.clamp(18.0, 26.0), // limit range
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle labelText(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth * 0.045;

    return TextStyle(
      fontSize: fontSize.clamp(14.0, 20.0),
      fontWeight: FontWeight.bold,
    );
  }
}
