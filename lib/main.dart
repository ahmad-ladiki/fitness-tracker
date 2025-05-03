import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'viewmodels/auth_viewmodel.dart';
import 'viewmodels/workout_viewmodel.dart';
import 'views/login_view.dart';
import 'views/signup_view.dart';
import 'views/home_view.dart';
import 'utils/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    final prefs = await SharedPreferences.getInstance();
    runApp(MyApp(prefs: prefs));
  } catch (e) {
    debugPrint('Error initializing SharedPreferences: $e');
    // Fallback to in-memory storage if SharedPreferences fails
    runApp(const MyApp(prefs: null));
  }
}

class MyApp extends StatelessWidget {
  final SharedPreferences? prefs;

  const MyApp({super.key, this.prefs});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthViewModel(prefs),
        ),
        ChangeNotifierProvider(
          create: (_) => WorkoutViewModel(prefs),
        ),
      ],
      child: MaterialApp(
        title: 'Fitness Tracker',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system, // or ThemeMode.light/dark
        initialRoute: '/',
        routes: {
          '/': (context) => Consumer<AuthViewModel>(
            builder: (context, authViewModel, _) {
              return authViewModel.isLoggedIn ? const HomeView() : const LoginView();
            },
          ),
          '/signup': (context) => const SignupView(),
          '/home': (context) => const HomeView(),
        },
      ),
    );
  }
}
