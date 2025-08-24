import 'package:flutter/material.dart';
import 'package:technews/utils/color.dart';
import 'package:technews/utils/text.dart';

class appbar extends StatefulWidget implements PreferredSizeWidget {
  appbar({Key? key})
    : preferredSize = const Size.fromHeight(64.0),
      super(key: key);

  @override
  final Size preferredSize;

  @override
  State<appbar> createState() => _AppBarState();
}

class _AppBarState extends State<appbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      // Rounded bottom for a modern card-like top bar
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(18)),
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.surface.withOpacity(0.95),
              Theme.of(context).colorScheme.surface.withOpacity(0.85),
            ],

            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border(
            bottom: BorderSide(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.28),

              width: 0.8,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.18),

              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
      ),
      title: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: 1),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
        builder: (context, t, child) => Opacity(
          opacity: t,
          child: Transform.translate(
            offset: Offset(0, (1 - t) * 8),
            child: child,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FuturisticText(
              text: 'Tech',
              size: 20,
              color: Theme.of(context).colorScheme.primary.withGreen(5),

              bold: true,
              glow: true,
            ),
            const SizedBox(width: 4),
            // Gradient text for "Newz" (kept simple & dependency-free)
            _GradientText(
              'Newz',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.85),
                  Theme.of(context).colorScheme.onSurface.withOpacity(0.85),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ],
        ),
      ),

      // actions: [
      //   _GlassIconButton(
      //     icon: Icons.search_rounded,
      //     tooltip: 'Search',
      //     onTap: () {}, // hook to open your search if needed
      //   ),
      //   const SizedBox(width: 8),
      //   _GlassIconButton(
      //     icon: Icons.refresh_rounded,
      //     tooltip: 'Refresh',
      //     onTap: () {}, // hook to refresh news
      //   ),
      //   const SizedBox(width: 8),
      // ],

      // Subtle bottom divider
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(10),
        child: Container(
          height: 10,
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                Colors.white.withOpacity(0.05),
                Colors.transparent,
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
      ),
    );
  }
}

//Small glassy circular icon button with ripple + shadow.
class _GlassIconButton extends StatelessWidget {
  final IconData icon;
  final String? tooltip;
  final VoidCallback onTap;

  const _GlassIconButton({
    Key? key,
    required this.icon,
    required this.onTap,
    this.tooltip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final btn = InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.06),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white.withOpacity(0.15), width: 0.7),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(icon, size: 20, color: Colors.white.withOpacity(0.9)),
      ),
    );

    return tooltip != null ? Tooltip(message: tooltip!, child: btn) : btn;
  }
}

// Lightweight gradient text without extra dependencies.
class _GradientText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Gradient gradient;

  const _GradientText(this.text, {Key? key, this.style, required this.gradient})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      blendMode: BlendMode.srcIn,
      child: Text(
        text,
        style: (style ?? const TextStyle(fontSize: 18)).copyWith(
          color: Colors.white, // will be replaced by shader
        ),
      ),
    );
  }
}
