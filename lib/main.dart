import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'portfolio_page.dart';
import 'theme/colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Global VisibilityDetector update interval for smooth scroll triggers
  VisibilityDetectorController.instance.updateInterval =
      const Duration(milliseconds: 100);

  runApp(const ShivaniBagalPortfolio());
}

class ShivaniBagalPortfolio extends StatelessWidget {
  const ShivaniBagalPortfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shivani Bagal | Flutter Developer',
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(),
      home: const PortfolioPage(),
    );
  }

  ThemeData _buildTheme() {
    final base = ThemeData.dark();
    return base.copyWith(
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.purple,
        secondary: AppColors.cyan,
        surface: AppColors.surfaceDark,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.textPrimary,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(base.textTheme).apply(
        bodyColor: AppColors.textPrimary,
        displayColor: AppColors.textPrimary,
      ),
      scrollbarTheme: ScrollbarThemeData(
        thumbColor: WidgetStateProperty.all(
          AppColors.purple.withOpacity(0.4),
        ),
        trackColor: WidgetStateProperty.all(Colors.transparent),
        radius: const Radius.circular(8),
      ),
    );
  }
}
