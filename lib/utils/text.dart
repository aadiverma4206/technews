import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FuturisticText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final bool bold;
  final bool glow;
  final TextAlign align;

  const FuturisticText({
    Key? key,
    required this.text,
    this.size = 16,
    this.color = Colors.white,
    this.bold = false,
    this.glow = false,
    this.align = TextAlign.start,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedDefaultTextStyle(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      style: GoogleFonts.lato(
        fontSize: size,
        fontWeight: bold ? FontWeight.bold : FontWeight.w400,
        color: color,
        shadows: glow
            ? [
          Shadow(
            blurRadius: 10,
            color: color.withOpacity(0.7),
            offset: const Offset(0, 0),
          ),
        ]
            : [],
      ),
      child: Text(
        text,
        textAlign: align,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class GradientText extends StatelessWidget {
  final String text;
  final double size;
  final Gradient gradient;
  final TextAlign align;

  const GradientText({
    Key? key,
    required this.text,
    this.size = 18,
    this.gradient = const LinearGradient(
      colors: [Color(0xFF7F00FF), Color(0xFFE100FF)], // Purple → Pink
    ),
    this.align = TextAlign.start,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) =>
          gradient.createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
      child: Text(
        text,
        textAlign: align,
        style: GoogleFonts.lato(
          fontSize: size,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
