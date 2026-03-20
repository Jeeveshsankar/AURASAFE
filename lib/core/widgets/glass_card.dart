import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double blur;
  final double opacity;
  final BorderRadius? borderRadius;
  final Color? borderColor;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.blur = 20,
    this.opacity = 0.4,
    this.borderRadius,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final br = borderRadius ?? BorderRadius.circular(24);
    return ClipRRect(
      borderRadius: br,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          padding: padding ?? const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.cardBg.withOpacity(opacity),
            borderRadius: br,
            border: Border.all(
              color: borderColor ?? Colors.white.withOpacity(0.08),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 15,
                spreadRadius: -5,
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}
