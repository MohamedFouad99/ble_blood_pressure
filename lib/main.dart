import 'package:ble_blood_pressure/app.dart';
import 'package:ble_blood_pressure/core/di/di.dart';
import 'package:ble_blood_pressure/core/routing/app_router.dart';
import 'package:ble_blood_pressure/src/cubits/devices_cubit.dart';
import 'package:ble_blood_pressure/src/cubits/pairing_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  // setup get_it
  await setupServiceLocator();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<DevicesCubit>(create: (_) => getIt<DevicesCubit>()),
          BlocProvider<PairingCubit>(create: (_) => getIt<PairingCubit>()),
        ],
        child: MyApp(appRouter: AppRouter()),
      ),
    ),
  );
}
