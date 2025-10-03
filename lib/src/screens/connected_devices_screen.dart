import 'package:ble_blood_pressure/core/helpers/storage_helper.dart';
import 'package:ble_blood_pressure/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../models/reading.dart';

class ConnectedDevicesScreen extends StatefulWidget {
  const ConnectedDevicesScreen({super.key});

  @override
  State<ConnectedDevicesScreen> createState() => _ConnectedDevicesScreenState();
}

class _ConnectedDevicesScreenState extends State<ConnectedDevicesScreen> {
  BpReading? last;

  @override
  void initState() {
    super.initState();
    StorageHelper.getLastReading().then((r) {
      if (mounted) setState(() => last = r);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('connected_devices'.tr())),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: ListTile(
                title: Text('last_reading'.tr()),
                subtitle: last == null
                    ? Text('no_last_reading'.tr())
                    : Text(
                        '${'systolic'.tr()}: ${last!.systolic} • ${'diastolic'.tr()}: ${last!.diastolic} • ${'pulse'.tr()}: ${last!.pulse}',
                      ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: Text('add_device'.tr()),
              onPressed: () => Navigator.pushNamed(context, Routes.addDevice),
            ),
          ],
        ),
      ),
    );
  }
}
