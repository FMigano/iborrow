import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/app_export.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Uses --dart-define if passed; otherwise falls back to your project values
  const supabaseUrl = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://xumzpeenrfgyznlmzuva.supabase.co',
  );
  const supabaseAnonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh1bXpwZWVucmZneXpubG16dXZhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTUxNzg2MjMsImV4cCI6MjA3MDc1NDYyM30.gEoJ-H0CKEiAyQ2g_VgS4MR9kq7Me4pMtvF44zfBj2c',
  );

  assert(() {
    debugPrint('[Supabase] URL: $supabaseUrl');
    debugPrint('[Supabase] Anon key set: ${supabaseAnonKey.isNotEmpty}');
    return true;
  }());

  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
  );

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(IBorrowApp());
}

class IBorrowApp extends StatelessWidget {
  const IBorrowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: 'iBorrow',
          theme: theme,
          navigatorKey: NavigatorService.navigatorKey,
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.initialRoute,
          routes: AppRoutes.routes,
          // Ensure consistent text scaling
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(
                context,
              ).copyWith(textScaler: TextScaler.linear(1.0)),
              child: child!,
            );
          },
        );
      },
    );
  }
}
