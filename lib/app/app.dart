import 'package:flutter/material.dart';

import '../core/theme/theme.dart';
import '../features/auth/presentation/pages/sign_in_page.dart';
import '../features/auth/presentation/pages/sign_up_page.dart';
import '../features/auth/presentation/pages/welcome_page.dart';
import '../features/home/presentation/pages/home_page.dart';
import 'auth_gate.dart';

class FastRecipeApp extends StatelessWidget {
  const FastRecipeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fast Recipe',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const AuthGate(),
      routes: {
        WelcomePage.routeName: (context) => const WelcomePage(),
        SignInPage.routeName: (context) => const SignInPage(),
        SignUpPage.routeName: (context) => const SignUpPage(),
        HomePage.routeName: (context) => const HomePage(),
      },
    );
  }
}

