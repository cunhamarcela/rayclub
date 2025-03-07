class PremiumContentModel {
  final String id;
  final String title;
  final String description;
  final String type; // 'workout', 'diet', 'benefit'
  final String? imageUrl;
  final String? videoUrl;
  final String? documentUrl;
  final Map<String, dynamic>? metadata;
  final DateTime createdAt;
  final DateTime? expiresAt; // Para conteúdo com tempo limitado
  final bool isActive;

  PremiumContentModel({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    this.imageUrl,
    this.videoUrl,
    this.documentUrl,
    this.metadata,
    required this.createdAt,
    this.expiresAt,
    this.isActive = true,
  });

  factory PremiumContentModel.fromFirestore(Map<String, dynamic> data, String id) {
    return PremiumContentModel(
      id: id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      type: data['type'] ?? '',
      imageUrl: data['imageUrl'],
      videoUrl: data['videoUrl'],
      documentUrl: data['documentUrl'],
      metadata: data['metadata'],
      createdAt: data['createdAt'] != null 
          ? DateTime.parse(data['createdAt']) 
          : DateTime.now(),
      expiresAt: data['expiresAt'] != null 
          ? DateTime.parse(data['expiresAt']) 
          : null,
      isActive: data['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'type': type,
      'imageUrl': imageUrl,
      'videoUrl': videoUrl,
      'documentUrl': documentUrl,
      'metadata': metadata,
      'createdAt': createdAt.toIso8601String(),
      'expiresAt': expiresAt?.toIso8601String(),
      'isActive': isActive,
    };
  }
  
  /// Cria uma cópia do modelo com os campos especificados alterados
  PremiumContentModel copyWith({
    String? id,
    String? title,
    String? description,
    String? type,
    String? imageUrl,
    String? videoUrl,
    String? documentUrl,
    Map<String, dynamic>? metadata,
    DateTime? createdAt,
    DateTime? expiresAt,
    bool? isActive,
  }) {
    return PremiumContentModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      imageUrl: imageUrl ?? this.imageUrl,
      videoUrl: videoUrl ?? this.videoUrl,
      documentUrl: documentUrl ?? this.documentUrl,
      metadata: metadata ?? this.metadata,
      createdAt: createdAt ?? this.createdAt,
      expiresAt: expiresAt ?? this.expiresAt,
      isActive: isActive ?? this.isActive,
    );
  }
} 