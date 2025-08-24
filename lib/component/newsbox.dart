import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:technews/utils/color.dart';
import 'package:technews/utils/text.dart';
import 'bottomsheet.dart';
import 'components.dart';

class NewsBox extends StatefulWidget {
  final String imageurl, title, time, description, url;

  const NewsBox({
    Key? key,
    required this.imageurl,
    required this.title,
    required this.time,
    required this.description,
    required this.url,
  }) : super(key: key);

  @override
  State<NewsBox> createState() => _NewsBoxState();
}

class _NewsBoxState extends State<NewsBox> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Column(
      children: [
        GestureDetector(
          onTapDown: (_) => setState(() => _isPressed = true),
          onTapUp: (_) => setState(() => _isPressed = false),
          onTapCancel: () => setState(() => _isPressed = false),
          onTap: () {
            showMyBottomSheet(
              context,
              widget.title,
              widget.description,
              widget.imageurl,
              widget.url,
            );
          },
          child: AnimatedScale(
            scale: _isPressed ? 0.97 : 1.0,
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeInOut,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              padding: const EdgeInsets.all(14),
              width: w,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.07), // glassy
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary.withRed(10),

                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withOpacity(0.35),

                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Image with lightweight placeholder (no extra deps)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: CachedNetworkImage(
                      imageUrl: widget.imageurl,
                      width: 72,
                      height: 72,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        width: 72,
                        height: 72,
                        alignment: Alignment.center,
                        color: Colors.white.withOpacity(0.06),
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        width: 72,
                        height: 72,
                        color: Colors.white.withOpacity(0.06),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.broken_image_outlined,
                          color: Colors.white70,
                          size: 22,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),

                  // Title + time chip
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FuturisticText(
                          text: widget.title,
                          size: 16,
                          color: Theme.of(context).colorScheme.onSurface,

                          bold: true, // makes it look like a headline
                          glow: true, // adds a neon glow effect
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.primary.withOpacity(0.18),
                            // this color for backgrounf of the data & time

                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: FuturisticText(
                            text: widget.time,
                            size: 12,
                            color: Theme.of(context).colorScheme.primary.withBlue(1),
                            //this color for data & time
                            bold: false,
                            // glow: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Icon(
                    Icons.chevron_right,
                    color: Colors.white54,
                    size: 26,
                  ),
                ],
              ),
            ),
          ),
        ),
        // keep your divider for list separation
        DividerWidget(),
      ],
    );
  }
}
