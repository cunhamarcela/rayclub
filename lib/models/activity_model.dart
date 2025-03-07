class ActivityModel {
  final String id;
  final String userId;
  final String type; // 'exercise', 'water', 'goal'
  final String? exerciseType; // 'cardio', 'strength', 'flexibility', etc.
  final int? duration; // em minutos
  final int? caloriesBurned;
  final int? waterAmount; // em ml
  final bool? goalCompleted;
  final String? goalType;
  final int points; // pontos ganhos por esta atividade
  final DateTime createdAt;
  final Map<String, dynamic>? additionalData;

  ActivityModel({
    required this.id,
    required this.userId,
    required this.type,
    this.exerciseType,
    this.duration,
    this.caloriesBurned,
    this.waterAmount,
    this.goalCompleted,
    this.goalType,
    required this.points,
    required this.createdAt,
    this.additionalData,
  });

  factory ActivityModel.fromFirestore(Map<String, dynamic> data, String id) {
    return ActivityModel(
      id: id,
      userId: data['userId'] ?? '',
      type: data['type'] ?? '',
      exerciseType: data['exerciseType'],
      duration: data['duration'],
      caloriesBurned: data['caloriesBurned'],
      waterAmount: data['waterAmount'],
      goalCompleted: data['goalCompleted'],
      goalType: data['goalType'],
      points: data['points'] ?? 0,
      createdAt: data['createdAt'] != null 
          ? DateTime.parse(data['createdAt']) 
          : DateTime.now(),
      additionalData: data['additionalData'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'type': type,
      'exerciseType': exerciseType,
      'duration': duration,
      'caloriesBurned': caloriesBurned,
      'waterAmount': waterAmount,
      'goalCompleted': goalCompleted,
      'goalType': goalType,
      'points': points,
      'createdAt': createdAt.toIso8601String(),
      'additionalData': additionalData,
    };
  }
  
  /// Cria uma cópia do modelo com os campos especificados alterados
  ActivityModel copyWith({
    String? id,
    String? userId,
    String? type,
    String? exerciseType,
    int? duration,
    int? caloriesBurned,
    int? waterAmount,
    bool? goalCompleted,
    String? goalType,
    int? points,
    DateTime? createdAt,
    Map<String, dynamic>? additionalData,
  }) {
    return ActivityModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      exerciseType: exerciseType ?? this.exerciseType,
      duration: duration ?? this.duration,
      caloriesBurned: caloriesBurned ?? this.caloriesBurned,
      waterAmount: waterAmount ?? this.waterAmount,
      goalCompleted: goalCompleted ?? this.goalCompleted,
      goalType: goalType ?? this.goalType,
      points: points ?? this.points,
      createdAt: createdAt ?? this.createdAt,
      additionalData: additionalData ?? this.additionalData,
    );
  }
} 