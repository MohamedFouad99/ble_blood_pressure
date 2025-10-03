import 'dart:convert';
import 'package:ble_blood_pressure/src/models/reading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageHelper {
  static const _lastReadingKey = 'last_reading';

  static Future<void> saveLastReading(BpReading r) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_lastReadingKey, jsonEncode(r.toJson()));
  }

  static Future<BpReading?> getLastReading() async {
    final prefs = await SharedPreferences.getInstance();
    final s = prefs.getString(_lastReadingKey);
    if (s == null) return null;
    return BpReading.fromJson(jsonDecode(s));
  }
}
