import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/theme/theme.dart';
import '../features/auth/presentation/pages/welcome_page.dart';
import '../features/auth/presentation/state/auth_providers.dart';
import '../features/home/presentation/pages/home_page.dart';

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStateAsync = ref.watch(authStateChangesProvider);

    return authStateAsync.when(
      data: (user) {
        if (user != null) {
          return const HomePage();
        }
        return const WelcomePage();
      },
      loading: () => Scaffold(
        backgroundColor: context.appColors.background,
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: (_, __) => const WelcomePage(),
    );
  }
}

