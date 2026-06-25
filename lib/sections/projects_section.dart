import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../data/portfolio_data.dart';
import '../theme/colors.dart';
import '../widgets/section_header.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  bool _visible = false;

  int _crossCount(double width) {
    if (width > 1100) return 3;
    if (width > 700) return 2;
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 768;
    final crossCount = _crossCount(width);

    return VisibilityDetector(
      key: const Key('projects_section'),
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
              title: 'Projects',
              subtitle: 'Government, enterprise, and personal creations',
              visible: _visible,
            ),
            const SizedBox(height: 56),
            _ProjectsGrid(
              projects: PortfolioData.projects,
              visible: _visible,
              crossCount: crossCount,
            ),
          ],
        ),
      ),
    );
  }
}

class _ProjectsGrid extends StatelessWidget {
  final List<ProjectModel> projects;
  final bool visible;
  final int crossCount;

  const _ProjectsGrid({
    required this.projects,
    required this.visible,
    required this.crossCount,
  });

  @override
  Widget build(BuildContext context) {
    final rows = <List<ProjectModel>>[];
    for (int i = 0; i < projects.length; i += crossCount) {
      rows.add(projects.sublist(
        i,
        (i + crossCount).clamp(0, projects.length),
      ));
    }

    return Column(
      children: rows.asMap().entries.map((rowEntry) {
        final rowIdx = rowEntry.key;
        final rowProjects = rowEntry.value;

        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: rowProjects.asMap().entries.map((entry) {
              final colIdx = entry.key;
              final project = entry.value;
              final delay = (rowIdx * crossCount + colIdx) * 100;

              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: colIdx > 0 ? 10 : 0,
                    right: colIdx < rowProjects.length - 1 ? 10 : 0,
                  ),
                  child: AnimatedOpacity(
                    opacity: visible ? 1 : 0,
                    duration: Duration(milliseconds: 600 + delay),
                    child: AnimatedSlide(
                      offset: visible ? Offset.zero : const Offset(0, 0.15),
                      duration: Duration(milliseconds: 600 + delay),
                      curve: Curves.easeOutCubic,
                      child: _ProjectCard(project: project),
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

class _ProjectCard extends StatefulWidget {
  final ProjectModel project;

  const _ProjectCard({required this.project});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hovered = false;

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.platformDefault);
    }
  }

  @override
  Widget build(BuildContext context) {
    final project = widget.project;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        transform: _hovered
            ? (Matrix4.identity()..translate(0.0, -6.0))
            : Matrix4.identity(),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            if (_hovered)
              BoxShadow(
                color: project.gradientStart.withOpacity(0.35),
                blurRadius: 40,
                spreadRadius: 4,
              ),
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              decoration: BoxDecoration(
                color: _hovered ? AppColors.glassHover : AppColors.glassWhite,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: _hovered
                      ? project.gradientStart.withOpacity(0.5)
                      : AppColors.glassBorder,
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Gradient top bar
                  Container(
                    height: 5,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [project.gradientStart, project.gradientEnd],
                      ),
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Icon + Title
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    project.gradientStart,
                                    project.gradientEnd,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(project.icon,
                                  color: Colors.white, size: 22),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    project.title,
                                    style: GoogleFonts.raleway(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  if (project.githubUrl != null)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: InkWell(
                                        onTap: () =>
                                            _launch(project.githubUrl!),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.open_in_new_rounded,
                                                size: 12,
                                                color: project.gradientStart),
                                            const SizedBox(width: 4),
                                            Text(
                                              'GitHub',
                                              style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                color: project.gradientStart,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Description
                        Text(
                          project.description,
                          style: GoogleFonts.poppins(
                            fontSize: 13.5,
                            color: AppColors.textSecondary,
                            height: 1.6,
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Tags
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: project.tags.map((tag) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color:
                                    project.gradientStart.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                  color: project.gradientStart.withOpacity(0.4),
                                ),
                              ),
                              child: Text(
                                tag,
                                style: GoogleFonts.poppins(
                                  fontSize: 11.5,
                                  color: project.gradientStart.withOpacity(0.9),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
