class UserModel {
  final String id;
  final String email;
  final String? name;
  final String? photoUrl;
  final bool isPremium;
  final DateTime? premiumExpiryDate;
  final String? subscriptionId;

  UserModel({
    required this.id,
    required this.email,
    this.name,
    this.photoUrl,
    this.isPremium = false,
    this.premiumExpiryDate,
    this.subscriptionId,
  });

  factory UserModel.fromFirestore(Map<String, dynamic> data, String id) {
    return UserModel(
      id: id,
      email: data['email'] ?? '',
      name: data['name'],
      photoUrl: data['photoUrl'],
      isPremium: data['isPremium'] ?? false,
      premiumExpiryDate: data['premiumExpiryDate'] != null 
          ? DateTime.parse(data['premiumExpiryDate']) 
          : null,
      subscriptionId: data['subscriptionId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'photoUrl': photoUrl,
      'isPremium': isPremium,
      'premiumExpiryDate': premiumExpiryDate?.toIso8601String(),
      'subscriptionId': subscriptionId,
    };
  }

  UserModel copyWith({
    String? id,
    String? email,
    String? name,
    String? photoUrl,
    bool? isPremium,
    DateTime? premiumExpiryDate,
    String? subscriptionId,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
      isPremium: isPremium ?? this.isPremium,
      premiumExpiryDate: premiumExpiryDate ?? this.premiumExpiryDate,
      subscriptionId: subscriptionId ?? this.subscriptionId,
    );
  }
} 