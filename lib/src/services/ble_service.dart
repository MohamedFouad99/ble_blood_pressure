import '../models/device.dart';

enum ConnectionStatus { connecting, connected, disconnected, failed }

// description: This file contains the BleService abstract class which defines the interface for BLE services.
abstract class BleService {
  /// Scan for BLE devices
  Stream<List<BleDevice>> scanForDevices();

  /// Connect to device by ID
  Stream<ConnectionStatus> connect(String deviceId);

  /// Disconnect from device
  Future<void> disconnect(String deviceId);

  /// Read measurement (mock or real)
  Future<Map<String, dynamic>> readMeasurement(String deviceId);
}
