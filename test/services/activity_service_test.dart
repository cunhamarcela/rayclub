import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:rayclub/models/activity_model.dart';
import 'package:rayclub/services/activity_service.dart';

// Gera mocks para o Firestore
@GenerateMocks([FirebaseFirestore, CollectionReference, DocumentReference, QuerySnapshot])
void main() {
  late ActivityService activityService;
  late FakeFirebaseFirestore fakeFirestore;

  setUp(() {
    fakeFirestore = FakeFirebaseFirestore();
    activityService = ActivityService(firestore: fakeFirestore);
  });

  group('ActivityService Tests', () {
    test('addActivity should add an activity to Firestore', () async {
      // Arrange
      final testActivity = ActivityModel(
        id: 'test-id',
        userId: 'user-123',
        type: 'exercise',
        exerciseType: 'cardio',
        duration: 30,
        points: 10,
        createdAt: DateTime.now(),
      );

      // Act
      final result = await activityService.addActivity(testActivity);

      // Assert
      expect(result.id, isNot('test-id')); // ID deve ser gerado pelo Firestore
      expect(result.userId, equals('user-123'));
      expect(result.type, equals('exercise'));
      expect(result.exerciseType, equals('cardio'));
      expect(result.duration, equals(30));
      expect(result.points, equals(10));
      
      // Verificar se foi salvo no Firestore
      final snapshot = await fakeFirestore.collection('activities').get();
      expect(snapshot.docs.length, equals(1));
      expect(snapshot.docs.first.data()['userId'], equals('user-123'));
      expect(snapshot.docs.first.data()['type'], equals('exercise'));
    });

    test('getUserActivities should return activities for a specific user', () async {
      // Arrange
      final userId = 'user-123';
      
      // Adicionar algumas atividades de teste
      await fakeFirestore.collection('activities').add({
        'userId': userId,
        'type': 'exercise',
        'exerciseType': 'cardio',
        'duration': 30,
        'points': 10,
        'createdAt': DateTime.now().toIso8601String(),
      });
      
      await fakeFirestore.collection('activities').add({
        'userId': userId,
        'type': 'water',
        'waterAmount': 500,
        'points': 5,
        'createdAt': DateTime.now().toIso8601String(),
      });
      
      await fakeFirestore.collection('activities').add({
        'userId': 'other-user',
        'type': 'exercise',
        'points': 15,
        'createdAt': DateTime.now().toIso8601String(),
      });

      // Act
      final activities = await activityService.getUserActivities(userId);

      // Assert
      expect(activities.length, equals(2));
      expect(activities.every((activity) => activity.userId == userId), isTrue);
    });

    test('getUserActivitiesByType should return activities of a specific type', () async {
      // Arrange
      final userId = 'user-123';
      
      // Adicionar algumas atividades de teste
      await fakeFirestore.collection('activities').add({
        'userId': userId,
        'type': 'exercise',
        'exerciseType': 'cardio',
        'duration': 30,
        'points': 10,
        'createdAt': DateTime.now().toIso8601String(),
      });
      
      await fakeFirestore.collection('activities').add({
        'userId': userId,
        'type': 'water',
        'waterAmount': 500,
        'points': 5,
        'createdAt': DateTime.now().toIso8601String(),
      });
      
      await fakeFirestore.collection('activities').add({
        'userId': userId,
        'type': 'exercise',
        'exerciseType': 'strength',
        'duration': 45,
        'points': 15,
        'createdAt': DateTime.now().toIso8601String(),
      });

      // Act
      final activities = await activityService.getUserActivitiesByType(userId, 'exercise');

      // Assert
      expect(activities.length, equals(2));
      expect(activities.every((activity) => activity.type == 'exercise'), isTrue);
    });

    test('calculateUserTotalPoints should sum all activity points correctly', () async {
      // Arrange
      final userId = 'user-123';
      
      // Adicionar atividades com pontos conhecidos
      await fakeFirestore.collection('activities').add({
        'userId': userId,
        'type': 'exercise',
        'points': 10,
        'createdAt': DateTime.now().toIso8601String(),
      });
      
      await fakeFirestore.collection('activities').add({
        'userId': userId,
        'type': 'water',
        'points': 5,
        'createdAt': DateTime.now().toIso8601String(),
      });
      
      await fakeFirestore.collection('activities').add({
        'userId': userId,
        'type': 'goal',
        'points': 20,
        'createdAt': DateTime.now().toIso8601String(),
      });

      // Act
      final totalPoints = await activityService.calculateUserTotalPoints(userId);

      // Assert
      expect(totalPoints, equals(35)); // 10 + 5 + 20
    });
    
    test('deleteActivity should remove an activity from Firestore', () async {
      // Arrange
      final userId = 'user-123';
      
      // Adicionar uma atividade
      final docRef = await fakeFirestore.collection('activities').add({
        'userId': userId,
        'type': 'exercise',
        'points': 10,
        'createdAt': DateTime.now().toIso8601String(),
      });
      
      // Verificar que foi adicionada
      var snapshot = await fakeFirestore.collection('activities').get();
      expect(snapshot.docs.length, equals(1));

      // Act
      await activityService.deleteActivity(docRef.id);

      // Assert
      snapshot = await fakeFirestore.collection('activities').get();
      expect(snapshot.docs.length, equals(0));
    });
  });
} 