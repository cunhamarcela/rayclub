import 'package:flutter/material.dart';
import '../../core/theme/app_theme_export.dart';

class FitnessMetricCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color? color;
  final VoidCallback? onTap;

  const FitnessMetricCard({
    Key? key,
    required this.title,
    required this.value,
    required this.icon,
    this.color,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cardColor = color ?? AppColors.primary;
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppDimensions.m),
        decoration: BoxDecoration(
          color: cardColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppDimensions.radiusL),
          border: Border.all(
            color: cardColor.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ícone
            Container(
              padding: const EdgeInsets.all(AppDimensions.s),
              decoration: BoxDecoration(
                color: cardColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(AppDimensions.radiusM),
              ),
              child: Icon(
                icon,
                color: cardColor,
                size: AppDimensions.iconM,
              ),
            ),
            
            const SizedBox(height: AppDimensions.m),
            
            // Valor
            Text(
              value,
              style: AppTypography.metricValue.copyWith(
                color: cardColor,
              ),
            ),
            
            const SizedBox(height: AppDimensions.xs),
            
            // Título
            Text(
              title,
              style: AppTypography.metricLabel,
            ),
          ],
        ),
      ),
    );
  }
}

class FitnessMetricsRow extends StatelessWidget {
  final List<FitnessMetricCard> metrics;

  const FitnessMetricsRow({
    Key? key,
    required this.metrics,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppDimensions.m),
      child: Row(
        children: List.generate(metrics.length, (index) {
          return Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: index == 0 ? 0 : AppDimensions.s,
                right: index == metrics.length - 1 ? 0 : AppDimensions.s,
              ),
              child: metrics[index],
            ),
          );
        }),
      ),
    );
  }
} 