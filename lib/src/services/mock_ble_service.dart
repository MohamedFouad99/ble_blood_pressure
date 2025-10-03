import 'dart:async';
import '../models/device.dart';
import 'ble_service.dart';

//description: This file contains the MockBleService class which implements the BleService interface.
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
  /// Scans for nearby BLE devices and returns a stream of the devices found.
  /// The stream will emit an empty list first, followed by a list of devices found.
  /// The stream will not complete until [close] is called on the [BleService] instance.
  Stream<List<BleDevice>> scanForDevices() {
    _scanController?.close();
    _scanController = StreamController<List<BleDevice>>.broadcast();
    _startMockScan();
    return _scanController!.stream;
  }

  @override
  /// A mock implementation of the connect method that returns a stream of connection status.
  /// The stream will first emit [ConnectionStatus.connecting], followed by a delay of 2 seconds, and then
  /// [ConnectionStatus.connected]. The stream is not meant to be used in production code.
  Stream<ConnectionStatus> connect(String deviceId) async* {
    yield ConnectionStatus.connecting;
    await Future.delayed(const Duration(seconds: 2));
    yield ConnectionStatus.connected;
  }

  @override
  /// Disconnects from a BLE device with the given [deviceId].
  ///
  /// This method will complete after a delay of 200 milliseconds.
  ///
  /// [deviceId] is the ID of the BLE device to disconnect from.
  Future<void> disconnect(String deviceId) async {
    await Future.delayed(const Duration(milliseconds: 200));
  }

  @override
  /// A mock implementation of the readMeasurement method that returns a future of a map containing the systolic, diastolic, and pulse values of a reading, as well as the timestamp of the reading.
  /// The future will complete after a delay of 1 second.
  ///
  /// [deviceId] is the ID of the BLE device from which to read the measurement.
  ///
  /// The returned map will contain the following keys:
  /// - 'systolic': the systolic blood pressure value.
  /// - 'diastolic': the diastolic blood pressure value.
  /// - 'pulse': the pulse value.
  /// - 'timestamp': the timestamp of the reading in ISO 8601 format.
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

  /// Closes the stream controller used to emit the list of devices found during
  /// a scan for devices. This method should be called when the instance of the
  /// [BleService] is no longer needed to prevent memory leaks.
  void dispose() {
    _scanController?.close();
  }
}
