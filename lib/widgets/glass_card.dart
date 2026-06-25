import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/colors.dart';

class GlassCard extends StatefulWidget {
  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final bool hoverGlow;
  final Color glowColor;
  final VoidCallback? onTap;

  const GlassCard({
    super.key,
    required this.child,
    this.borderRadius = 16,
    this.padding = const EdgeInsets.all(24),
    this.margin,
    this.width,
    this.height,
    this.hoverGlow = false,
    this.glowColor = AppColors.purple,
    this.onTap,
  });

  @override
  State<GlassCard> createState() => _GlassCardState();
}

class _GlassCardState extends State<GlassCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        if (widget.hoverGlow) setState(() => _hovered = true);
      },
      onExit: (_) {
        if (widget.hoverGlow) setState(() => _hovered = false);
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          width: widget.width,
          height: widget.height,
          margin: widget.margin,
          transform: widget.hoverGlow && _hovered
              ? (Matrix4.identity()..translate(0.0, -4.0))
              : Matrix4.identity(),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            boxShadow: [
              if (_hovered)
                BoxShadow(
                  color: widget.glowColor.withOpacity(0.3),
                  blurRadius: 40,
                  spreadRadius: 4,
                ),
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 20,
                spreadRadius: 0,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: widget.padding,
                decoration: BoxDecoration(
                  color: _hovered
                      ? AppColors.glassHover
                      : AppColors.glassWhite,
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  border: Border.all(
                    color: _hovered
                        ? widget.glowColor.withOpacity(0.4)
                        : AppColors.glassBorder,
                    width: 1,
                  ),
                ),
                child: widget.child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
