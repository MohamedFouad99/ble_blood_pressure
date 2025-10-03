import '../services/ble_service.dart';
import '../models/device.dart';

// description: This file contains the DeviceRepository class which handles the communication with the BLE service.
class DeviceRepository {
  final BleService bleService;
  DeviceRepository(this.bleService);

  Stream<List<BleDevice>> scan() => bleService.scanForDevices();

  Stream<ConnectionStatus> connect(String id) => bleService.connect(id);

  Future<Map<String, dynamic>> read(String id) =>
      bleService.readMeasurement(id);

  Future<void> disconnect(String id) => bleService.disconnect(id);
}
