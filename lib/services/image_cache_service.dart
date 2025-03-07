import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'dart:convert';

/// Serviço para gerenciar o cache de imagens
class ImageCacheService {
  static final ImageCacheService _instance = ImageCacheService._internal();
  factory ImageCacheService() => _instance;
  ImageCacheService._internal();
  
  final Map<String, Uint8List> _memoryCache = {};
  
  /// Gera um hash MD5 da URL para usar como nome do arquivo
  String _generateCacheKey(String url) {
    return md5.convert(utf8.encode(url)).toString();
  }
  
  /// Obtém o diretório de cache
  Future<Directory> _getCacheDir() async {
    final dir = await getTemporaryDirectory();
    final cacheDir = Directory('${dir.path}/image_cache');
    if (!await cacheDir.exists()) {
      await cacheDir.create(recursive: true);
    }
    return cacheDir;
  }
  
  /// Verifica se uma imagem está em cache
  Future<bool> isCached(String url) async {
    final cacheKey = _generateCacheKey(url);
    
    // Verificar cache em memória
    if (_memoryCache.containsKey(cacheKey)) {
      return true;
    }
    
    // Verificar cache em disco
    final cacheDir = await _getCacheDir();
    final file = File('${cacheDir.path}/$cacheKey');
    return await file.exists();
  }
  
  /// Obtém uma imagem do cache ou da rede
  Future<Uint8List?> getImage(String url) async {
    final cacheKey = _generateCacheKey(url);
    
    // Tentar obter do cache em memória
    if (_memoryCache.containsKey(cacheKey)) {
      return _memoryCache[cacheKey];
    }
    
    // Tentar obter do cache em disco
    final cacheDir = await _getCacheDir();
    final file = File('${cacheDir.path}/$cacheKey');
    
    if (await file.exists()) {
      final data = await file.readAsBytes();
      // Adicionar ao cache em memória
      _memoryCache[cacheKey] = data;
      return data;
    }
    
    // Baixar da rede
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = response.bodyBytes;
        
        // Salvar no cache em disco
        await file.writeAsBytes(data);
        
        // Adicionar ao cache em memória
        _memoryCache[cacheKey] = data;
        
        return data;
      }
    } catch (e) {
      print('Erro ao baixar imagem: $e');
    }
    
    return null;
  }
  
  /// Limpa o cache em memória
  void clearMemoryCache() {
    _memoryCache.clear();
  }
  
  /// Limpa o cache em disco
  Future<void> clearDiskCache() async {
    final cacheDir = await _getCacheDir();
    if (await cacheDir.exists()) {
      await cacheDir.delete(recursive: true);
      await cacheDir.create();
    }
  }
  
  /// Limpa todo o cache (memória e disco)
  Future<void> clearAllCache() async {
    clearMemoryCache();
    await clearDiskCache();
  }
  
  /// Limpa imagens antigas do cache (mais de 7 dias)
  Future<void> cleanupOldCache() async {
    final cacheDir = await _getCacheDir();
    if (await cacheDir.exists()) {
      final now = DateTime.now();
      final files = await cacheDir.list().toList();
      
      for (var entity in files) {
        if (entity is File) {
          final stat = await entity.stat();
          final fileAge = now.difference(stat.modified);
          
          // Remover arquivos com mais de 7 dias
          if (fileAge.inDays > 7) {
            await entity.delete();
          }
        }
      }
    }
  }
} 