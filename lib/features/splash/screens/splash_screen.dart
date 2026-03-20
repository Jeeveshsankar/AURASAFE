import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../models/app_mode.dart';
import '../../main_navigator.dart';

class SplashScreen extends StatefulWidget {
  final bool immediatePortals;
  const SplashScreen({super.key, this.immediatePortals = false});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _orbController;
  bool _showPortals = false;

  @override
  void initState() {
    super.initState();
    _orbController =
        AnimationController(vsync: this, duration: const Duration(seconds: 4))
          ..repeat();
    _showPortals = widget.immediatePortals;
    if (!_showPortals) {
      Future.delayed(const Duration(milliseconds: 2500), () {
        if (mounted) setState(() => _showPortals = true);
      });
    }
  }

  @override
  void dispose() {
    _orbController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg0,
      body: Stack(
        children: [
          const BackgroundFluidBlobs(),
          Positioned.fill(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 1200),
                      curve: Curves.easeOutExpo,
                      margin: EdgeInsets.only(bottom: _showPortals ? 20 : 0),
                      transform: Matrix4.translationValues(
                          0, _showPortals ? -40 : 0, 0),
                      child: const BrandLogoReveal(),
                    ),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 1500),
                      switchInCurve: Curves.easeOutQuart,
                      switchOutCurve: Curves.easeInQuart,
                      child: _showPortals
                          ? _buildModernPortalGrid(context)
                          : const CentralProgressIndicator(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernPortalGrid(BuildContext context) {
    return Column(
      key: const ValueKey("portal_grid"),
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildDividerWithLabel("SELECT ENVIRONMENT"),
        const SizedBox(height: 24),
        _buildStaggeredPortal(
            context,
            0,
            "FOR INDIVIDUALS",
            "HOME ECOSYSTEM",
            "AI health metrics and optimization.",
            Icons.home_outlined,
            AppColors.primary,
            AppMode.home),
        _buildStaggeredPortal(
            context,
            1,
            "FOR HOSPITALS",
            "CLINICAL PORTAL",
            "Enterprise ward management.",
            Icons.local_hospital_outlined,
            AppColors.secondary,
            AppMode.hospital),
        _buildStaggeredPortal(
            context,
            2,
            "FOR PUBLIC HEALTH",
            "REGIONAL GOV",
            "Population risk trends.",
            Icons.account_balance_outlined,
            AppColors.warning,
            AppMode.government),
      ],
    );
  }

  Widget _buildDividerWithLabel(String label) {
    return Row(
      children: [
        Expanded(
            child: Container(height: 1, color: Colors.white.withOpacity(0.05))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(label,
              style: const TextStyle(
                  fontSize: 10,
                  letterSpacing: 3,
                  color: AppColors.text3,
                  fontWeight: FontWeight.bold)),
        ),
        Expanded(
            child: Container(height: 1, color: Colors.white.withOpacity(0.05))),
      ],
    );
  }

  Widget _buildStaggeredPortal(BuildContext context, int index, String tag,
      String title, String desc, IconData icon, Color color, AppMode mode) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 800 + (index * 200)),
      curve: Curves.easeOutQuart,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 30 * (1 - value)),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildPremiumPortal(
                  context, tag, title, desc, icon, color, mode),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPremiumPortal(BuildContext context, String tag, String title,
      String desc, IconData icon, Color color, AppMode mode) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        appModeNotifier.value = mode;
        Navigator.of(context).pushReplacement(PageRouteBuilder(
          pageBuilder: (_, __, ___) => const MainNavigator(),
          transitionDuration: const Duration(milliseconds: 800),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(
                opacity: animation,
                child: ScaleTransition(
                    scale: Tween<double>(begin: 1.1, end: 1.0).animate(
                        CurvedAnimation(
                            parent: animation, curve: Curves.easeOutQuart)),
                    child: child));
          },
        ));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: color.withOpacity(0.1))),
        child: GlassCard(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          opacity: 0.05,
          blur: 40,
          borderRadius: BorderRadius.circular(22),
          child: Row(
            children: [
              Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: color.withOpacity(0.1), shape: BoxShape.circle),
                  child: Icon(icon, color: color, size: 24)),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(tag,
                        style: TextStyle(
                            color: color,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5)),
                    const SizedBox(height: 2),
                    Text(title,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    const SizedBox(height: 2),
                    Text(desc,
                        style: const TextStyle(
                            fontSize: 11, color: AppColors.text3, height: 1.2)),
                  ],
                ),
              ),
              Icon(Icons.chevron_right,
                  color: Colors.white.withOpacity(0.2), size: 18),
            ],
          ),
        ),
      ),
    );
  }
}

class BrandLogoReveal extends StatefulWidget {
  const BrandLogoReveal({super.key});

  @override
  State<BrandLogoReveal> createState() => _BrandLogoRevealState();
}

class _BrandLogoRevealState extends State<BrandLogoReveal>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _drawProgress;
  late Animation<double> _scale;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2500));
    _drawProgress = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.7, curve: Curves.easeInOutQuart)));
    _scale = Tween<double>(begin: 1.2, end: 1.0).animate(CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0, curve: Curves.easeOutExpo)));
    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 1.0, curve: Curves.easeIn)));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final flicker = 0.95 + (0.05 * sin(_controller.value * 50));
        return Column(
          children: [
            Transform.scale(
              scale: _scale.value + (0.02 * sin(_controller.value * pi)),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                      width: 150,
                      height: 150,
                      decoration:
                          BoxDecoration(shape: BoxShape.circle, boxShadow: [
                        BoxShadow(
                            color: AppColors.primary
                                .withOpacity(0.3 * _opacity.value * flicker),
                            blurRadius: 120 * flicker,
                            spreadRadius: 10)
                      ])),
                  SizedBox(
                      width: 120,
                      height: 160,
                      child: CustomPaint(
                          painter: NetflixAPainter(
                              progress: _drawProgress.value,
                              color: AppColors.primary))),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Opacity(
              opacity: _opacity.value,
              child: Column(
                children: [
                  ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                              colors: [Colors.white, Colors.white70])
                          .createShader(bounds),
                      child: Text("AURASAFE",
                          style: GoogleFonts.outfit(
                              fontSize: 32,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 12,
                              color: Colors.white))),
                  const SizedBox(height: 12),
                  Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.white.withOpacity(0.1)),
                          borderRadius: BorderRadius.circular(4)),
                      child: Text("INTELLIGENT HEALTH SYSTEMS",
                          style: GoogleFonts.outfit(
                              fontSize: 9,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 4,
                              color: AppColors.text3))),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class NetflixAPainter extends CustomPainter {
  final double progress;
  final Color color;
  NetflixAPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 18
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final path = Path();
    path.moveTo(size.width * 0.1, size.height * 0.95);
    path.lineTo(size.width * 0.5, size.height * 0.1);
    path.lineTo(size.width * 0.9, size.height * 0.95);
    path.moveTo(size.width * 0.3, size.height * 0.65);
    path.lineTo(size.width * 0.7, size.height * 0.65);
    final p1 = _extractPathUntil(path, progress);
    canvas.drawPath(
        p1,
        Paint()
          ..color = color.withOpacity(0.3)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 24
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15));
    canvas.drawPath(p1, paint..color = Colors.white);
    canvas.drawPath(
        p1,
        paint
          ..color = color
          ..strokeWidth = 8);
  }

  Path _extractPathUntil(Path path, double factor) {
    final metrics = path.computeMetrics();
    final newPath = Path();
    for (var m in metrics) {
      newPath.addPath(m.extractPath(0, m.length * factor), Offset.zero);
    }
    return newPath;
  }

  @override
  bool shouldRepaint(covariant NetflixAPainter oldDelegate) =>
      oldDelegate.progress != progress;
}

class BackgroundFluidBlobs extends StatefulWidget {
  const BackgroundFluidBlobs({super.key});

  @override
  State<BackgroundFluidBlobs> createState() => _BackgroundFluidBlobsState();
}

class _BackgroundFluidBlobsState extends State<BackgroundFluidBlobs>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 20))
          ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          children: [
            Positioned(
                top: -150 + (30 * sin(_controller.value * 2 * pi)),
                right: -100 + (20 * cos(_controller.value * 2 * pi)),
                child: _GlowBlob(
                    color: AppColors.primary.withOpacity(0.12), size: 450)),
            Positioned(
                bottom: -200 + (40 * cos(_controller.value * 2 * pi)),
                left: -100 + (20 * sin(_controller.value * 2 * pi)),
                child: _GlowBlob(
                    color: AppColors.secondary.withOpacity(0.12), size: 550)),
            Positioned(
                top: 300 + (25 * sin(_controller.value * 4 * pi)),
                left: -100 + (15 * cos(_controller.value * 2 * pi)),
                child: _GlowBlob(
                    color: AppColors.warning.withOpacity(0.04), size: 350)),
          ],
        );
      },
    );
  }
}

class _GlowBlob extends StatelessWidget {
  final Color color;
  final double size;
  const _GlowBlob({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 120, sigmaY: 120),
            child: const SizedBox()));
  }
}

class CentralProgressIndicator extends StatefulWidget {
  const CentralProgressIndicator({super.key});

  @override
  State<CentralProgressIndicator> createState() =>
      _CentralProgressIndicatorState();
}

class _CentralProgressIndicatorState extends State<CentralProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500))
      ..repeat(reverse: true);
    _pulse = Tween<double>(begin: 0.3, end: 1.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _pulse,
      builder: (context, child) {
        return Column(
          children: [
            Container(
                width: 180,
                height: 1,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: AppColors.primary.withOpacity(0.5 * _pulse.value),
                      blurRadius: 10,
                      spreadRadius: 1)
                ]),
                child: LinearProgressIndicator(
                    backgroundColor: Colors.white.withOpacity(0.05),
                    color: AppColors.primary,
                    minHeight: 1)),
            const SizedBox(height: 16),
            Opacity(
                opacity: _pulse.value,
                child: const Text("CONNECTING TO SECURE NODES",
                    style: TextStyle(
                        fontSize: 9,
                        letterSpacing: 4,
                        color: AppColors.text3,
                        fontWeight: FontWeight.bold))),
          ],
        );
      },
    );
  }
}
