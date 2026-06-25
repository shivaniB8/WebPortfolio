import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../data/portfolio_data.dart';
import '../theme/colors.dart';
import '../widgets/glass_card.dart';
import '../widgets/section_header.dart';

class AboutSection extends StatefulWidget {
  const AboutSection({super.key});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 768;
    final isTablet = width < 1100;

    return VisibilityDetector(
      key: const Key('about_section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.15 && !_visible) {
          setState(() => _visible = true);
        }
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 24 : 80,
          vertical: 80,
        ),
        child: Column(
          children: [
            SectionHeader(
              title: 'About Me',
              subtitle: 'Building the future, one Flutter app at a time',
              visible: _visible,
            ),
            const SizedBox(height: 56),
            if (isMobile || isTablet)
              _MobileAbout(visible: _visible)
            else
              _DesktopAbout(visible: _visible),
          ],
        ),
      ),
    );
  }
}

class _DesktopAbout extends StatelessWidget {
  final bool visible;
  const _DesktopAbout({required this.visible});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: AnimatedOpacity(
            opacity: visible ? 1 : 0,
            duration: const Duration(milliseconds: 700),
            child: AnimatedSlide(
              offset: visible ? Offset.zero : const Offset(-0.1, 0),
              duration: const Duration(milliseconds: 700),
              curve: Curves.easeOutCubic,
              child: GlassCard(
                padding: const EdgeInsets.all(36),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _AboutHeading(),
                    const SizedBox(height: 20),
                    _SummaryText(),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 28),
        Expanded(
          flex: 3,
          child: AnimatedOpacity(
            opacity: visible ? 1 : 0,
            duration: const Duration(milliseconds: 700),
            child: AnimatedSlide(
              offset: visible ? Offset.zero : const Offset(0.1, 0),
              duration: const Duration(milliseconds: 700),
              curve: Curves.easeOutCubic,
              child: GlassCard(
                padding: const EdgeInsets.all(36),
                child: _AchievementsList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _MobileAbout extends StatelessWidget {
  final bool visible;
  const _MobileAbout({required this.visible});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: visible ? 1 : 0,
      duration: const Duration(milliseconds: 700),
      child: AnimatedSlide(
        offset: visible ? Offset.zero : const Offset(0, 0.1),
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeOutCubic,
        child: Column(
          children: [
            GlassCard(
              padding: const EdgeInsets.all(28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _AboutHeading(),
                  const SizedBox(height: 16),
                  _SummaryText(),
                ],
              ),
            ),
            const SizedBox(height: 20),
            GlassCard(
              padding: const EdgeInsets.all(28),
              child: _AchievementsList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _AboutHeading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradientDiag,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppColors.purple.withOpacity(0.4),
                blurRadius: 12,
                spreadRadius: 2,
              ),
            ],
          ),
          child: const Icon(Icons.person_rounded, color: Colors.white, size: 26),
        ),
        const SizedBox(width: 14),
        Text(
          'Who am I?',
          style: GoogleFonts.raleway(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

class _SummaryText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      PortfolioData.summary,
      style: GoogleFonts.poppins(
        fontSize: 15,
        color: AppColors.textSecondary,
        height: 1.75,
      ),
    );
  }
}

class _AchievementsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF06B6D4), Color(0xFF10B981)],
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.cyan.withOpacity(0.4),
                    blurRadius: 12,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: const Icon(Icons.emoji_events_rounded, color: Colors.white, size: 26),
            ),
            const SizedBox(width: 14),
            Text(
              'Key Achievements',
              style: GoogleFonts.raleway(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        ...PortfolioData.achievements.asMap().entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: AppColors.primaryGradientDiag,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.purple.withOpacity(0.5),
                        blurRadius: 6,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    entry.value,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
