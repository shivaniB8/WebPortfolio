import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../theme/colors.dart';

class AnimatedCounter extends StatefulWidget {
  final String value;
  final String label;
  final IconData icon;
  final Duration duration;

  const AnimatedCounter({
    super.key,
    required this.value,
    required this.label,
    required this.icon,
    this.duration = const Duration(milliseconds: 1500),
  });

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _hasAnimated = false;

  // Parse numeric portion from strings like "4+", "50K+", "2.2M+", "5+"
  double _parseValue(String raw) {
    final cleaned = raw.replaceAll(RegExp(r'[^0-9.]'), '');
    return double.tryParse(cleaned) ?? 0;
  }

  String _buildDisplayValue(double progress) {
    final raw = widget.value;
    final suffix = raw.replaceAll(RegExp(r'[0-9.]'), '');
    final target = _parseValue(raw);
    final current = (target * progress);

    // Format nicely
    if (current >= 1000000) {
      return '${(current / 1000000).toStringAsFixed(1)}M$suffix';
    } else if (current >= 1000) {
      return '${(current / 1000).toStringAsFixed(0)}K$suffix';
    } else if (current == current.roundToDouble()) {
      return '${current.toInt()}$suffix';
    } else {
      return '${current.toStringAsFixed(1)}$suffix';
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
  }

  void _startAnimation() {
    if (!_hasAnimated) {
      _hasAnimated = true;
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('counter_${widget.label}'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.5) _startAnimation();
      },
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, _) {
          return Column(
            children: [
              // Glowing icon
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppColors.primaryGradientDiag,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.purple.withOpacity(0.4),
                      blurRadius: 16,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Icon(widget.icon, color: Colors.white, size: 24),
              ),
              const SizedBox(height: 12),
              ShaderMask(
                shaderCallback: (bounds) =>
                    AppColors.primaryGradient.createShader(bounds),
                child: Text(
                  _buildDisplayValue(_animation.value),
                  style: GoogleFonts.raleway(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                widget.label,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          );
        },
      ),
    );
  }
}
