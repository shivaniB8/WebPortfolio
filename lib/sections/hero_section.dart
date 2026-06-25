import 'dart:math' as math;
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/portfolio_data.dart';
import '../theme/colors.dart';
import '../widgets/animated_counter.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late final AnimationController _bgController;

  @override
  void initState() {
    super.initState();
    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _bgController.dispose();
    super.dispose();
  }

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.platformDefault);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: size.height),
      child: Stack(
        // Stack uses first non-Positioned child to determine its size;
        // setting fit to passthrough lets the ConstrainedBox drive the height.
        children: [
          // Fills the full ConstrainedBox height with the animated background
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _bgController,
              builder: (context, _) {
                return CustomPaint(
                  painter: _HeroBgPainter(_bgController.value),
                );
              },
            ),
          ),

          // Sized content (drives height through ConstrainedBox min)
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 24 : 80,
                vertical: isMobile ? 80 : 100,
              ),
              child: isMobile
                  ? _MobileHeroLayout(launch: _launch)
                  : _DesktopHeroLayout(launch: _launch),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Desktop Layout ───────────────────────────────────────────────────────────

class _DesktopHeroLayout extends StatelessWidget {
  final Future<void> Function(String) launch;

  const _DesktopHeroLayout({required this.launch});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: _HeroText(launch: launch),
        ),
        const SizedBox(width: 60),
        Expanded(
          flex: 2,
          child: Center(child: _ProfilePhoto()),
        ),
      ],
    );
  }
}

// ── Mobile Layout ─────────────────────────────────────────────────────────────

class _MobileHeroLayout extends StatelessWidget {
  final Future<void> Function(String) launch;

  const _MobileHeroLayout({required this.launch});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _ProfilePhoto(),
        const SizedBox(height: 36),
        _HeroText(launch: launch, centered: true),
      ],
    );
  }
}

// ── Profile Photo ─────────────────────────────────────────────────────────────

class _ProfilePhoto extends StatefulWidget {
  @override
  State<_ProfilePhoto> createState() => _ProfilePhotoState();
}

class _ProfilePhotoState extends State<_ProfilePhoto>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) => Stack(
        alignment: Alignment.center,
        children: [
          // Outer glow ring
          Container(
            width: 240,
            height: 240,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: SweepGradient(
                colors: [
                  AppColors.purple,
                  AppColors.cyan,
                  AppColors.purple,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.purple.withOpacity(0.4 * _pulseAnimation.value),
                  blurRadius: 40,
                  spreadRadius: 8,
                ),
                BoxShadow(
                  color: AppColors.cyan.withOpacity(0.3 * _pulseAnimation.value),
                  blurRadius: 60,
                  spreadRadius: 4,
                ),
              ],
            ),
          ),
          // White ring
          Container(
            width: 228,
            height: 228,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.background,
            ),
          ),
          // Photo
          ClipOval(
            child: Image.asset(
              'assets/shivani.jpeg',
              width: 220,
              height: 220,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppColors.primaryGradientDiag,
                ),
                child: const Icon(Icons.person_rounded, size: 80, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 800.ms).scale(begin: const Offset(0.8, 0.8));
  }
}

// ── Hero Text ─────────────────────────────────────────────────────────────────

class _HeroText extends StatelessWidget {
  final Future<void> Function(String) launch;
  final bool centered;

  const _HeroText({required this.launch, this.centered = false});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Column(
      crossAxisAlignment:
          centered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // Greeting
        Text(
          'Hello, I\'m',
          style: GoogleFonts.poppins(
            fontSize: 18,
            color: AppColors.cyan,
            fontWeight: FontWeight.w500,
          ),
        ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.3),

        const SizedBox(height: 8),

        // Name
        ShaderMask(
          shaderCallback: (bounds) =>
              AppColors.primaryGradient.createShader(bounds),
          child: Text(
            PortfolioData.name,
            style: GoogleFonts.raleway(
              fontSize: isMobile ? 36 : 52,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              height: 1.1,
            ),
          ),
        ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.3),

        const SizedBox(height: 16),

        // Typewriter
        SizedBox(
          height: 40,
          child: DefaultTextStyle(
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 18 : 22,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
            child: AnimatedTextKit(
              animatedTexts: PortfolioData.typewriterTexts
                  .map(
                    (t) => TypewriterAnimatedText(
                      t,
                      speed: const Duration(milliseconds: 80),
                    ),
                  )
                  .toList(),
              repeatForever: true,
              pause: const Duration(milliseconds: 1500),
            ),
          ),
        ).animate().fadeIn(delay: 400.ms),

        const SizedBox(height: 24),

        // Short summary
        Text(
          'Flutter Developer with 4+ years building secure, scalable '
          'mobile apps for government and enterprise clients.',
          style: GoogleFonts.poppins(
            fontSize: 15,
            color: AppColors.textSecondary,
            height: 1.6,
          ),
          textAlign: centered ? TextAlign.center : TextAlign.start,
        ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.2),

        const SizedBox(height: 36),

        // Social buttons
        Wrap(
          alignment: centered ? WrapAlignment.center : WrapAlignment.start,
          spacing: 12,
          runSpacing: 12,
          children: [
            _SocialButton(
              icon: Icons.code_rounded,
              label: 'GitHub',
              color: AppColors.purpleLight,
              onTap: () => launch(PortfolioData.github),
            ),
            _SocialButton(
              icon: Icons.business_center_rounded,
              label: 'LinkedIn',
              color: AppColors.cyan,
              onTap: () => launch(PortfolioData.linkedin),
            ),
            _SocialButton(
              icon: Icons.article_rounded,
              label: 'Medium',
              color: const Color(0xFF10B981),
              onTap: () => launch(PortfolioData.medium),
            ),
            _SocialButton(
              icon: Icons.email_rounded,
              label: 'Email',
              color: const Color(0xFFF59E0B),
              onTap: () => launch('mailto:${PortfolioData.email}'),
            ),
          ],
        ).animate().fadeIn(delay: 600.ms),

        const SizedBox(height: 64),

        // Stats row
        Wrap(
          alignment: centered ? WrapAlignment.center : WrapAlignment.start,
          spacing: 32,
          runSpacing: 32,
          children: PortfolioData.stats
              .map(
                (s) => SizedBox(
                  width: 120,
                  child: AnimatedCounter(
                    value: s.value,
                    label: s.label,
                    icon: s.icon,
                  ),
                ),
              )
              .toList(),
        ).animate().fadeIn(delay: 700.ms),
      ],
    );
  }
}

class _SocialButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _SocialButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          decoration: BoxDecoration(
            color: _hovered
                ? widget.color.withOpacity(0.2)
                : widget.color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: _hovered
                  ? widget.color.withOpacity(0.9)
                  : widget.color.withOpacity(0.4),
            ),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: widget.color.withOpacity(0.4),
                      blurRadius: 16,
                      spreadRadius: 1,
                    )
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, size: 18, color: widget.color),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: _hovered ? Colors.white : widget.color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Background Painter ────────────────────────────────────────────────────────

class _HeroBgPainter extends CustomPainter {
  final double t;
  _HeroBgPainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Base gradient
    final bgPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF0D0420), Color(0xFF080B1A), Color(0xFF001020)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    // Floating circles
    final circles = [
      _CircleDef(0.15, 0.25, 180, AppColors.purple, 0.0),
      _CircleDef(0.8, 0.1, 140, AppColors.cyan, 0.3),
      _CircleDef(0.5, 0.7, 200, AppColors.purple, 0.6),
      _CircleDef(0.9, 0.8, 120, AppColors.cyan, 0.9),
      _CircleDef(0.05, 0.85, 100, AppColors.purpleLight, 0.45),
    ];

    for (final c in circles) {
      final phase = (t + c.phase) % 1.0;
      final dx = math.sin(phase * 2 * math.pi) * 30;
      final dy = math.cos(phase * 2 * math.pi) * 20;

      paint.shader = RadialGradient(
        colors: [
          c.color.withOpacity(0.18),
          c.color.withOpacity(0.0),
        ],
      ).createShader(Rect.fromCircle(
        center: Offset(
          size.width * c.xFrac + dx,
          size.height * c.yFrac + dy,
        ),
        radius: c.radius,
      ));

      canvas.drawCircle(
        Offset(size.width * c.xFrac + dx, size.height * c.yFrac + dy),
        c.radius,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_HeroBgPainter old) => old.t != t;
}

class _CircleDef {
  final double xFrac, yFrac, radius;
  final Color color;
  final double phase;
  const _CircleDef(this.xFrac, this.yFrac, this.radius, this.color, this.phase);
}
