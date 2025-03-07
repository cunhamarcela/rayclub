import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/ranking_model.dart';
import 'activity_service.dart';

class RankingService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'rankings';
  final ActivityService _activityService = ActivityService();

  // Obter o ranking de um usuário
  Future<RankingModel?> getUserRanking(String userId) async {
    try {
      final doc = await _firestore
          .collection(_collection)
          .doc(userId)
          .get();

      if (!doc.exists) {
        return null;
      }

      return RankingModel.fromFirestore(doc.data()!, doc.id);
    } catch (e) {
      print('Erro ao buscar ranking do usuário: $e');
      throw Exception('Falha ao carregar ranking');
    }
  }

  // Obter o ranking geral (top N usuários)
  Future<List<RankingModel>> getTopRanking({int limit = 20}) async {
    try {
      final snapshot = await _firestore
          .collection(_collection)
          .orderBy('totalPoints', descending: true)
          .limit(limit)
          .get();

      return snapshot.docs
          .map((doc) => RankingModel.fromFirestore(doc.data(), doc.id))
          .toList();
    } catch (e) {
      print('Erro ao buscar ranking geral: $e');
      throw Exception('Falha ao carregar ranking');
    }
  }

  // Atualizar o ranking de um usuário
  Future<void> updateUserRanking(String userId, String userName, String? userPhotoUrl) async {
    try {
      // Calcular pontos totais do usuário
      final totalPoints = await _activityService.calculateUserTotalPoints(userId);
      
      // Obter pontos por categoria
      final activities = await _activityService.getUserActivities(userId);
      final pointsByCategory = <String, int>{};
      
      for (var activity in activities) {
        final category = activity.type;
        if (pointsByCategory.containsKey(category)) {
          pointsByCategory[category] = (pointsByCategory[category] ?? 0) + activity.points;
        } else {
          pointsByCategory[category] = activity.points;
        }
      }
      
      // Verificar se o usuário já tem um ranking
      final existingRanking = await getUserRanking(userId);
      
      if (existingRanking != null) {
        // Atualizar ranking existente
        final updatedRanking = existingRanking.copyWith(
          userName: userName,
          userPhotoUrl: userPhotoUrl,
          totalPoints: totalPoints,
          pointsByCategory: pointsByCategory,
          lastUpdated: DateTime.now(),
        );
        
        await _firestore
            .collection(_collection)
            .doc(userId)
            .update(updatedRanking.toMap());
      } else {
        // Criar novo ranking
        final newRanking = RankingModel(
          id: userId,
          userId: userId,
          userName: userName,
          userPhotoUrl: userPhotoUrl,
          totalPoints: totalPoints,
          rank: 0, // Será atualizado pelo Cloud Function
          pointsByCategory: pointsByCategory,
          lastUpdated: DateTime.now(),
        );
        
        await _firestore
            .collection(_collection)
            .doc(userId)
            .set(newRanking.toMap());
      }
      
      // Nota: A posição (rank) será atualizada por um Cloud Function que roda periodicamente
    } catch (e) {
      print('Erro ao atualizar ranking: $e');
      throw Exception('Falha ao atualizar ranking');
    }
  }

  // Obter a posição de um usuário no ranking
  Future<int> getUserRankPosition(String userId) async {
    try {
      final userRanking = await getUserRanking(userId);
      
      if (userRanking == null) {
        return 0;
      }
      
      final snapshot = await _firestore
          .collection(_collection)
          .where('totalPoints', isGreaterThan: userRanking.totalPoints)
          .get();
      
      // A posição é o número de usuários com mais pontos + 1
      return snapshot.docs.length + 1;
    } catch (e) {
      print('Erro ao calcular posição no ranking: $e');
      throw Exception('Falha ao calcular posição no ranking');
    }
  }
} 