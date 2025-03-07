import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/premium_content_model.dart';

class PremiumContentService {
  final FirebaseFirestore _firestore;
  final String _collection = 'premium_content';

  // Construtor que permite injeção do Firestore
  PremiumContentService({FirebaseFirestore? firestore}) 
      : _firestore = firestore ?? FirebaseFirestore.instance;

  // Obter todo o conteúdo premium
  Future<List<PremiumContentModel>> getAllPremiumContent() async {
    try {
      final snapshot = await _firestore
          .collection(_collection)
          .where('isActive', isEqualTo: true)
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => PremiumContentModel.fromFirestore(doc.data(), doc.id))
          .toList();
    } catch (e) {
      print('Erro ao buscar conteúdo premium: $e');
      throw Exception('Falha ao carregar conteúdo premium');
    }
  }

  // Obter conteúdo premium por tipo
  Future<List<PremiumContentModel>> getPremiumContentByType(String type) async {
    try {
      final snapshot = await _firestore
          .collection(_collection)
          .where('type', isEqualTo: type)
          .where('isActive', isEqualTo: true)
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => PremiumContentModel.fromFirestore(doc.data(), doc.id))
          .toList();
    } catch (e) {
      print('Erro ao buscar conteúdo premium por tipo: $e');
      throw Exception('Falha ao carregar conteúdo premium');
    }
  }

  // Obter um conteúdo premium específico
  Future<PremiumContentModel?> getPremiumContentById(String contentId) async {
    try {
      final doc = await _firestore
          .collection(_collection)
          .doc(contentId)
          .get();

      if (!doc.exists) {
        return null;
      }

      return PremiumContentModel.fromFirestore(doc.data()!, doc.id);
    } catch (e) {
      print('Erro ao buscar conteúdo premium: $e');
      throw Exception('Falha ao carregar conteúdo premium');
    }
  }

  // Adicionar novo conteúdo premium (apenas para administradores)
  Future<PremiumContentModel> addPremiumContent(PremiumContentModel content) async {
    try {
      final docRef = await _firestore
          .collection(_collection)
          .add(content.toMap());
      
      return content.copyWith(id: docRef.id);
    } catch (e) {
      print('Erro ao adicionar conteúdo premium: $e');
      throw Exception('Falha ao adicionar conteúdo premium');
    }
  }

  // Atualizar conteúdo premium (apenas para administradores)
  Future<void> updatePremiumContent(PremiumContentModel content) async {
    try {
      await _firestore
          .collection(_collection)
          .doc(content.id)
          .update(content.toMap());
    } catch (e) {
      print('Erro ao atualizar conteúdo premium: $e');
      throw Exception('Falha ao atualizar conteúdo premium');
    }
  }

  // Desativar conteúdo premium (soft delete)
  Future<void> deactivatePremiumContent(String contentId) async {
    try {
      await _firestore
          .collection(_collection)
          .doc(contentId)
          .update({'isActive': false});
    } catch (e) {
      print('Erro ao desativar conteúdo premium: $e');
      throw Exception('Falha ao desativar conteúdo premium');
    }
  }
} 