// ignore_for_file: use_build_context_synchronously

import 'package:ble_blood_pressure/core/animations/up_down_animation.dart';
import 'package:ble_blood_pressure/core/helpers/spacing.dart';
import 'package:ble_blood_pressure/core/helpers/storage_helper.dart';
import 'package:ble_blood_pressure/core/routing/routes.dart';
import 'package:ble_blood_pressure/core/theming/colors.dart';
import 'package:ble_blood_pressure/core/theming/style.dart';
import 'package:ble_blood_pressure/core/widgets/app_bar_widget.dart';
import 'package:ble_blood_pressure/core/widgets/circle_reading.dart';
import 'package:ble_blood_pressure/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../models/reading.dart';
import '../models/device.dart';

//description: This file contains the ReadingScreen class which builds the screen for displaying a reading.
class ReadingScreen extends StatelessWidget {
  final BpReading reading;
  final BleDevice device;

  const ReadingScreen({required this.reading, required this.device, super.key});

  @override
  /// Builds the reading screen widget tree.
  ///
  /// This widget displays the systolic, diastolic, and pulse readings
  /// in a row of CircleReading widgets. The readings are passed
  /// as a required parameter to the constructor. The widget also
  /// contains a save button that saves the reading to storage and
  /// navigates back to the connected devices screen.
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'reading'.tr(), hasBackButton: true),
      body: UpDownAnimation(
        reverse: true,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 28.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleReading(
                    label: 'systolic'.tr(),
                    value: reading.systolic,
                    max: 200,
                    baseColor: Colors.red,
                  ),
                  horizontalSpace(6),
                  CircleReading(
                    label: 'diastolic'.tr(),
                    value: reading.diastolic,
                    max: 120,
                    baseColor: Colors.blue,
                  ),
                  horizontalSpace(6),
                  CircleReading(
                    label: 'pulse'.tr(),
                    value: reading.pulse,
                    max: 200,
                    baseColor: Colors.green,
                  ),
                ],
              ),

              verticalSpace(28),
              CustomButton(
                onTap: () async {
                  await StorageHelper.saveLastReading(reading);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: ColorsManager.green,
                        content: Text(
                          'saved_success'.tr(),
                          style: TextStyles.font16SecondaryBold.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  }
                  Navigator.pushNamed(context, Routes.connectedDevices);
                },
                label: 'save'.tr(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
