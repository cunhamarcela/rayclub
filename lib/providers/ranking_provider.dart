import 'package:flutter/foundation.dart';
import '../models/ranking_model.dart';
import '../services/ranking_service.dart';

class RankingProvider with ChangeNotifier {
  final RankingService _rankingService = RankingService();
  
  List<RankingModel> _topRanking = [];
  RankingModel? _userRanking;
  int _userPosition = 0;
  bool _isLoading = false;
  String? _error;
  
  // Getters
  List<RankingModel> get topRanking => _topRanking;
  RankingModel? get userRanking => _userRanking;
  int get userPosition => _userPosition;
  bool get isLoading => _isLoading;
  String? get error => _error;
  
  // Carregar o ranking geral
  Future<void> loadTopRanking({int limit = 20}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    
    try {
      _topRanking = await _rankingService.getTopRanking(limit: limit);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }
  
  // Carregar o ranking do usuário
  Future<void> loadUserRanking(String userId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    
    try {
      _userRanking = await _rankingService.getUserRanking(userId);
      
      if (_userRanking != null) {
        _userPosition = await _rankingService.getUserRankPosition(userId);
      } else {
        _userPosition = 0;
      }
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }
  
  // Atualizar o ranking do usuário
  Future<void> updateUserRanking(String userId, String userName, String? userPhotoUrl) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    
    try {
      await _rankingService.updateUserRanking(userId, userName, userPhotoUrl);
      
      // Recarregar o ranking do usuário
      _userRanking = await _rankingService.getUserRanking(userId);
      
      if (_userRanking != null) {
        _userPosition = await _rankingService.getUserRankPosition(userId);
      }
      
      // Recarregar o ranking geral
      _topRanking = await _rankingService.getTopRanking();
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }
  
  // Verificar se o usuário está no top ranking
  bool isUserInTopRanking(String userId) {
    return _topRanking.any((ranking) => ranking.userId == userId);
  }
  
  // Obter a posição do usuário no ranking
  Future<void> refreshUserPosition(String userId) async {
    try {
      _userPosition = await _rankingService.getUserRankPosition(userId);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
} 