class RankingModel {
  final String id;
  final String userId;
  final String userName;
  final String? userPhotoUrl;
  final int totalPoints;
  final int rank; // posição no ranking
  final Map<String, int> pointsByCategory; // pontos por categoria de atividade
  final DateTime lastUpdated;
  final Map<String, dynamic>? achievements; // conquistas desbloqueadas

  RankingModel({
    required this.id,
    required this.userId,
    required this.userName,
    this.userPhotoUrl,
    required this.totalPoints,
    required this.rank,
    required this.pointsByCategory,
    required this.lastUpdated,
    this.achievements,
  });

  factory RankingModel.fromFirestore(Map<String, dynamic> data, String id) {
    return RankingModel(
      id: id,
      userId: data['userId'] ?? '',
      userName: data['userName'] ?? 'Usuário',
      userPhotoUrl: data['userPhotoUrl'],
      totalPoints: data['totalPoints'] ?? 0,
      rank: data['rank'] ?? 0,
      pointsByCategory: Map<String, int>.from(data['pointsByCategory'] ?? {}),
      lastUpdated: data['lastUpdated'] != null 
          ? DateTime.parse(data['lastUpdated']) 
          : DateTime.now(),
      achievements: data['achievements'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userName': userName,
      'userPhotoUrl': userPhotoUrl,
      'totalPoints': totalPoints,
      'rank': rank,
      'pointsByCategory': pointsByCategory,
      'lastUpdated': lastUpdated.toIso8601String(),
      'achievements': achievements,
    };
  }

  RankingModel copyWith({
    String? id,
    String? userId,
    String? userName,
    String? userPhotoUrl,
    int? totalPoints,
    int? rank,
    Map<String, int>? pointsByCategory,
    DateTime? lastUpdated,
    Map<String, dynamic>? achievements,
  }) {
    return RankingModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userPhotoUrl: userPhotoUrl ?? this.userPhotoUrl,
      totalPoints: totalPoints ?? this.totalPoints,
      rank: rank ?? this.rank,
      pointsByCategory: pointsByCategory ?? this.pointsByCategory,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      achievements: achievements ?? this.achievements,
    );
  }
} 