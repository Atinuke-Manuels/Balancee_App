import 'package:flutter/material.dart';
import 'package:vehicle_repair_app/constants/app_text_styles.dart';

class AppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final Color? labelColor;
  final Color? btnColor;

  const AppButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.labelColor = Colors.white,
    this.btnColor,
  });

  @override
  Widget build(BuildContext context) {
    final AppTextStyles textStyles = AppTextStyles();
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(btnColor),
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(vertical: 20),
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: textStyles.labelText(context).copyWith(color: labelColor),
        ),
      ),
    );
  }
}
