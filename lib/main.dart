import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final rawUrl = const String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://placeholder.supabase.co',
  ).trim();

  // Asegura que la URL base de Supabase sea el host origen (sin sufijos como /rest/v1/)
  final parsedUri = Uri.tryParse(rawUrl);
  final supabaseUrl = parsedUri != null && parsedUri.hasScheme && parsedUri.host.isNotEmpty
      ? '${parsedUri.scheme}://${parsedUri.host}${parsedUri.hasPort ? ':${parsedUri.port}' : ''}'
      : rawUrl;
  const supabasePublishableKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: String.fromEnvironment(
      'SUPABASE_PUBLISHABLE_KEY',
      defaultValue: 'placeholder-anon-key',
    ),
  );

  await Supabase.initialize(
    url: supabaseUrl,
    publishableKey: supabasePublishableKey,
  );

  runApp(
    const ProviderScope(
      child: FastRecipeApp(),
    ),
  );
}
