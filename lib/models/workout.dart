class Workout {
  final String name;
  final String description;
  final DateTime date;
  final int duration; // in minutes
  final double caloriesBurned;
  final String type; // e.g., 'Cardio', 'Strength', 'Flexibility'

  Workout({
    required this.name,
    required this.description,
    required this.date,
    required this.duration,
    required this.caloriesBurned,
    required this.type,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'date': date.toIso8601String(),
      'duration': duration,
      'caloriesBurned': caloriesBurned,
      'type': type,
    };
  }

  factory Workout.fromJson(Map<String, dynamic> json) {
    try {
      return Workout(
        name: json['name'] as String? ?? '',
        description: json['description'] as String? ?? '',
        date: json['date'] != null ? DateTime.parse(json['date'] as String) : DateTime.now(),
        duration: json['duration'] as int? ?? 0,
        caloriesBurned: (json['caloriesBurned'] as num?)?.toDouble() ?? 0.0,
        type: json['type'] as String? ?? 'Other',
      );
    } catch (e) {
      // Return a default workout if parsing fails
      return Workout(
        name: '',
        description: '',
        date: DateTime.now(),
        duration: 0,
        caloriesBurned: 0.0,
        type: 'Other',
      );
    }
  }

  Workout copyWith({
    String? name,
    String? description,
    DateTime? date,
    int? duration,
    double? caloriesBurned,
    String? type,
  }) {
    return Workout(
      name: name ?? this.name,
      description: description ?? this.description,
      date: date ?? this.date,
      duration: duration ?? this.duration,
      caloriesBurned: caloriesBurned ?? this.caloriesBurned,
      type: type ?? this.type,
    );
  }
} 