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
