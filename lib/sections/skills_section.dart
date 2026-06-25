import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../data/portfolio_data.dart';
import '../theme/colors.dart';
import '../widgets/glass_card.dart';
import '../widgets/section_header.dart';
import '../widgets/skill_chip.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 768;
    final crossCount = width > 1100 ? 3 : (width > 700 ? 2 : 1);

    return VisibilityDetector(
      key: const Key('skills_section'),
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
              title: 'Skills & Technologies',
              subtitle: 'A broad toolkit built over 4+ years of real-world delivery',
              visible: _visible,
            ),
            const SizedBox(height: 56),
            _SkillsGrid(
              categories: PortfolioData.skillCategories,
              visible: _visible,
              crossCount: crossCount,
            ),
          ],
        ),
      ),
    );
  }
}

class _SkillsGrid extends StatelessWidget {
  final List<SkillCategory> categories;
  final bool visible;
  final int crossCount;

  const _SkillsGrid({
    required this.categories,
    required this.visible,
    required this.crossCount,
  });

  @override
  Widget build(BuildContext context) {
    // Build rows manually for staggered animation
    final rows = <List<SkillCategory>>[];
    for (int i = 0; i < categories.length; i += crossCount) {
      rows.add(categories.sublist(
        i,
        (i + crossCount).clamp(0, categories.length),
      ));
    }

    return Column(
      children: rows.asMap().entries.map((rowEntry) {
        final rowIdx = rowEntry.key;
        final rowCats = rowEntry.value;

        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: rowCats.asMap().entries.map((entry) {
              final colIdx = entry.key;
              final cat = entry.value;
              final delay = (rowIdx * crossCount + colIdx) * 100;

              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: colIdx > 0 ? 10 : 0,
                    right: colIdx < rowCats.length - 1 ? 10 : 0,
                  ),
                  child: AnimatedOpacity(
                    opacity: visible ? 1 : 0,
                    duration: Duration(milliseconds: 600 + delay),
                    child: AnimatedSlide(
                      offset: visible ? Offset.zero : const Offset(0, 0.2),
                      duration: Duration(milliseconds: 600 + delay),
                      curve: Curves.easeOutCubic,
                      child: _SkillCategoryCard(category: cat),
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

class _SkillCategoryCard extends StatelessWidget {
  final SkillCategory category;

  const _SkillCategoryCard({required this.category});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      hoverGlow: true,
      glowColor: category.color,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: category.color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: category.color.withOpacity(0.4),
                    width: 1,
                  ),
                ),
                child: Icon(category.icon, color: category.color, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  category.title,
                  style: GoogleFonts.raleway(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: category.color,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: category.skills
                .map((s) => SkillChip(label: s, color: category.color))
                .toList(),
          ),
        ],
      ),
    );
  }
}
