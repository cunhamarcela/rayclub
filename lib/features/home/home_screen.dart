import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/user_provider.dart';
import '../../core/widgets/premium_content.dart';
import '../../core/constants.dart';
import '../../core/theme/app_theme_export.dart';
import '../../presentation/widgets/workout_card.dart';
import '../../presentation/widgets/fitness_metric_card.dart';
import '../../presentation/widgets/custom_bottom_navigation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final isPremium = userProvider.user?.isPremium ?? false;
    
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // App Bar
            SliverAppBar(
              floating: true,
              title: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppDimensions.xs),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(AppDimensions.radiusXs),
                    ),
                    child: const Icon(
                      Icons.fitness_center,
                      color: Colors.white,
                      size: AppDimensions.iconS,
                    ),
                  ),
                  const SizedBox(width: AppDimensions.xs),
                  Text(
                    'RayClub',
                    style: AppTypography.h4.copyWith(
                      color: AppColors.textOnPrimary,
                    ),
                  ),
                ],
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.notifications_outlined),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () => authProvider.signOut(),
                ),
              ],
            ),
            
            // Conteúdo
            SliverPadding(
              padding: const EdgeInsets.all(AppDimensions.m),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // Saudação
                  Text(
                    'Olá, ${authProvider.user?.displayName?.split(' ')[0] ?? 'Usuário'}!',
                    style: AppTypography.h3,
                  ),
                  const SizedBox(height: AppDimensions.xs),
                  Text(
                    'Vamos treinar hoje?',
                    style: AppTypography.bodyLargeSecondary,
                  ),
                  const SizedBox(height: AppDimensions.l),
                  
                  // Métricas
                  FitnessMetricsRow(
                    metrics: [
                      FitnessMetricCard(
                        title: 'Calorias',
                        value: '320',
                        icon: Icons.local_fire_department,
                        color: AppColors.energy,
                        onTap: () {},
                      ),
                      FitnessMetricCard(
                        title: 'Minutos',
                        value: '45',
                        icon: Icons.timer,
                        color: AppColors.primary,
                        onTap: () {},
                      ),
                      FitnessMetricCard(
                        title: 'Treinos',
                        value: '3',
                        icon: Icons.fitness_center,
                        color: AppColors.secondary,
                        onTap: () {},
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: AppDimensions.l),
                  
                  // Treino do dia
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Treino do Dia',
                        style: AppTypography.h4,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Ver todos'),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDimensions.s),
                  
                  WorkoutCard(
                    title: 'Treino Completo de Corpo',
                    subtitle: 'Queime calorias e tonifique seu corpo',
                    imageUrl: 'https://images.unsplash.com/photo-1517836357463-d25dfeac3438?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
                    duration: '30 min',
                    level: 'Intermediário',
                    isPremium: false,
                    onTap: () {},
                  ),
                  
                  const SizedBox(height: AppDimensions.l),
                  
                  // Treinos Premium
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Treinos Premium',
                        style: AppTypography.h4,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Ver todos'),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDimensions.s),
                  
                  PremiumContent(
                    child: Column(
                      children: [
                        WorkoutCard(
                          title: 'Yoga para Flexibilidade',
                          subtitle: 'Melhore sua flexibilidade e equilíbrio',
                          imageUrl: 'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
                          duration: '45 min',
                          level: 'Todos os níveis',
                          isPremium: true,
                          onTap: () {},
                        ),
                        
                        WorkoutCard(
                          title: 'HIIT Avançado',
                          subtitle: 'Treinamento intenso para queimar gordura',
                          imageUrl: 'https://images.unsplash.com/photo-1434682881908-b43d0467b798?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
                          duration: '25 min',
                          level: 'Avançado',
                          isPremium: true,
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  
                  if (!isPremium)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: AppDimensions.l),
                      child: Container(
                        padding: const EdgeInsets.all(AppDimensions.m),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [AppColors.primary, AppColors.primaryDark],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(AppDimensions.radiusL),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: AppColors.secondary,
                                  size: 24,
                                ),
                                const SizedBox(width: AppDimensions.xs),
                                Text(
                                  'Seja Premium',
                                  style: AppTypography.h4.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: AppDimensions.s),
                            Text(
                              'Acesse todos os treinos e recursos exclusivos',
                              style: AppTypography.bodyMedium.copyWith(
                                color: Colors.white.withOpacity(0.9),
                              ),
                            ),
                            const SizedBox(height: AppDimensions.m),
                            ElevatedButton(
                              onPressed: () {
                                // Implementar navegação para página de upgrade
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.secondary,
                                foregroundColor: Colors.white,
                              ),
                              child: const Text('Fazer Upgrade Agora'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  
                  // Demonstração do Tema (apenas para desenvolvimento)
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(AppDimensions.m),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Demonstração do Tema',
                            style: AppTypography.h5,
                          ),
                          const SizedBox(height: AppDimensions.s),
                          Text(
                            'Acesse a tela de demonstração para visualizar todos os componentes do tema do aplicativo.',
                            style: AppTypography.bodyMedium,
                          ),
                          const SizedBox(height: AppDimensions.m),
                          Center(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Navigator.pushNamed(context, AppConstants.themeShowcaseRoute);
                              },
                              icon: const Icon(Icons.palette),
                              label: const Text('Ver Demonstração do Tema'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  // Espaço para a barra de navegação
                  const SizedBox(height: 80),
                ]),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigation(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
} 