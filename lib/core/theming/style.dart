import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';
import 'font_weight_helper.dart';

// description: This file contains the TextStyles class which defines the text styles used in the application.
class TextStyles {
  static String fontFamily = 'Almarai';
  static TextStyle font14BlackRegular = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.regular,
    color: Colors.black,
  );
  static TextStyle font16DarkGrayRegular = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16.sp,
    fontWeight: FontWeightHelper.regular,
    color: ColorsManager.darkGray,
  );
  static TextStyle font14DarkGrayRegular = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.regular,
    color: ColorsManager.darkGray,
  );
  static TextStyle font20SecondaryBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20.sp,
    fontWeight: FontWeightHelper.bold,
    color: ColorsManager.secondary,
  );
  static TextStyle font14BlackBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.bold,
    color: Colors.black,
  );
  static TextStyle font18BlackBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18.sp,
    fontWeight: FontWeightHelper.bold,
    color: Colors.black,
  );
  static TextStyle font24BlackBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24.sp,
    fontWeight: FontWeightHelper.bold,
    color: Colors.black,
  );
  static TextStyle font204WhiteBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20.sp,
    fontWeight: FontWeightHelper.bold,
    color: ColorsManager.white,
  );
}
