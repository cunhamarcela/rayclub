import 'package:flutter/material.dart';

/// Classe responsável pela validação de dados de atividades
class ActivityValidator {
  /// Valida o tipo de atividade
  static String? validateType(String? value) {
    if (value == null || value.isEmpty) {
      return 'O tipo de atividade é obrigatório';
    }
    
    final validTypes = ['exercise', 'water', 'goal'];
    if (!validTypes.contains(value)) {
      return 'Tipo de atividade inválido';
    }
    
    return null;
  }
  
  /// Valida o tipo de exercício
  static String? validateExerciseType(String? value, String activityType) {
    if (activityType != 'exercise') {
      return null; // Não é necessário para outros tipos de atividade
    }
    
    if (value == null || value.isEmpty) {
      return 'O tipo de exercício é obrigatório';
    }
    
    final validExerciseTypes = [
      'cardio', 'strength', 'flexibility', 'sports', 'other'
    ];
    
    if (!validExerciseTypes.contains(value)) {
      return 'Tipo de exercício inválido';
    }
    
    return null;
  }
  
  /// Valida a duração do exercício
  static String? validateDuration(String? value, String activityType) {
    if (activityType != 'exercise') {
      return null; // Não é necessário para outros tipos de atividade
    }
    
    if (value == null || value.isEmpty) {
      return 'A duração é obrigatória';
    }
    
    final duration = int.tryParse(value);
    if (duration == null) {
      return 'A duração deve ser um número';
    }
    
    if (duration <= 0) {
      return 'A duração deve ser maior que zero';
    }
    
    if (duration > 1440) { // 24 horas em minutos
      return 'A duração não pode exceder 24 horas';
    }
    
    return null;
  }
  
  /// Valida a quantidade de água
  static String? validateWaterAmount(String? value, String activityType) {
    if (activityType != 'water') {
      return null; // Não é necessário para outros tipos de atividade
    }
    
    if (value == null || value.isEmpty) {
      return 'A quantidade de água é obrigatória';
    }
    
    final amount = int.tryParse(value);
    if (amount == null) {
      return 'A quantidade deve ser um número';
    }
    
    if (amount <= 0) {
      return 'A quantidade deve ser maior que zero';
    }
    
    if (amount > 5000) { // Limite razoável em ml
      return 'A quantidade não pode exceder 5000ml';
    }
    
    return null;
  }
  
  /// Valida o tipo de meta
  static String? validateGoalType(String? value, String activityType) {
    if (activityType != 'goal') {
      return null; // Não é necessário para outros tipos de atividade
    }
    
    if (value == null || value.isEmpty) {
      return 'O tipo de meta é obrigatório';
    }
    
    final validGoalTypes = [
      'steps', 'workout', 'water', 'sleep', 'nutrition', 'other'
    ];
    
    if (!validGoalTypes.contains(value)) {
      return 'Tipo de meta inválido';
    }
    
    return null;
  }
  
  /// Calcula pontos baseados no tipo de atividade e seus parâmetros
  static int calculatePoints({
    required String type,
    String? exerciseType,
    int? duration,
    int? waterAmount,
    bool? goalCompleted,
    String? goalType,
  }) {
    switch (type) {
      case 'exercise':
        if (duration == null) return 0;
        
        // Base: 10 pontos por 30 minutos
        int basePoints = (duration / 30 * 10).round();
        
        // Bônus por tipo de exercício
        if (exerciseType == 'cardio') basePoints += 2;
        if (exerciseType == 'strength') basePoints += 3;
        
        return basePoints;
        
      case 'water':
        if (waterAmount == null) return 0;
        
        // 1 ponto para cada 250ml
        return (waterAmount / 250).round();
        
      case 'goal':
        if (goalCompleted != true) return 0;
        
        // Pontos base por completar uma meta
        int points = 20;
        
        // Bônus por tipo de meta
        if (goalType == 'steps') points += 5;
        if (goalType == 'workout') points += 10;
        
        return points;
        
      default:
        return 0;
    }
  }
} 