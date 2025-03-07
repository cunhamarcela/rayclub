import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/activity_model.dart';

class ActivityService {
  final FirebaseFirestore _firestore;
  final String _collection = 'activities';

  // Construtor que permite injeção do Firestore
  ActivityService({FirebaseFirestore? firestore}) 
      : _firestore = firestore ?? FirebaseFirestore.instance;

  // Registrar uma nova atividade
  Future<ActivityModel> addActivity(ActivityModel activity) async {
    try {
      final docRef = await _firestore.collection(_collection).add(activity.toMap());
      return activity.copyWith(id: docRef.id);
    } catch (e) {
      print('Erro ao adicionar atividade: $e');
      throw Exception('Falha ao registrar atividade');
    }
  }

  // Obter todas as atividades de um usuário
  Future<List<ActivityModel>> getUserActivities(String userId) async {
    try {
      final snapshot = await _firestore
          .collection(_collection)
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => ActivityModel.fromFirestore(doc.data(), doc.id))
          .toList();
    } catch (e) {
      print('Erro ao buscar atividades: $e');
      throw Exception('Falha ao carregar atividades');
    }
  }

  // Obter atividades de um usuário por tipo
  Future<List<ActivityModel>> getUserActivitiesByType(String userId, String type) async {
    try {
      final snapshot = await _firestore
          .collection(_collection)
          .where('userId', isEqualTo: userId)
          .where('type', isEqualTo: type)
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => ActivityModel.fromFirestore(doc.data(), doc.id))
          .toList();
    } catch (e) {
      print('Erro ao buscar atividades por tipo: $e');
      throw Exception('Falha ao carregar atividades');
    }
  }

  // Obter atividades de um usuário por período
  Future<List<ActivityModel>> getUserActivitiesByPeriod(
      String userId, DateTime startDate, DateTime endDate) async {
    try {
      final snapshot = await _firestore
          .collection(_collection)
          .where('userId', isEqualTo: userId)
          .where('createdAt', isGreaterThanOrEqualTo: startDate.toIso8601String())
          .where('createdAt', isLessThanOrEqualTo: endDate.toIso8601String())
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => ActivityModel.fromFirestore(doc.data(), doc.id))
          .toList();
    } catch (e) {
      print('Erro ao buscar atividades por período: $e');
      throw Exception('Falha ao carregar atividades');
    }
  }

  // Calcular pontos totais de um usuário (otimizado)
  Future<int> calculateUserTotalPoints(String userId) async {
    try {
      // Verificar se existe um documento de cache de pontos
      final userPointsDoc = await _firestore
          .collection('user_points')
          .doc(userId)
          .get();
      
      // Se existir um cache recente, usar esse valor
      if (userPointsDoc.exists) {
        final data = userPointsDoc.data();
        final lastUpdated = data?['lastUpdated'] != null 
            ? DateTime.parse(data!['lastUpdated']) 
            : null;
        
        // Se o cache foi atualizado nas últimas 6 horas, usar o valor em cache
        if (lastUpdated != null && 
            DateTime.now().difference(lastUpdated).inHours < 6) {
          return data!['totalPoints'] ?? 0;
        }
      }
      
      // Se não houver cache ou estiver desatualizado, calcular e atualizar o cache
      final snapshot = await _firestore
          .collection(_collection)
          .where('userId', isEqualTo: userId)
          .get();

      int totalPoints = 0;
      for (var doc in snapshot.docs) {
        final activity = ActivityModel.fromFirestore(doc.data(), doc.id);
        totalPoints += activity.points;
      }
      
      // Atualizar o cache
      await _firestore.collection('user_points').doc(userId).set({
        'totalPoints': totalPoints,
        'lastUpdated': DateTime.now().toIso8601String(),
      });

      return totalPoints;
    } catch (e) {
      print('Erro ao calcular pontos: $e');
      throw Exception('Falha ao calcular pontuação');
    }
  }

  // Atualizar uma atividade
  Future<void> updateActivity(ActivityModel activity) async {
    try {
      await _firestore
          .collection(_collection)
          .doc(activity.id)
          .update(activity.toMap());
    } catch (e) {
      print('Erro ao atualizar atividade: $e');
      throw Exception('Falha ao atualizar atividade');
    }
  }

  // Excluir uma atividade
  Future<void> deleteActivity(String activityId) async {
    try {
      await _firestore.collection(_collection).doc(activityId).delete();
    } catch (e) {
      print('Erro ao excluir atividade: $e');
      throw Exception('Falha ao excluir atividade');
    }
  }
} 