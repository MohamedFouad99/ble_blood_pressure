import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theming/colors.dart';
import '../theming/style.dart';

// description: This file contains the CustomAppBar widget which is a reusable app bar used throughout the application.
class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.hasBackButton = false,
    this.onPressed,
  });
  final String title;
  final bool? hasBackButton;
  final void Function()? onPressed;
  @override
  /// Builds the CustomAppBar widget tree.
  ///
  /// This widget is a reusable app bar used throughout the application. It
  /// has a height of 90 logical pixels, a primary color background, a bold
  /// white title, and a centered title. The leading widget is an
  /// IconButton with an arrow back icon, used to pop the current route when
  /// pressed. If the hasBackButton parameter is false, the leading widget is
  /// null.
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 90.h,
      actions: [
        if (onPressed != null)
          IconButton(
            icon: const Icon(Icons.language, color: ColorsManager.white),
            onPressed: onPressed,
          ),
      ],
      backgroundColor: ColorsManager.primary,
      title: Text(title, style: TextStyles.font204WhiteBold),
      centerTitle: true,
      leading: hasBackButton == false
          ? SizedBox()
          : IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back, color: ColorsManager.white),
            ),
    );
  }
}
