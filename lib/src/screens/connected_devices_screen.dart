import 'package:ble_blood_pressure/core/animations/up_down_animation.dart';
import 'package:ble_blood_pressure/core/helpers/spacing.dart';
import 'package:ble_blood_pressure/core/helpers/storage_helper.dart';
import 'package:ble_blood_pressure/core/routing/routes.dart';
import 'package:ble_blood_pressure/core/theming/style.dart';
import 'package:ble_blood_pressure/core/widgets/app_bar_widget.dart';
import 'package:ble_blood_pressure/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      appBar: AppBarWidget(
        title: "ble_blood_pressure".tr(),
        hasBackButton: false,
        onPressed: () {
          final current = context.locale.languageCode;
          if (current == 'en') {
            context.setLocale(const Locale('ar'));
          } else {
            context.setLocale(const Locale('en'));
          }
        },
      ),
      body: UpDownAnimation(
        reverse: true,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 4,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListTile(
                  title: Text(
                    'last_reading'.tr(),
                    style: TextStyles.font16SecondaryBold,
                  ),
                  subtitle: last == null
                      ? Text(
                          'no_last_reading'.tr(),
                          style: TextStyles.font14DarkGrayRegular,
                          textAlign: TextAlign.center,
                        )
                      : Text(
                          '${'systolic'.tr()}: ${last!.systolic} • ${'diastolic'.tr()}: ${last!.diastolic} • ${'pulse'.tr()}: ${last!.pulse}',
                          style: TextStyles.font14BlackRegular,
                        ),
                ),
              ),
              verticalSpace(24),
              CustomButton(
                label: 'add_device'.tr(),
                onTap: () => Navigator.pushNamed(context, Routes.addDevice),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
