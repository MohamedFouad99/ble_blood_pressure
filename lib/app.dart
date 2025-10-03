import 'package:ble_blood_pressure/core/routing/app_router.dart';
import 'package:ble_blood_pressure/core/routing/routes.dart';
import 'package:ble_blood_pressure/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// description: This file contains the MyApp class which builds the application widget.
class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  const MyApp({super.key, required this.appRouter});

  @override
  /// Builds the application widget, using the app router to generate the widget tree.
  ///
  /// The design size is set to 375x812, and the minimum text adapt is set to true.
  /// The application title is set to 'BLE Blood pressure', and the
  /// debugShowCheckedModeBanner is set to false.
  ///
  /// The localizationsDelegates is set to the context's localizationDelegates,
  /// and the supportedLocales is set to the context's supportedLocales.
  /// The locale is set to the context's locale.
  ///
  /// The theme is set to a ThemeData with a scaffoldBackgroundColor of white.
  ///
  /// The initialRoute is set to Routes.connectedDevices, and the onGenerateRoute
  /// is set to the app router's generateRoute method.
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: MaterialApp(
        title: 'BLE Blood Pressure',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: ThemeData(scaffoldBackgroundColor: ColorsManager.white),
        initialRoute: Routes.connectedDevices,
        onGenerateRoute: appRouter.generateRoute,
      ),
    );
  }
}
