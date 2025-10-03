import 'package:ble_blood_pressure/src/cubits/devices_cubit.dart';
import 'package:ble_blood_pressure/src/models/device.dart';
import 'package:ble_blood_pressure/src/repositories/device_repository.dart';
import 'package:ble_blood_pressure/src/screens/add_device_screen.dart';
import 'package:ble_blood_pressure/src/services/ble_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

/// Tests the AddDeviceScreen widget.
///
/// The tests are as follows:
///
/// - Test that the AddDeviceScreen widget shows a loading indicator when the
///    DevicesState is loading.
/// - Test that the AddDeviceScreen widget shows a message indicating that no
///    devices were found when the DevicesState is not loading and there are
///    no devices in the list.
/// - Test that the AddDeviceScreen widget shows a device in the list when
///    the DevicesState is not loading and there are devices in the list.
void main() {
  testWidgets('shows loading indicator when loading is true', (tester) async {
    final cubit = DevicesCubit(FakeRepo());
    cubit.emit(DevicesState(loading: true));

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(value: cubit, child: const AddDeviceScreen()),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('shows no devices message when list is empty', (tester) async {
    final cubit = DevicesCubit(FakeRepo());
    cubit.emit(DevicesState(loading: false, devices: []));

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(value: cubit, child: const AddDeviceScreen()),
      ),
    );

    expect(find.text('no_devices_found'), findsOneWidget);
  });

  testWidgets('shows device in list when devices are present', (tester) async {
    final cubit = DevicesCubit(FakeRepo());
    cubit.emit(
      DevicesState(
        loading: false,
        devices: [BleDevice(id: '1', name: 'Mock Device', rssi: -40)],
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(value: cubit, child: const AddDeviceScreen()),
      ),
    );

    expect(find.text('Mock Device'), findsOneWidget);
  });
}

/// Fake repo to satisfy constructor

class FakeRepo implements DeviceRepository {
  @override
  Stream<List<BleDevice>> scan() {
    // fake empty scan stream
    return const Stream.empty();
  }

  @override
  BleService get bleService {
    throw UnimplementedError('bleService not needed in tests');
  }

  @override
  Stream<ConnectionStatus> connect(String id) async* {
    yield ConnectionStatus.connected;
  }

  @override
  Future<void> disconnect(String id) async {
    return;
  }

  @override
  Future<Map<String, dynamic>> read(String id) async {
    return {
      'systolic': 120,
      'diastolic': 80,
      'pulse': 72,
      'timestamp': DateTime.now().toIso8601String(),
    };
  }
}
