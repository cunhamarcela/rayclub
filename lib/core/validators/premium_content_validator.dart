/// Classe responsável pela validação de dados de conteúdo premium
class PremiumContentValidator {
  /// Valida o título do conteúdo
  static String? validateTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'O título é obrigatório';
    }
    
    if (value.length < 3) {
      return 'O título deve ter pelo menos 3 caracteres';
    }
    
    if (value.length > 100) {
      return 'O título não pode exceder 100 caracteres';
    }
    
    return null;
  }
  
  /// Valida a descrição do conteúdo
  static String? validateDescription(String? value) {
    if (value == null || value.isEmpty) {
      return 'A descrição é obrigatória';
    }
    
    if (value.length < 10) {
      return 'A descrição deve ter pelo menos 10 caracteres';
    }
    
    if (value.length > 1000) {
      return 'A descrição não pode exceder 1000 caracteres';
    }
    
    return null;
  }
  
  /// Valida o tipo de conteúdo
  static String? validateType(String? value) {
    if (value == null || value.isEmpty) {
      return 'O tipo de conteúdo é obrigatório';
    }
    
    final validTypes = ['workout', 'diet', 'benefit'];
    if (!validTypes.contains(value)) {
      return 'Tipo de conteúdo inválido';
    }
    
    return null;
  }
  
  /// Valida a URL da imagem
  static String? validateImageUrl(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Não é obrigatório
    }
    
    final urlPattern = RegExp(
      r'^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$'
    );
    
    if (!urlPattern.hasMatch(value)) {
      return 'URL de imagem inválida';
    }
    
    return null;
  }
  
  /// Valida a URL do vídeo
  static String? validateVideoUrl(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Não é obrigatório
    }
    
    final urlPattern = RegExp(
      r'^(https?:\/\/)?(www\.)?(youtube\.com|youtu\.?be)\/.+$'
    );
    
    if (!urlPattern.hasMatch(value)) {
      return 'URL de vídeo inválida (apenas YouTube é suportado)';
    }
    
    return null;
  }
  
  /// Valida a data de expiração
  static String? validateExpiryDate(DateTime? value) {
    if (value == null) {
      return null; // Não é obrigatório
    }
    
    final now = DateTime.now();
    if (value.isBefore(now)) {
      return 'A data de expiração não pode ser no passado';
    }
    
    return null;
  }
} 