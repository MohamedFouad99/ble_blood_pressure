import 'package:ble_blood_pressure/core/routing/routes.dart';
import 'package:ble_blood_pressure/src/services/ble_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../models/device.dart';
import '../cubits/pairing_cubit.dart';

class PairingScreen extends StatelessWidget {
  final BleDevice device;
  const PairingScreen({required this.device, super.key});

  @override
  Widget build(BuildContext context) {
    final pairingCubit = context.read<PairingCubit>();
    // نبدأ الاتصال عند الظهور
    Future.microtask(() => pairingCubit.connect(device.id));

    return Scaffold(
      appBar: AppBar(title: Text('pairing'.tr())),
      body: BlocConsumer<PairingCubit, PairingState>(
        listener: (context, state) async {
          // لو اتصلنا نطلب قراءة أوفوراً (مرة واحدة)
          if (state.status == ConnectionStatus.connected &&
              state.reading == null) {
            await pairingCubit.read(device.id);
            return;
          }
          // لو القراءة جاهزة ننتقل للشاشة
          if (state.status == ConnectionStatus.connected &&
              state.reading != null) {
            Navigator.pushReplacementNamed(
              context,
              Routes.reading,
              arguments: {'reading': state.reading!, 'device': device},
            );
          }
        },
        builder: (context, state) {
          if (state.status == ConnectionStatus.connecting) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 12),
                  Text('pairing'.tr()),
                ],
              ),
            );
          } else if (state.status == ConnectionStatus.connected &&
              state.reading == null) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('connected'.tr()),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () => pairingCubit.read(device.id),
                    child: Text('reading'.tr()),
                  ),
                ],
              ),
            );
          } else if (state.status == ConnectionStatus.failed) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('${'error_occurred'.tr()}: ${state.error}'),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => pairingCubit.connect(device.id),
                    child: Text('retry'.tr()),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: Text('pairing'.tr()));
          }
        },
      ),
    );
  }
}
