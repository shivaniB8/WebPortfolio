import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../data/portfolio_data.dart';
import '../theme/colors.dart';
import '../widgets/glass_card.dart';
import '../widgets/section_header.dart';

class ExperienceSection extends StatefulWidget {
  const ExperienceSection({super.key});

  @override
  State<ExperienceSection> createState() => _ExperienceSectionState();
}

class _ExperienceSectionState extends State<ExperienceSection> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return VisibilityDetector(
      key: const Key('experience_section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1 && !_visible) {
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
              title: 'Experience',
              subtitle: 'A journey of growth, delivery, and leadership',
              visible: _visible,
            ),
            const SizedBox(height: 56),
            _TimelineList(
              experiences: PortfolioData.experience,
              visible: _visible,
              isMobile: isMobile,
            ),
          ],
        ),
      ),
    );
  }
}

class _TimelineList extends StatelessWidget {
  final List<ExperienceModel> experiences;
  final bool visible;
  final bool isMobile;

  const _TimelineList({
    required this.experiences,
    required this.visible,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 900),
      child: Column(
        children: experiences.asMap().entries.map((entry) {
          final idx = entry.key;
          final exp = entry.value;
          final isLast = idx == experiences.length - 1;
          final delay = idx * 150;

          return AnimatedOpacity(
            opacity: visible ? 1 : 0,
            duration: Duration(milliseconds: 700 + delay),
            child: AnimatedSlide(
              offset: visible ? Offset.zero : const Offset(-0.1, 0),
              duration: Duration(milliseconds: 700 + delay),
              curve: Curves.easeOutCubic,
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Timeline column
                    SizedBox(
                      width: 60,
                      child: Column(
                        children: [
                          // Node
                          Container(
                            width: 20,
                            height: 20,
                            margin: const EdgeInsets.only(top: 20),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: exp.accentColor,
                              boxShadow: [
                                BoxShadow(
                                  color: exp.accentColor.withOpacity(0.5),
                                  blurRadius: 12,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          // Line
                          if (!isLast)
                            Expanded(
                              child: Container(
                                width: 2,
                                margin: const EdgeInsets.symmetric(vertical: 4),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      exp.accentColor.withOpacity(0.6),
                                      exp.accentColor.withOpacity(0.1),
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),

                    // Card
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          bottom: isLast ? 0 : 24,
                          left: 8,
                        ),
                        child: GlassCard(
                          hoverGlow: true,
                          glowColor: exp.accentColor,
                          padding: const EdgeInsets.all(28),
                          child: _ExperienceCardContent(exp: exp),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _ExperienceCardContent extends StatelessWidget {
  final ExperienceModel exp;

  const _ExperienceCardContent({required this.exp});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header row
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 12,
          runSpacing: 8,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exp.company,
                  style: GoogleFonts.raleway(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.work_rounded,
                        size: 14, color: exp.accentColor),
                    const SizedBox(width: 6),
                    Text(
                      exp.role,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: exp.accentColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _MetaBadge(
                  icon: Icons.calendar_month_rounded,
                  label: exp.period,
                  color: exp.accentColor,
                ),
                const SizedBox(height: 6),
                _MetaBadge(
                  icon: Icons.location_on_rounded,
                  label: exp.location,
                  color: AppColors.textMuted,
                ),
              ],
            ),
          ],
        ),

        const SizedBox(height: 20),

        // Divider
        Container(
          height: 1,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [exp.accentColor.withOpacity(0.5), Colors.transparent],
            ),
          ),
        ),

        const SizedBox(height: 16),

        // Bullets
        ...exp.bullets.map(
          (bullet) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: exp.accentColor,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    bullet,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                      height: 1.6,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _MetaBadge extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _MetaBadge({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: color),
        const SizedBox(width: 5),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12.5,
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
