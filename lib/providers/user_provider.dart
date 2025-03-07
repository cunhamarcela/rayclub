import 'package:flutter/foundation.dart';
import '../models/user_model.dart';
import '../services/user_service.dart';

class UserProvider extends ChangeNotifier {
  final UserService _userService = UserService();
  UserModel? _user;
  bool _loading = false;

  UserModel? get user => _user;
  bool get loading => _loading;
  bool get isPremium => _user?.isPremium ?? false;

  Future<void> loadUser(String userId) async {
    _loading = true;
    notifyListeners();

    try {
      _user = await _userService.getUser(userId);
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  void startListeningToUser(String userId) {
    _userService.userStream(userId).listen((user) {
      _user = user;
      notifyListeners();
    });
  }

  Future<void> updatePremiumStatus({
    required String userId,
    required bool isPremium,
    required DateTime? expiryDate,
    String? subscriptionId,
  }) async {
    try {
      await _userService.updateUserPremiumStatus(
        userId: userId,
        isPremium: isPremium,
        expiryDate: expiryDate,
        subscriptionId: subscriptionId,
      );
    } catch (e) {
      print('Erro ao atualizar status premium: $e');
      rethrow;
    }
  }

  void checkPremiumExpiry(String userId) {
    if (_user?.isPremium == true && _user?.premiumExpiryDate != null) {
      if (_user!.premiumExpiryDate!.isBefore(DateTime.now())) {
        updatePremiumStatus(
          userId: userId,
          isPremium: false,
          expiryDate: null,
        );
      }
    }
  }
} 