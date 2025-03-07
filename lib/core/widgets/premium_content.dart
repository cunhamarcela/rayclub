import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';

class PremiumContent extends StatelessWidget {
  final Widget child;
  final Widget? fallback;

  const PremiumContent({
    Key? key,
    required this.child,
    this.fallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, _) {
        if (userProvider.isPremium) {
          return child;
        }
        return fallback ?? _buildDefaultFallback(context);
      },
    );
  }

  Widget _buildDefaultFallback(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.lock, size: 48),
            const SizedBox(height: 16),
            const Text(
              'Conteúdo Premium',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Este conteúdo está disponível apenas para usuários premium.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Implementar navegação para página de upgrade
              },
              child: const Text('Fazer Upgrade'),
            ),
          ],
        ),
      ),
    );
  }
} 