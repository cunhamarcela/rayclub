import 'package:flutter/material.dart';
import '../../core/theme/app_theme_export.dart';

class WorkoutCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  final String duration;
  final String level;
  final VoidCallback onTap;
  final bool isPremium;

  const WorkoutCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.duration,
    required this.level,
    required this.onTap,
    this.isPremium = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppDimensions.m),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimensions.radiusL),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppDimensions.radiusL),
          child: Stack(
            children: [
              // Imagem de fundo
              Image.network(
                imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 200,
                  width: double.infinity,
                  color: AppColors.primaryLight,
                  child: const Icon(
                    Icons.fitness_center,
                    color: AppColors.primary,
                    size: 48,
                  ),
                ),
              ),
              
              // Gradiente para melhorar a legibilidade do texto
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                      ],
                      stops: const [0.6, 1.0],
                    ),
                  ),
                ),
              ),
              
              // Informações do treino
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(AppDimensions.m),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Título e badge premium
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              title,
                              style: AppTypography.workoutTitle.copyWith(
                                color: Colors.white,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (isPremium)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppDimensions.s,
                                vertical: AppDimensions.xs,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.secondary,
                                borderRadius: BorderRadius.circular(
                                  AppDimensions.radiusCircular,
                                ),
                              ),
                              child: Text(
                                'PREMIUM',
                                style: AppTypography.labelSmall.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                      
                      const SizedBox(height: AppDimensions.xs),
                      
                      // Subtítulo
                      Text(
                        subtitle,
                        style: AppTypography.bodyMedium.copyWith(
                          color: Colors.white.withOpacity(0.9),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      
                      const SizedBox(height: AppDimensions.s),
                      
                      // Duração e nível
                      Row(
                        children: [
                          _buildInfoChip(Icons.timer, duration),
                          const SizedBox(width: AppDimensions.s),
                          _buildInfoChip(Icons.fitness_center, level),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.s,
        vertical: AppDimensions.xs,
      ),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(AppDimensions.radiusCircular),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: Colors.white,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: AppTypography.bodySmall.copyWith(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
} 