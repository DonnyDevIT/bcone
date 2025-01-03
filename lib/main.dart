import 'package:bcone/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url:
        "http://supabasekong-ww000k08s84wkk4gwoksswkg.194.164.164.162.sslip.io",
    anonKey:
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJzdXBhYmFzZSIsImlhdCI6MTczNTg5ODU4MCwiZXhwIjo0ODkxNTcyMTgwLCJyb2xlIjoiYW5vbiJ9.3iVi0xme96u0J2rT1THkPheMnL7UZ-MF4yjbQwl64eg",
  );

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData.dark(),
      routerConfig: _appRouter.config(),
    );
  }
}
