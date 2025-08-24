import 'package:flutter/material.dart';
import 'package:technews/utils/text.dart';
import 'package:technews/utils/color.dart';

// Modern Divider
class DividerWidget extends StatelessWidget {
  const DividerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Divider(
        thickness: 0.8,
        height: 24,
        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),

      ),
    );
  }
}

// Modern BottomSheet Header Image
class BottomSheetImage extends StatelessWidget {
  final String imageurl, title;
  const BottomSheetImage({
    Key? key,
    required this.imageurl,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(22),
        topRight: Radius.circular(22),
      ),
      child: SizedBox(
        height: 280,
        width: w,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background image with fallback color
            Container(
              color: Colors.grey.shade900,
              child: Image.network(
                imageurl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.black45,
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.broken_image,
                    color: Colors.white54,
                    size: 40,
                  ),
                ),
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return Container(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      value: progress.expectedTotalBytes != null
                          ? progress.cumulativeBytesLoaded /
                                (progress.expectedTotalBytes ?? 1)
                          : null,
                      color: Theme.of(context).colorScheme.primary,

                    ),
                  );
                },
              ),
            ),

            // Gradient overlay
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black87, Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),

            // Title at bottom
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.45),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 0.6,
                  ),
                ),
                child: FuturisticText(
                  text: title,
                  size: 18,
                  color: Colors.white,
                  bold: true,
                  glow: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
