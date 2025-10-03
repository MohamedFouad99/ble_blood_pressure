import 'package:ble_blood_pressure/core/routing/app_router.dart';
import 'package:ble_blood_pressure/core/routing/routes.dart';
import 'package:ble_blood_pressure/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  const MyApp({super.key, required this.appRouter});

  @override
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
