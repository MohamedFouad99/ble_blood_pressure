import 'package:ble_blood_pressure/core/routing/app_router.dart';
import 'package:ble_blood_pressure/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  const MyApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BLE Blood Pressure',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: Routes.connectedDevices,
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}
