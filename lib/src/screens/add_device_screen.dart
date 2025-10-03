import 'package:ble_blood_pressure/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../cubits/devices_cubit.dart';

class AddDeviceScreen extends StatefulWidget {
  const AddDeviceScreen({super.key});

  @override
  State<AddDeviceScreen> createState() => _AddDeviceScreenState();
}

class _AddDeviceScreenState extends State<AddDeviceScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DevicesCubit>().startScan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('add_device'.tr())),
      body: BlocBuilder<DevicesCubit, DevicesState>(
        builder: (context, state) {
          if (state.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.error != null) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Error: ${state.error}'),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => context.read<DevicesCubit>().startScan(),
                    child: Text('retry'.tr()),
                  ),
                ],
              ),
            );
          }
          if (state.devices.isEmpty) {
            return Center(child: Text('no_devices_found'.tr()));
          }
          return ListView.separated(
            itemCount: state.devices.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final d = state.devices[index];
              return ListTile(
                title: Text(d.name),
                subtitle: Text(d.id),
                trailing: Text(d.rssi?.toString() ?? ''),
                onTap: () =>
                    Navigator.pushNamed(context, Routes.pairing, arguments: d),
              );
            },
          );
        },
      ),
    );
  }
}
