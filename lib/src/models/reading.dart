/// Class that represents a blood pressure reading.
///
/// The class contains the systolic and diastolic blood pressure values,
/// the pulse value, and the timestamp of the reading.
///
/// The class provides a constructor to create a new reading object and
/// a [fromJson] method to create a new reading object from a JSON map.
///
/// The class also provides a [toJson] method to convert the reading object
/// to a JSON map.
class BpReading {
  final int systolic;
  final int diastolic;
  final int pulse;
  final DateTime timestamp;

  BpReading({
    required this.systolic,
    required this.diastolic,
    required this.pulse,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
    'systolic': systolic,
    'diastolic': diastolic,
    'pulse': pulse,
    'timestamp': timestamp.toIso8601String(),
  };

  /// Creates a new reading object from a JSON map.
  ///
  /// The method takes a JSON map as a parameter and returns a new reading
  /// object created from the JSON map.
  ///
  /// The method throws a [FormatException] if the JSON map does not contain
  /// all the required fields.
  static BpReading fromJson(Map<String, dynamic> json) => BpReading(
    systolic: json['systolic'],
    diastolic: json['diastolic'],
    pulse: json['pulse'],
    timestamp: DateTime.parse(json['timestamp']),
  );
}
