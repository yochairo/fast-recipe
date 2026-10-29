import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme.dart';
import '../state/auth_providers.dart';
import '../widgets/chef_hat_logo.dart';
import '../widgets/google_icon.dart';
import 'sign_in_page.dart';
import 'sign_up_page.dart';

class WelcomePage extends ConsumerWidget {
  const WelcomePage({super.key});

  static const routeName = '/welcome';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.appColors;
    final authState = ref.watch(authNotifierProvider);

    ref.listen(authNotifierProvider, (previous, next) {
      next.whenOrNull(
        error: (error, _) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error.toString()),
              backgroundColor: colors.error,
            ),
          );
        },
      );
    });

    final isLoading = authState.isLoading;

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            children: [
              const Spacer(flex: 2),
              const ChefHatLogo(size: 110),
              const SizedBox(height: 28),
              Text(
                'Tu chef personal con IA.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: colors.text,
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Descubre recetas increíbles con lo que ya tienes en casa.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.4,
                    color: colors.secondary,
                  ),
                ),
              ),
              const Spacer(flex: 3),
              _AuthActionButtons(
                isLoading: isLoading,
                onGooglePressed: () {
                  ref.read(authNotifierProvider.notifier).signInWithGoogle();
                },
                onEmailRegisterPressed: () {
                  Navigator.pushNamed(context, SignUpPage.routeName);
                },
                onLoginPressed: () {
                  Navigator.pushNamed(context, SignInPage.routeName);
                },
              ),
              const SizedBox(height: 24),
              const _LegalFooter(),
            ],
          ),
        ),
      ),
    );
  }
}

class _AuthActionButtons extends StatelessWidget {
  const _AuthActionButtons({
    required this.isLoading,
    required this.onGooglePressed,
    required this.onEmailRegisterPressed,
    required this.onLoginPressed,
  });

  final bool isLoading;
  final VoidCallback onGooglePressed;
  final VoidCallback onEmailRegisterPressed;
  final VoidCallback onLoginPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Column(
      children: [
        // Continuar con Google
        SizedBox(
          width: double.infinity,
          height: 52,
          child: OutlinedButton(
            onPressed: isLoading ? null : onGooglePressed,
            style: OutlinedButton.styleFrom(
              backgroundColor: colors.surface,
              side: BorderSide(color: colors.border, width: 1.2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(26),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GoogleIcon(size: 20),
                SizedBox(width: 12),
                Text(
                  'Continuar con Google',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),

        // Registrarse con Email
        SizedBox(
          width: double.infinity,
          height: 52,
          child: OutlinedButton(
            onPressed: isLoading ? null : onEmailRegisterPressed,
            style: OutlinedButton.styleFrom(
              backgroundColor: colors.surface,
              side: BorderSide(color: colors.border, width: 1.2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(26),
              ),
            ),
            child: Text(
              'Registrarse con Email',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: colors.text,
              ),
            ),
          ),
        ),
        const SizedBox(height: 14),

        // Iniciar Sesión (Botón de acento)
        SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: isLoading ? null : onLoginPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.accent,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(26),
              ),
            ),
            child: isLoading
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.2,
                      color: Colors.white,
                    ),
                  )
                : const Text(
                    'Iniciar Sesión',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}

class _LegalFooter extends StatelessWidget {
  const _LegalFooter();

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Text.rich(
      TextSpan(
        text: 'Al continuar, aceptas los ',
        style: TextStyle(
          fontSize: 11,
          color: colors.secondary,
        ),
        children: const [
          TextSpan(
            text: 'Términos y Condiciones',
            style: TextStyle(
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextSpan(text: ' y la '),
          TextSpan(
            text: 'Política de Privacidad',
            style: TextStyle(
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextSpan(text: '.'),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}

