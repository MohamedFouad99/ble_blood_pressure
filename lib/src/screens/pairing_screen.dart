import 'package:ble_blood_pressure/core/animations/up_down_animation.dart';
import 'package:ble_blood_pressure/core/constants/app_assets.dart';
import 'package:ble_blood_pressure/core/routing/routes.dart';
import 'package:ble_blood_pressure/core/theming/style.dart';
import 'package:ble_blood_pressure/core/widgets/app_bar_widget.dart';
import 'package:ble_blood_pressure/core/widgets/custom_button.dart';
import 'package:ble_blood_pressure/src/services/ble_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:lottie/lottie.dart';
import '../models/device.dart';
import '../cubits/pairing_cubit.dart';

// description: This file contains the PairingScreen class which builds the screen for pairing a device.
class PairingScreen extends StatelessWidget {
  final BleDevice device;
  const PairingScreen({required this.device, super.key});

  @override
  /// Builds the PairingScreen widget tree.
  ///
  /// This widget is a reusable screen used throughout the application. It
  /// has an AppBarWidget with a title and a back button, and a body
  /// containing a BlocConsumer widget that builds the screen based on the
  /// PairingState provided by the PairingCubit. If the state is connecting,
  /// the widget displays a Lottie asset as a loading indicator. If the
  /// state has an error, the widget displays a Column widget containing the
  /// error message and a retry button. If the state has no reading,
  /// the widget displays a Text widget with a message indicating that the device
  /// was paired successfully. If the state has a reading, the widget
  /// displays a Text widget with the reading and navigates to the ReadingScreen
  /// with the reading and device as arguments. If the state is failed, the
  /// widget displays a Text widget with the error message and a retry button.
  Widget build(BuildContext context) {
    final pairingCubit = context.read<PairingCubit>();
    Future.microtask(() => pairingCubit.connect(device.id));

    return Scaffold(
      appBar: AppBarWidget(title: 'pairing'.tr(), hasBackButton: true),
      body: UpDownAnimation(
        reverse: true,
        child: BlocConsumer<PairingCubit, PairingState>(
          listener: (context, state) async {
            if (state.status == ConnectionStatus.connected &&
                state.reading == null) {
              await pairingCubit.read(device.id);
              return;
            }
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
              return Center(child: Lottie.asset(AppAssets.loadingGif));
            } else if (state.status == ConnectionStatus.connected &&
                state.reading == null) {
              return Center(
                child: Text(
                  "paring_done_successfully".tr(),
                  style: TextStyles.font16SecondaryBold,
                ),
              );
            } else if (state.status == ConnectionStatus.failed) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('${'error_occurred'.tr()}: ${state.error}'),
                    const SizedBox(height: 8),
                    CustomButton(
                      onTap: () => pairingCubit.connect(device.id),
                      label: 'retry'.tr(),
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: Text(
                  'pairing'.tr(),
                  style: TextStyles.font16SecondaryBold,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
