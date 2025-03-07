import 'package:flutter/foundation.dart';
import '../models/activity_model.dart';
import '../services/activity_service.dart';
import '../services/ranking_service.dart';
import 'user_provider.dart';

class ActivityProvider with ChangeNotifier {
  final ActivityService _activityService = ActivityService();
  final RankingService _rankingService = RankingService();
  
  List<ActivityModel> _activities = [];
  bool _isLoading = false;
  String? _error;
  
  // Getters
  List<ActivityModel> get activities => _activities;
  bool get isLoading => _isLoading;
  String? get error => _error;
  
  // Carregar atividades do usuário
  Future<void> loadUserActivities(String userId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    
    try {
      _activities = await _activityService.getUserActivities(userId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }
  
  // Adicionar uma nova atividade
  Future<void> addActivity(ActivityModel activity, UserProvider userProvider) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    
    try {
      final newActivity = await _activityService.addActivity(activity);
      _activities.insert(0, newActivity);
      
      // Atualizar o ranking do usuário
      if (userProvider.user != null) {
        await _rankingService.updateUserRanking(
          userProvider.user!.id,
          userProvider.user!.name ?? 'Usuário',
          userProvider.user!.photoUrl,
        );
      }
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }
  
  // Filtrar atividades por tipo
  Future<void> filterActivitiesByType(String userId, String type) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    
    try {
      _activities = await _activityService.getUserActivitiesByType(userId, type);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }
  
  // Filtrar atividades por período
  Future<void> filterActivitiesByPeriod(
      String userId, DateTime startDate, DateTime endDate) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    
    try {
      _activities = await _activityService.getUserActivitiesByPeriod(
          userId, startDate, endDate);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }
  
  // Excluir uma atividade
  Future<void> deleteActivity(String activityId, UserProvider userProvider) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    
    try {
      await _activityService.deleteActivity(activityId);
      _activities.removeWhere((activity) => activity.id == activityId);
      
      // Atualizar o ranking do usuário
      if (userProvider.user != null) {
        await _rankingService.updateUserRanking(
          userProvider.user!.id,
          userProvider.user!.name ?? 'Usuário',
          userProvider.user!.photoUrl,
        );
      }
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }
  
  // Calcular pontos totais do usuário
  Future<int> calculateTotalPoints(String userId) async {
    try {
      return await _activityService.calculateUserTotalPoints(userId);
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return 0;
    }
  }
} 