import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/firebase_config.dart';
import 'core/constants.dart';
import 'core/routes.dart';
import 'core/theme/app_theme_export.dart';
import 'providers/auth_provider.dart';
import 'providers/user_provider.dart';
import 'providers/activity_provider.dart';
import 'providers/ranking_provider.dart';
import 'providers/premium_content_provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    
    // Carrega variáveis de ambiente
    await dotenv.load(fileName: ".env");
    
    // Inicializa Firebase
    await FirebaseConfig.initializeFirebase();
    
    runApp(const MyApp());
  } catch (e) {
    print('Erro na inicialização do app: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => ActivityProvider()),
        ChangeNotifierProvider(create: (_) => RankingProvider()),
        ChangeNotifierProvider(create: (_) => PremiumContentProvider()),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: AppConstants.appName,
        theme: AppTheme.theme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        routes: AppRoutes.getRoutes(),
        initialRoute: AppConstants.loginRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
