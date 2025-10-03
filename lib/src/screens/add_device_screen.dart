import 'package:ble_blood_pressure/core/animations/up_down_animation.dart';
import 'package:ble_blood_pressure/core/constants/app_assets.dart';
import 'package:ble_blood_pressure/core/helpers/spacing.dart';
import 'package:ble_blood_pressure/core/routing/routes.dart';
import 'package:ble_blood_pressure/core/theming/style.dart';
import 'package:ble_blood_pressure/core/widgets/app_bar_widget.dart';
import 'package:ble_blood_pressure/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../cubits/devices_cubit.dart';
import 'package:lottie/lottie.dart';

// description: This file contains the AddDeviceScreen class which builds the screen for adding a device.
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
  /// Builds the AddDeviceScreen widget tree.
  ///
  /// This widget is a reusable screen used throughout the application. It
  /// has a AppBarWidget with a title and a back button, and a body
  /// containing a BlocBuilder widget that builds the screen based on the
  /// DevicesState provided by the DevicesCubit. If the state is loading,
  /// the widget displays a Lottie asset as a loading indicator. If the
  /// state has an error, the widget displays a Column widget containing the
  /// error message and a retry button. If the state has no devices,
  /// the widget displays a Text widget with a message indicating that no devices
  /// were found. If the state has devices, the widget displays a ListView
  /// widget containing the devices found.
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'add_device'.tr(), hasBackButton: true),
      body: BlocBuilder<DevicesCubit, DevicesState>(
        builder: (context, state) {
          if (state.loading) {
            return Center(child: Lottie.asset(AppAssets.loadingGif));
          }
          if (state.error != null) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Error: ${state.error}'),
                  verticalSpace(8),
                  CustomButton(
                    onTap: () => context.read<DevicesCubit>().startScan(),
                    label: 'retry'.tr(),
                  ),
                ],
              ),
            );
          }
          if (state.devices.isEmpty) {
            return Center(
              child: Text(
                'no_devices_found'.tr(),
                style: TextStyles.font14BlackRegular,
              ),
            );
          }
          return UpDownAnimation(
            reverse: true,
            child: ListView.builder(
              itemCount: state.devices.length,
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              itemBuilder: (context, index) {
                final d = state.devices[index];
                return Card(
                  elevation: 4,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    title: Text(d.name, style: TextStyles.font16SecondaryBold),
                    subtitle: Text(d.id, style: TextStyles.font14BlackRegular),
                    trailing: Text(
                      d.rssi?.toString() ?? '',
                      style: TextStyles.font14BlackRegular,
                    ),
                    onTap: () => Navigator.pushNamed(
                      context,
                      Routes.pairing,
                      arguments: d,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
