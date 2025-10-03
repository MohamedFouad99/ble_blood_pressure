import 'package:ble_blood_pressure/core/helpers/storage_helper.dart';
import 'package:ble_blood_pressure/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../models/reading.dart';
import '../models/device.dart';

class ReadingScreen extends StatelessWidget {
  final BpReading reading;
  final BleDevice device;

  const ReadingScreen({required this.reading, required this.device, super.key});

  @override
  Widget build(BuildContext context) {
    final time = reading.timestamp.toLocal();
    return Scaffold(
      appBar: AppBar(title: Text('reading'.tr())),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${'systolic'.tr()}: ${reading.systolic}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 8),
            Text(
              '${'diastolic'.tr()}: ${reading.diastolic}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 8),
            Text(
              '${'pulse'.tr()}: ${reading.pulse}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 12),
            Text('${'timestamp'.tr()}: ${time.toString()}'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await StorageHelper.saveLastReading(reading);
                if (context.mounted) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('saved_success'.tr())));
                }
                Navigator.pushNamed(context, Routes.connectedDevices);
              },
              child: Text('save'.tr()),
            ),
          ],
        ),
      ),
    );
  }
}
