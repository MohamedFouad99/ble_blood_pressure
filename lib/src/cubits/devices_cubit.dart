import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/device.dart';
import '../repositories/device_repository.dart';

class DevicesState {
  final bool loading;
  final List<BleDevice> devices;
  final String? error;

  DevicesState({this.loading = false, this.devices = const [], this.error});
}

class DevicesCubit extends Cubit<DevicesState> {
  final DeviceRepository repo;
  DevicesCubit(this.repo) : super(DevicesState());

  /// Starts scanning for available BLE devices.
  /// Emits [DevicesState] with `loading` set to `true` at the start of the scan,
  /// and then emits another [DevicesState] with `loading` set to `false`, and
  /// `devices` set to the list of available devices if the scan is successful.
  /// If the scan fails, it emits [DevicesState] with `loading` set to `false`, and
  /// `error` set to the error message.
  void startScan() {
    emit(DevicesState(loading: true));
    repo.scan().listen(
      (devices) {
        emit(DevicesState(loading: false, devices: devices));
      },
      onError: (e) {
        emit(DevicesState(loading: false, error: e.toString()));
      },
    );
  }
}
