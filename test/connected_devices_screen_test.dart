import 'package:ble_blood_pressure/core/widgets/custom_button.dart';
import 'package:ble_blood_pressure/src/screens/connected_devices_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

/// Tests that pressing the add device button navigates to the add device screen.
///
/// This test creates a MaterialApp with the ConnectedDevicesScreen as the home
/// and a route for the add device screen. It then pumps the widget tree and
/// waits for the widgets to settle. Finally, it taps the add device button
/// and verifies that the add device screen is displayed.
void main() {
  testWidgets('press add_device button', (WidgetTester tester) async {
    await tester.pumpWidget(
      EasyLocalization(
        supportedLocales: const [Locale('en')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        startLocale: const Locale('en'),
        child: ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (_, __) => MaterialApp(
            home: const ConnectedDevicesScreen(),
            routes: {
              '/addDevice': (_) => const Scaffold(
                body: Center(child: Text('AddDevice Dummy Page')),
              ),
            },
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    final button = find.byType(CustomButton);
    expect(button, findsOneWidget);

    await tester.tap(button);
    await tester.pumpAndSettle();

    expect(find.text('AddDevice Dummy Page'), findsOneWidget);
  });
}
