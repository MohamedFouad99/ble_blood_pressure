import 'dart:async';
import '../models/device.dart';
import 'ble_service.dart';

class MockBleService implements BleService {
  StreamController<List<BleDevice>>? _scanController;

  void _startMockScan() async {
    _scanController?.add([]);
    await Future.delayed(const Duration(milliseconds: 800));
    _scanController?.add([
      BleDevice(id: 'omron_bp7450', name: 'Omron BP7450', rssi: -40),
      BleDevice(id: 'mock_bp_2', name: 'Mock BP Device 2', rssi: -62),
    ]);
  }

  @override
  Stream<List<BleDevice>> scanForDevices() {
    _scanController?.close();
    _scanController = StreamController<List<BleDevice>>.broadcast();
    _startMockScan();
    return _scanController!.stream;
  }

  @override
  Stream<ConnectionStatus> connect(String deviceId) async* {
    yield ConnectionStatus.connecting;
    await Future.delayed(const Duration(seconds: 2));
    yield ConnectionStatus.connected;
  }

  @override
  Future<void> disconnect(String deviceId) async {
    await Future.delayed(const Duration(milliseconds: 200));
  }

  @override
  Future<Map<String, dynamic>> readMeasurement(String deviceId) async {
    await Future.delayed(const Duration(seconds: 1));
    final now = DateTime.now().toIso8601String();
    final systolic = 190 + (deviceId.hashCode % 15);
    final diastolic = 70 + (deviceId.hashCode % 10);
    final pulse = 60 + (deviceId.hashCode % 12);

    return {
      'systolic': systolic,
      'diastolic': diastolic,
      'pulse': pulse,
      'timestamp': now,
    };
  }

  void dispose() {
    _scanController?.close();
  }
}
