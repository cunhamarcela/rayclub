import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'users';

  Future<UserModel?> getUser(String userId) async {
    try {
      final doc = await _firestore.collection(_collection).doc(userId).get();
      if (doc.exists) {
        return UserModel.fromFirestore(doc.data()!, doc.id);
      }
      return null;
    } catch (e) {
      print('Erro ao buscar usuário: $e');
      return null;
    }
  }

  Future<void> createUser(UserModel user) async {
    try {
      await _firestore.collection(_collection).doc(user.id).set(user.toMap());
    } catch (e) {
      print('Erro ao criar usuário: $e');
      rethrow;
    }
  }

  Future<void> updateUserPremiumStatus({
    required String userId,
    required bool isPremium,
    required DateTime? expiryDate,
    String? subscriptionId,
  }) async {
    try {
      await _firestore.collection(_collection).doc(userId).update({
        'isPremium': isPremium,
        'premiumExpiryDate': expiryDate?.toIso8601String(),
        'subscriptionId': subscriptionId,
      });
    } catch (e) {
      print('Erro ao atualizar status premium: $e');
      rethrow;
    }
  }

  Stream<UserModel?> userStream(String userId) {
    return _firestore
        .collection(_collection)
        .doc(userId)
        .snapshots()
        .map((doc) {
          if (doc.exists) {
            return UserModel.fromFirestore(doc.data()!, doc.id);
          }
          return null;
        });
  }

  void checkPremiumExpiry(String userId) {
    userStream(userId).listen((user) {
      if (user != null && user.isPremium && user.premiumExpiryDate != null) {
        if (user.premiumExpiryDate!.isBefore(DateTime.now())) {
          updateUserPremiumStatus(
            userId: userId,
            isPremium: false,
            expiryDate: null,
            subscriptionId: null,
          );
        }
      }
    });
  }
} 