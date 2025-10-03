import 'package:ble_blood_pressure/src/cubits/devices_cubit.dart';
import 'package:ble_blood_pressure/src/cubits/pairing_cubit.dart';
import 'package:ble_blood_pressure/src/repositories/device_repository.dart';
import 'package:ble_blood_pressure/src/services/ble_service.dart';
import 'package:ble_blood_pressure/src/services/mock_ble_service.dart';
import 'package:get_it/get_it.dart';

// description: This file contains the service locator used in the application.
final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Services
  getIt.registerLazySingleton<BleService>(() => MockBleService());

  // Repository
  getIt.registerLazySingleton<DeviceRepository>(
    () => DeviceRepository(getIt<BleService>()),
  );

  // Cubits
  getIt.registerFactory<DevicesCubit>(
    () => DevicesCubit(getIt<DeviceRepository>()),
  );
  getIt.registerFactory<PairingCubit>(
    () => PairingCubit(getIt<DeviceRepository>()),
  );
}
