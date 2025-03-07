import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:rayclub/models/activity_model.dart';
import 'package:rayclub/models/ranking_model.dart';
import 'package:rayclub/services/activity_service.dart';
import 'package:rayclub/services/ranking_service.dart';

void main() {
  late FakeFirebaseFirestore fakeFirestore;
  late ActivityService activityService;
  late RankingService rankingService;

  setUp(() {
    fakeFirestore = FakeFirebaseFirestore();
    activityService = ActivityService(firestore: fakeFirestore);
    // Nota: Precisamos refatorar o RankingService também para aceitar uma instância do Firestore
    // rankingService = RankingService(firestore: fakeFirestore, activityService: activityService);
  });

  group('Activity and Ranking Integration Tests', () {
    test('Adding an activity should update user ranking', () async {
      // Arrange
      final userId = 'test-user-123';
      final userName = 'Test User';
      
      // Criar uma atividade de teste
      final testActivity = ActivityModel(
        id: 'temp-id',
        userId: userId,
        type: 'exercise',
        exerciseType: 'cardio',
        duration: 30,
        points: 10,
        createdAt: DateTime.now(),
      );

      // Act
      // 1. Adicionar a atividade
      final addedActivity = await activityService.addActivity(testActivity);
      
      // 2. Atualizar o ranking (após refatoração do RankingService)
      // await rankingService.updateUserRanking(userId, userName, null);
      
      // 3. Obter o ranking atualizado
      // final userRanking = await rankingService.getUserRanking(userId);

      // Assert
      // Verificar se a atividade foi adicionada corretamente
      expect(addedActivity.userId, equals(userId));
      expect(addedActivity.points, equals(10));
      
      // Verificar se o ranking foi atualizado corretamente (após refatoração)
      // expect(userRanking, isNotNull);
      // expect(userRanking!.totalPoints, equals(10));
    });

    test('Multiple activities should accumulate points in ranking', () async {
      // Arrange
      final userId = 'test-user-123';
      final userName = 'Test User';
      
      // Criar múltiplas atividades
      final activities = [
        ActivityModel(
          id: 'temp-id-1',
          userId: userId,
          type: 'exercise',
          points: 10,
          createdAt: DateTime.now(),
        ),
        ActivityModel(
          id: 'temp-id-2',
          userId: userId,
          type: 'water',
          waterAmount: 500,
          points: 5,
          createdAt: DateTime.now(),
        ),
        ActivityModel(
          id: 'temp-id-3',
          userId: userId,
          type: 'goal',
          goalCompleted: true,
          points: 20,
          createdAt: DateTime.now(),
        ),
      ];

      // Act
      // Adicionar todas as atividades
      for (var activity in activities) {
        await activityService.addActivity(activity);
      }
      
      // Calcular pontos totais
      final totalPoints = await activityService.calculateUserTotalPoints(userId);
      
      // Assert
      expect(totalPoints, equals(35)); // 10 + 5 + 20
    });
  });
} 