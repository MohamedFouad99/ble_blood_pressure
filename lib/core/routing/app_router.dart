import 'package:ble_blood_pressure/core/di/di.dart';
import 'package:ble_blood_pressure/src/cubits/devices_cubit.dart';
import 'package:ble_blood_pressure/src/cubits/pairing_cubit.dart';
import 'package:ble_blood_pressure/src/models/device.dart';
import 'package:ble_blood_pressure/src/models/reading.dart';
import 'package:ble_blood_pressure/src/screens/add_device_screen.dart';
import 'package:ble_blood_pressure/src/screens/connected_devices_screen.dart';
import 'package:ble_blood_pressure/src/screens/pairing_screen.dart';
import 'package:ble_blood_pressure/src/screens/reading_screen.dart';
import 'package:flutter/material.dart';

import 'routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// description: This file contains the AppRouter class which handles navigation in the application.
class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case Routes.connectedDevices:
        return MaterialPageRoute(
          builder: (_) => const ConnectedDevicesScreen(),
        );

      case Routes.addDevice:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: getIt<DevicesCubit>(),
            child: const AddDeviceScreen(),
          ),
        );

      case Routes.pairing:
        if (args is BleDevice) {
          return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: getIt<PairingCubit>(),
              child: PairingScreen(device: args),
            ),
          );
        }
        return _errorRoute('Invalid arguments for pairing');

      case Routes.reading:
        if (args is Map<String, dynamic>) {
          final reading = args['reading'] as BpReading;
          final device = args['device'] as BleDevice;
          return MaterialPageRoute(
            builder: (_) => ReadingScreen(reading: reading, device: device),
          );
        }
        return _errorRoute('Invalid arguments for reading');

      default:
        return _errorRoute('No route defined for ${settings.name}');
    }
  }
}

Route _errorRoute(String message) {
  return MaterialPageRoute(
    builder: (_) => Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(child: Text(message)),
    ),
  );
}
