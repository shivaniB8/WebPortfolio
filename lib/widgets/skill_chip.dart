import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/colors.dart';

class SkillChip extends StatefulWidget {
  final String label;
  final Color color;

  const SkillChip({
    super.key,
    required this.label,
    required this.color,
  });

  @override
  State<SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<SkillChip> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: _hovered
              ? widget.color.withOpacity(0.25)
              : widget.color.withOpacity(0.12),
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: _hovered
                ? widget.color.withOpacity(0.8)
                : widget.color.withOpacity(0.4),
            width: 1,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: widget.color.withOpacity(0.3),
                    blurRadius: 12,
                    spreadRadius: 1,
                  )
                ]
              : [],
        ),
        child: Text(
          widget.label,
          style: GoogleFonts.poppins(
            fontSize: 12.5,
            fontWeight: FontWeight.w500,
            color: _hovered ? Colors.white : widget.color.withOpacity(0.9),
          ),
        ),
      ),
    );
  }
}
