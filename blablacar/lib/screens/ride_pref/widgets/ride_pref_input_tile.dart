import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/widgets/actions/blabla_button.dart';
import '../../../theme/theme.dart';

class RidePrefInputTile extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final IconData leftIcon;

  //if true display placeHolder
  final bool isPlaceHolder;

  // optional
  final IconData? rightIcon;
  final VoidCallback? onRightIconPressed;

  const RidePrefInputTile(
      {super.key,
      required this.title,
      required this.onPressed,
      required this.leftIcon,
      this.rightIcon,
      this.onRightIconPressed,
      this.isPlaceHolder = false});

  @override
  Widget build(BuildContext context) {
    Color textColor =
        isPlaceHolder ? BlaColors.textLight : BlaColors.textNormal;

    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Icon(
              leftIcon,
              size: BlaSize.icon,
              color: BlaColors.textNormal,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: BlaTextStyles.button
                    .copyWith(fontSize: 14, color: textColor),
              ),
            ),
            if (rightIcon != null)
              IconButton(
                icon: Icon(rightIcon),
                onPressed: onRightIconPressed,
              ),
          ],
        ),
      ),
    );
  }
}
