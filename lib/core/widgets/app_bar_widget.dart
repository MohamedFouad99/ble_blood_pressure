import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_app_bar.dart';

// description: This file contains the AppBarWidget class which represents
// a custom app bar widget in the application.
class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({
    super.key,
    required this.title,
    this.hasBackButton = false,
  });
  final String title;
  final bool hasBackButton;
  @override
  Size get preferredSize => Size.fromHeight(70.h);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(16),
        bottomRight: Radius.circular(16),
      ),
      child: CustomAppBar(title: title, hasBackButton: hasBackButton),
    );
  }
}
