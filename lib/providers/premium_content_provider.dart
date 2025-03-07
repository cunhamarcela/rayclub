import 'package:flutter/foundation.dart';
import '../models/premium_content_model.dart';
import '../services/premium_content_service.dart';

class PremiumContentProvider with ChangeNotifier {
  final PremiumContentService _premiumContentService = PremiumContentService();
  
  List<PremiumContentModel> _premiumContent = [];
  PremiumContentModel? _selectedContent;
  bool _isLoading = false;
  String? _error;
  
  // Getters
  List<PremiumContentModel> get premiumContent => _premiumContent;
  PremiumContentModel? get selectedContent => _selectedContent;
  bool get isLoading => _isLoading;
  String? get error => _error;
  
  // Carregar todo o conteúdo premium
  Future<void> loadAllPremiumContent() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    
    try {
      _premiumContent = await _premiumContentService.getAllPremiumContent();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }
  
  // Carregar conteúdo premium por tipo
  Future<void> loadPremiumContentByType(String type) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    
    try {
      _premiumContent = await _premiumContentService.getPremiumContentByType(type);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }
  
  // Selecionar um conteúdo premium específico
  Future<void> selectPremiumContent(String contentId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    
    try {
      _selectedContent = await _premiumContentService.getPremiumContentById(contentId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }
  
  // Limpar o conteúdo selecionado
  void clearSelectedContent() {
    _selectedContent = null;
    notifyListeners();
  }
  
  // Adicionar novo conteúdo premium (apenas para administradores)
  Future<void> addPremiumContent(PremiumContentModel content) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    
    try {
      final newContent = await _premiumContentService.addPremiumContent(content);
      _premiumContent.insert(0, newContent);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }
  
  // Atualizar conteúdo premium (apenas para administradores)
  Future<void> updatePremiumContent(PremiumContentModel content) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    
    try {
      await _premiumContentService.updatePremiumContent(content);
      
      // Atualizar na lista local
      final index = _premiumContent.indexWhere((item) => item.id == content.id);
      if (index != -1) {
        _premiumContent[index] = content;
      }
      
      // Atualizar o conteúdo selecionado se for o mesmo
      if (_selectedContent != null && _selectedContent!.id == content.id) {
        _selectedContent = content;
      }
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }
  
  // Desativar conteúdo premium (soft delete)
  Future<void> deactivatePremiumContent(String contentId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    
    try {
      await _premiumContentService.deactivatePremiumContent(contentId);
      
      // Remover da lista local
      _premiumContent.removeWhere((content) => content.id == contentId);
      
      // Limpar o conteúdo selecionado se for o mesmo
      if (_selectedContent != null && _selectedContent!.id == contentId) {
        _selectedContent = null;
      }
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }
} 