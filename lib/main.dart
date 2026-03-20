import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/theme/app_colors.dart';
import 'features/splash/screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppColors.bg0,
    ),
  );
  runApp(const AuraSafeApp());
}

class AuraSafeApp extends StatelessWidget {
  const AuraSafeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AuraSafe AI',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: AppColors.bg0,
        primaryColor: AppColors.primary,
        textTheme: GoogleFonts.outfitTextTheme().apply(
          bodyColor: AppColors.text1,
          displayColor: AppColors.text1,
        ),
        colorScheme: const ColorScheme.dark(
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          surface: AppColors.bg1,
          error: AppColors.danger,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
