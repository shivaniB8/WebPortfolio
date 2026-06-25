import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'sections/hero_section.dart';
import 'sections/about_section.dart';
import 'sections/skills_section.dart';
import 'sections/experience_section.dart';
import 'sections/projects_section.dart';
import 'sections/education_section.dart';
import 'sections/contact_section.dart';
import 'theme/colors.dart';

// Responsive breakpoints
const double kMobileBreakpoint = 600;
const double kTabletBreakpoint = 1024;

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final ScrollController _scrollController = ScrollController();
  bool _mobileMenuOpen = false;
  int _activeNavIndex = -1;

  // Section keys for scroll-to navigation
  final List<GlobalKey> _sectionKeys = List.generate(6, (_) => GlobalKey());

  // Nav item labels
  static const _navItems = [
    'About',
    'Skills',
    'Experience',
    'Projects',
    'Education',
    'Contact',
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    int newActive = -1;
    final viewportTop = _scrollController.offset;
    // Use a 100px lookahead — section is "active" when its top is near/past top
    for (int i = _sectionKeys.length - 1; i >= 0; i--) {
      final ctx = _sectionKeys[i].currentContext;
      if (ctx == null) continue;
      final box = ctx.findRenderObject() as RenderBox?;
      if (box == null) continue;
      final pos = box.localToGlobal(Offset.zero);
      // pos.dy is in viewport coords; add scroll offset to get scroll position
      final sectionScrollTop = viewportTop + pos.dy - 64; // 64 = nav height
      if (viewportTop >= sectionScrollTop - 80) {
        newActive = i;
        break;
      }
    }
    if (newActive != _activeNavIndex) {
      setState(() => _activeNavIndex = newActive);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(int index) {
    setState(() => _mobileMenuOpen = false);
    final key = _sectionKeys[index];
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
        alignment: 0.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Main scrollable content
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              // Sticky nav bar (transparent sliver persistent header)
              SliverPersistentHeader(
                pinned: true,
                delegate: _NavBarDelegate(
                  scrollController: _scrollController,
                  sectionKeys: _sectionKeys,
                  isMobile: isMobile,
                  mobileMenuOpen: _mobileMenuOpen,
                  activeIndex: _activeNavIndex,
                  onMenuToggle: () =>
                      setState(() => _mobileMenuOpen = !_mobileMenuOpen),
                  onNavTap: _scrollToSection,
                  navItems: _navItems,
                ),
              ),

              // Hero (no key needed — it's the top)
              const SliverToBoxAdapter(child: HeroSection()),

              // Keyed sections
              SliverToBoxAdapter(
                child: KeyedSubtree(
                  key: _sectionKeys[0],
                  child: const AboutSection(),
                ),
              ),
              SliverToBoxAdapter(
                child: KeyedSubtree(
                  key: _sectionKeys[1],
                  child: const SkillsSection(),
                ),
              ),
              SliverToBoxAdapter(
                child: KeyedSubtree(
                  key: _sectionKeys[2],
                  child: const ExperienceSection(),
                ),
              ),
              SliverToBoxAdapter(
                child: KeyedSubtree(
                  key: _sectionKeys[3],
                  child: const ProjectsSection(),
                ),
              ),
              SliverToBoxAdapter(
                child: KeyedSubtree(
                  key: _sectionKeys[4],
                  child: const EducationSection(),
                ),
              ),
              SliverToBoxAdapter(
                child: KeyedSubtree(
                  key: _sectionKeys[5],
                  child: const ContactSection(),
                ),
              ),

              // Footer
              const SliverToBoxAdapter(child: _Footer()),
            ],
          ),

          // Mobile slide-down menu (overlay)
          if (isMobile)
            Positioned(
              top: 64,
              left: 0,
              right: 0,
              child: _MobileMenu(
                isOpen: _mobileMenuOpen,
                items: _navItems,
                onTap: _scrollToSection,
              ),
            ),
        ],
      ),
    );
  }
}

// ── Nav Bar Persistent Header Delegate ───────────────────────────────────────

class _NavBarDelegate extends SliverPersistentHeaderDelegate {
  final ScrollController scrollController;
  final List<GlobalKey> sectionKeys;
  final bool isMobile;
  final bool mobileMenuOpen;
  final int activeIndex;
  final VoidCallback onMenuToggle;
  final void Function(int) onNavTap;
  final List<String> navItems;

  _NavBarDelegate({
    required this.scrollController,
    required this.sectionKeys,
    required this.isMobile,
    required this.mobileMenuOpen,
    required this.activeIndex,
    required this.onMenuToggle,
    required this.onNavTap,
    required this.navItems,
  });

  @override
  double get minExtent => 64;

  @override
  double get maxExtent => 64;

  @override
  bool shouldRebuild(_NavBarDelegate old) =>
      old.isMobile != isMobile ||
      old.mobileMenuOpen != mobileMenuOpen ||
      old.activeIndex != activeIndex;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          height: 64,
          decoration: BoxDecoration(
            color: AppColors.background.withOpacity(0.85),
            border: const Border(
              bottom: BorderSide(color: AppColors.glassBorder, width: 1),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 16 : 48,
            ),
            child: Row(
              children: [
                // Logo
                ShaderMask(
                  shaderCallback: (bounds) =>
                      AppColors.primaryGradient.createShader(bounds),
                  child: Text(
                    'SB',
                    style: GoogleFonts.raleway(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Shivani Bagal',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
                const Spacer(),
                if (!isMobile) ...[
                  ...List.generate(navItems.length, (i) {
                    return _NavLink(
                      label: navItems[i],
                      isActive: activeIndex == i,
                      onTap: () => onNavTap(i),
                    );
                  }),
                ] else ...[
                  IconButton(
                    icon: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: Icon(
                        mobileMenuOpen
                            ? Icons.close_rounded
                            : Icons.menu_rounded,
                        key: ValueKey(mobileMenuOpen),
                        color: AppColors.textPrimary,
                      ),
                    ),
                    onPressed: onMenuToggle,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavLink({
    required this.label,
    required this.onTap,
    this.isActive = false,
  });

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final highlighted = _hovered || widget.isActive;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight:
                      widget.isActive ? FontWeight.w700 : FontWeight.w500,
                  color: highlighted ? Colors.white : AppColors.textSecondary,
                  shadows: highlighted
                      ? [
                          Shadow(
                            color: AppColors.cyan.withOpacity(0.8),
                            blurRadius: 8,
                          )
                        ]
                      : [],
                ),
                child: Text(widget.label),
              ),
              const SizedBox(height: 2),
              // Active indicator dot
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: widget.isActive ? 20 : 0,
                height: 2,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Mobile Slide-down Menu ────────────────────────────────────────────────────

class _MobileMenu extends StatelessWidget {
  final bool isOpen;
  final List<String> items;
  final void Function(int) onTap;

  const _MobileMenu({
    required this.isOpen,
    required this.items,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
      height: isOpen ? items.length * 52.0 : 0,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.background.withOpacity(0.97),
              border: const Border(
                bottom: BorderSide(color: AppColors.glassBorder, width: 1),
              ),
            ),
            child: OverflowBox(
              alignment: Alignment.topCenter,
              maxHeight: items.length * 52.0,
              child: Column(
                children: items.asMap().entries.map((entry) {
                  return InkWell(
                    onTap: () => onTap(entry.key),
                    child: Container(
                      height: 52,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        entry.value,
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Footer ────────────────────────────────────────────────────────────────────

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 24),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.glassBorder, width: 1),
        ),
      ),
      child: Column(
        children: [
          ShaderMask(
            shaderCallback: (bounds) =>
                AppColors.primaryGradient.createShader(bounds),
            child: Text(
              'Shivani Bagal',
              style: GoogleFonts.raleway(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Flutter Developer · Pune, India',
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: AppColors.textMuted,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '© ${DateTime.now().year} Shivani Bagal. All rights reserved.',
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}
