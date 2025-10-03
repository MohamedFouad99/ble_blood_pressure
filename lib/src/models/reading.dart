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

  static BpReading fromJson(Map<String, dynamic> json) => BpReading(
    systolic: json['systolic'],
    diastolic: json['diastolic'],
    pulse: json['pulse'],
    timestamp: DateTime.parse(json['timestamp']),
  );
}
