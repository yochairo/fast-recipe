import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme.dart';
import '../../../auth/presentation/state/auth_providers.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  static const routeName = '/home';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.appColors;
    final currentUserAsync = ref.watch(authNotifierProvider);

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: const Text('Fast Recipe'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Cerrar sesión',
            onPressed: () {
              ref.read(authNotifierProvider.notifier).signOut();
            },
          ),
        ],
      ),
      body: Center(
        child: currentUserAsync.when(
          loading: () => const CircularProgressIndicator(),
          error: (error, _) => Text(
            'Error: $error',
            style: TextStyle(color: colors.error),
          ),
          data: (user) {
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.restaurant_menu,
                    size: 64,
                    color: colors.primary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '¡Bienvenido a Fast Recipe!',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: colors.text,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (user?.email != null)
                    Text(
                      user!.email!,
                      style: TextStyle(
                        fontSize: 16,
                        color: colors.secondary,
                      ),
                    ),
                  const SizedBox(height: 4),
                  Text(
                    'Rol ID: ${user?.roleId ?? 1} (Gratis)',
                    style: TextStyle(
                      fontSize: 14,
                      color: colors.secondary,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'El módulo principal de recetas se configurará aquí próximamente.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: colors.text),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

