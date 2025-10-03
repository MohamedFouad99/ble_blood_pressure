// A simple model class representing a BLE device.
class BleDevice {
  final String id;
  final String name;
  final int? rssi;

  BleDevice({required this.id, required this.name, this.rssi});
}
