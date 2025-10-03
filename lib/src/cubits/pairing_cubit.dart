import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/device_repository.dart';
import '../models/reading.dart';
import '../services/ble_service.dart';

class PairingState {
  final ConnectionStatus status;
  final String? error;
  final BpReading? reading;

  PairingState({
    this.status = ConnectionStatus.disconnected,
    this.error,
    this.reading,
  });
}

class PairingCubit extends Cubit<PairingState> {
  final DeviceRepository repo;
  PairingCubit(this.repo) : super(PairingState());

  /// Connects to the device with the given [id].
  ///
  /// Emits a [PairingState] with the [ConnectionStatus.connecting] status.
  /// Then listens to the [DeviceRepository.connect] stream and emits a [PairingState] with
  /// the [ConnectionStatus] received from the stream. If an error occurs, emits a
  /// [PairingState] with the [ConnectionStatus.failed] status and the error message.
  void connect(String id) {
    emit(PairingState(status: ConnectionStatus.connecting));
    repo
        .connect(id)
        .listen(
          (connStatus) {
            emit(PairingState(status: connStatus));
          },
          onError: (e) {
            emit(
              PairingState(
                status: ConnectionStatus.failed,
                error: e.toString(),
              ),
            );
          },
        );
  }

  /// Reads the latest reading from the device with the given [id].
  ///
  /// If the reading is successfully retrieved, a [PairingState] is emitted
  /// with the [ConnectionStatus.connected] status and the reading.
  ///
  /// If an error occurs during the reading process, a [PairingState] is
  /// emitted with the [ConnectionStatus.failed] status and the error message.
  ///
  Future<void> read(String id) async {
    try {
      final json = await repo.read(id);
      final reading = BpReading.fromJson(json);
      emit(PairingState(status: ConnectionStatus.connected, reading: reading));
    } catch (e) {
      emit(PairingState(status: ConnectionStatus.failed, error: e.toString()));
    }
  }
}
