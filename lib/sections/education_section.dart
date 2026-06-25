import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../data/portfolio_data.dart';
import '../theme/colors.dart';
import '../widgets/glass_card.dart';
import '../widgets/section_header.dart';

class EducationSection extends StatefulWidget {
  const EducationSection({super.key});

  @override
  State<EducationSection> createState() => _EducationSectionState();
}

class _EducationSectionState extends State<EducationSection> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 768;

    return VisibilityDetector(
      key: const Key('education_section'),
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
              title: 'Education',
              subtitle: 'Academic foundation and continuous learning',
              visible: _visible,
            ),
            const SizedBox(height: 56),

            // Education timeline
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Column(
                children: PortfolioData.education.asMap().entries.map((entry) {
                  final idx = entry.key;
                  final edu = entry.value;
                  final isLast = idx == PortfolioData.education.length - 1;
                  final delay = idx * 150;

                  return AnimatedOpacity(
                    opacity: _visible ? 1 : 0,
                    duration: Duration(milliseconds: 700 + delay),
                    child: AnimatedSlide(
                      offset:
                          _visible ? Offset.zero : const Offset(-0.1, 0),
                      duration: Duration(milliseconds: 700 + delay),
                      curve: Curves.easeOutCubic,
                      child: IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Timeline
                            SizedBox(
                              width: 60,
                              child: Column(
                                children: [
                                  Container(
                                    width: 48,
                                    height: 48,
                                    margin: const EdgeInsets.only(top: 12),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: edu.color.withOpacity(0.15),
                                      border: Border.all(
                                          color: edu.color, width: 2),
                                      boxShadow: [
                                        BoxShadow(
                                          color: edu.color.withOpacity(0.4),
                                          blurRadius: 12,
                                          spreadRadius: 2,
                                        ),
                                      ],
                                    ),
                                    child: Icon(edu.icon,
                                        color: edu.color, size: 22),
                                  ),
                                  if (!isLast)
                                    Expanded(
                                      child: Container(
                                        width: 2,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 4),
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              edu.color.withOpacity(0.5),
                                              edu.color.withOpacity(0.1),
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
                                  glowColor: edu.color,
                                  padding: const EdgeInsets.all(24),
                                  child: _EduCardContent(edu: edu),
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
            ),

            const SizedBox(height: 64),

            // Certifications heading
            SectionHeader(
              title: 'Certifications',
              visible: _visible,
            ),

            const SizedBox(height: 40),

            _CertificationsGrid(
              certs: PortfolioData.certifications,
              visible: _visible,
              isMobile: isMobile,
            ),
          ],
        ),
      ),
    );
  }
}

class _EduCardContent extends StatelessWidget {
  final EducationModel edu;

  const _EduCardContent({required this.edu});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          edu.institution,
          style: GoogleFonts.raleway(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          edu.degree,
          style: GoogleFonts.poppins(
            fontSize: 14.5,
            fontWeight: FontWeight.w600,
            color: edu.color,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            _InfoBadge(
              icon: Icons.calendar_today_rounded,
              label: edu.period,
              color: AppColors.textMuted,
            ),
            const SizedBox(width: 16),
            _InfoBadge(
              icon: Icons.grade_rounded,
              label: edu.score,
              color: edu.color,
            ),
          ],
        ),
      ],
    );
  }
}

class _InfoBadge extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _InfoBadge({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 5),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 13,
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _CertificationsGrid extends StatelessWidget {
  final List<CertificationModel> certs;
  final bool visible;
  final bool isMobile;

  const _CertificationsGrid({
    required this.certs,
    required this.visible,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final crossCount = width > 900 ? 3 : (width > 600 ? 2 : 1);

    final rows = <List<CertificationModel>>[];
    for (int i = 0; i < certs.length; i += crossCount) {
      rows.add(certs.sublist(
        i,
        (i + crossCount).clamp(0, certs.length),
      ));
    }

    return Column(
      children: rows.asMap().entries.map((rowEntry) {
        final rowIdx = rowEntry.key;
        final rowCerts = rowEntry.value;

        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(
            children: rowCerts.asMap().entries.map((entry) {
              final colIdx = entry.key;
              final cert = entry.value;
              final delay = (rowIdx * crossCount + colIdx) * 100;

              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: colIdx > 0 ? 8 : 0,
                    right: colIdx < rowCerts.length - 1 ? 8 : 0,
                  ),
                  child: AnimatedOpacity(
                    opacity: visible ? 1 : 0,
                    duration: Duration(milliseconds: 600 + delay),
                    child: AnimatedSlide(
                      offset:
                          visible ? Offset.zero : const Offset(0, 0.2),
                      duration: Duration(milliseconds: 600 + delay),
                      curve: Curves.easeOutCubic,
                      child: GlassCard(
                        hoverGlow: true,
                        glowColor: cert.color,
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: cert.color.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: cert.color.withOpacity(0.4),
                                ),
                              ),
                              child: Icon(cert.icon,
                                  color: cert.color, size: 22),
                            ),
                            const SizedBox(height: 14),
                            Text(
                              cert.title,
                              style: GoogleFonts.raleway(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Icon(Icons.business_rounded,
                                    size: 13, color: cert.color),
                                const SizedBox(width: 5),
                                Text(
                                  cert.issuer,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12.5,
                                    color: cert.color,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: cert.color.withOpacity(0.12),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Text(
                                    cert.year,
                                    style: GoogleFonts.poppins(
                                      fontSize: 11,
                                      color: cert.color,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }
}
