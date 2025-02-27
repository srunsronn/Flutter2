import 'package:flutter/material.dart';
import '../../theme/theme.dart';

class BlablaButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isPrimary;
  final bool isDisabled;
  final IconData? icon;

  const BlablaButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isPrimary = true,
    this.isDisabled = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isDisabled ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isDisabled
            ? BlaColors.disabled
            : (isPrimary ? BlaColors.primary : BlaColors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BlaSpacings.radius),
          side: BorderSide(
            color: isDisabled
                ? BlaColors.disabled
                : (isPrimary ? BlaColors.primary : BlaColors.neutralLighter),
          ),
        ),
        padding: EdgeInsets.symmetric(
            vertical: BlaSpacings.m, horizontal: BlaSpacings.l),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null)
            Icon(
              icon,
              size: 20,
              color: isDisabled
                  ? BlaColors.neutralLighter
                  : (isPrimary ? BlaColors.white : BlaColors.primary),
            ),
          if (icon != null) const SizedBox(width: BlaSpacings.s),
          Text(
            text,
            style: BlaTextStyles.button.copyWith(
              color: isDisabled
                  ? BlaColors.neutralLighter
                  : (isPrimary ? BlaColors.white : BlaColors.primary),
            ),
          ),
        ],
      ),
    );
  }
}
