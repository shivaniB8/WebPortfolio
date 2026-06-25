import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../data/portfolio_data.dart';
import '../theme/colors.dart';
import '../widgets/glass_card.dart';
import '../widgets/section_header.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  bool _visible = false;

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.platformDefault);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 768;

    return VisibilityDetector(
      key: const Key('contact_section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1 && !_visible) {
          setState(() => _visible = true);
        }
      },
      child: Container(
        width: double.infinity,
        color: AppColors.surfaceDark,
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 24 : 80,
          vertical: 80,
        ),
        child: Column(
          children: [
            SectionHeader(
              title: 'Get In Touch',
              subtitle:
                  'Open to exciting opportunities — let\'s build something great',
              visible: _visible,
            ),
            const SizedBox(height: 56),
            AnimatedOpacity(
              opacity: _visible ? 1 : 0,
              duration: const Duration(milliseconds: 700),
              child: AnimatedSlide(
                offset: _visible ? Offset.zero : const Offset(0, 0.15),
                duration: const Duration(milliseconds: 700),
                curve: Curves.easeOutCubic,
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 700),
                    child: GlassCard(
                      padding: EdgeInsets.all(isMobile ? 28 : 48),
                      child: Column(
                        children: [
                          // Glowing icon
                          Container(
                            width: 72,
                            height: 72,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: AppColors.primaryGradientDiag,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.purple.withOpacity(0.5),
                                  blurRadius: 24,
                                  spreadRadius: 4,
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.connect_without_contact_rounded,
                              color: Colors.white,
                              size: 36,
                            ),
                          ),

                          const SizedBox(height: 28),

                          Text(
                            'Let\'s Connect!',
                            style: GoogleFonts.raleway(
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textPrimary,
                            ),
                          ),

                          const SizedBox(height: 10),

                          Text(
                            'I\'m always open to discussing new projects, creative ideas, '
                            'or opportunities to be part of something amazing.',
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              color: AppColors.textSecondary,
                              height: 1.6,
                            ),
                            textAlign: TextAlign.center,
                          ),

                          const SizedBox(height: 40),

                          // Contact items
                          Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 16,
                            runSpacing: 16,
                            children: [
                              _ContactItem(
                                icon: Icons.email_rounded,
                                label: 'Email',
                                value: PortfolioData.email,
                                color: const Color(0xFFF59E0B),
                                onTap: () => _launch(
                                    'mailto:${PortfolioData.email}'),
                              ),
                              _ContactItem(
                                icon: Icons.phone_rounded,
                                label: 'Phone',
                                value: PortfolioData.phone,
                                color: const Color(0xFF10B981),
                                onTap: () =>
                                    _launch('tel:${PortfolioData.phone}'),
                              ),
                              _ContactItem(
                                icon: Icons.location_on_rounded,
                                label: 'Location',
                                value: PortfolioData.location,
                                color: AppColors.cyan,
                                onTap: null,
                              ),
                            ],
                          ),

                          const SizedBox(height: 40),

                          // Divider
                          Container(
                            height: 1,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  AppColors.glassBorder,
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 36),

                          Text(
                            'Find me on',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: AppColors.textMuted,
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          const SizedBox(height: 20),

                          // Social buttons
                          Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 14,
                            runSpacing: 14,
                            children: [
                              _SocialIconButton(
                                icon: Icons.code_rounded,
                                label: 'GitHub',
                                color: AppColors.purpleLight,
                                onTap: () => _launch(PortfolioData.github),
                              ),
                              _SocialIconButton(
                                icon: Icons.business_center_rounded,
                                label: 'LinkedIn',
                                color: AppColors.cyan,
                                onTap: () => _launch(PortfolioData.linkedin),
                              ),
                              _SocialIconButton(
                                icon: Icons.article_rounded,
                                label: 'Medium',
                                color: const Color(0xFF10B981),
                                onTap: () => _launch(PortfolioData.medium),
                              ),
                            ],
                          ),

                          const SizedBox(height: 36),

                          // CTA Button
                          _HireMeButton(
                            onTap: () => _launch(
                                'mailto:${PortfolioData.email}?subject=Opportunity%20for%20Shivani%20Bagal'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final VoidCallback? onTap;

  const _ContactItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    this.onTap,
  });

  @override
  State<_ContactItem> createState() => _ContactItemState();
}

class _ContactItemState extends State<_ContactItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.onTap != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      onEnter: (_) {
        if (widget.onTap != null) setState(() => _hovered = true);
      },
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            color: _hovered
                ? widget.color.withOpacity(0.15)
                : widget.color.withOpacity(0.07),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _hovered
                  ? widget.color.withOpacity(0.7)
                  : widget.color.withOpacity(0.3),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, size: 20, color: widget.color),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.label,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: AppColors.textMuted,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    widget.value,
                    style: GoogleFonts.poppins(
                      fontSize: 13.5,
                      color: _hovered ? Colors.white : AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialIconButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _SocialIconButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  State<_SocialIconButton> createState() => _SocialIconButtonState();
}

class _SocialIconButtonState extends State<_SocialIconButton> {
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
          decoration: BoxDecoration(
            color: _hovered
                ? widget.color.withOpacity(0.2)
                : widget.color.withOpacity(0.08),
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: _hovered
                  ? widget.color.withOpacity(0.9)
                  : widget.color.withOpacity(0.3),
            ),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: widget.color.withOpacity(0.35),
                      blurRadius: 16,
                      spreadRadius: 1,
                    )
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, size: 20, color: widget.color),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: GoogleFonts.poppins(
                  fontSize: 13.5,
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

class _HireMeButton extends StatefulWidget {
  final VoidCallback onTap;

  const _HireMeButton({required this.onTap});

  @override
  State<_HireMeButton> createState() => _HireMeButtonState();
}

class _HireMeButtonState extends State<_HireMeButton> {
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
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: AppColors.purple
                    .withOpacity(_hovered ? 0.6 : 0.3),
                blurRadius: _hovered ? 30 : 16,
                spreadRadius: _hovered ? 4 : 0,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.send_rounded, color: Colors.white, size: 20),
              const SizedBox(width: 10),
              Text(
                'Hire Me',
                style: GoogleFonts.raleway(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
