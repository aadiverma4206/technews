import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:technews/component/components.dart';
import 'package:technews/utils/text.dart';
import 'package:technews/webview/webview.dart';

// Show Animated BottomSheet
void showMyBottomSheet(
    BuildContext context,
    String title,
    String description,
    String imageurl,
    String url,
    ) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
    ),
    builder: (context) {
      return MyBottomSheetLayout(
        url: url,
        imageurl: imageurl,
        title: title,
        description: description,
      );
    },
  );
}

//Modern, Animated BottomSheet Layout
class MyBottomSheetLayout extends StatelessWidget {
  final String title, description, imageurl, url;

  const MyBottomSheetLayout({
    Key? key,
    required this.title,
    required this.description,
    required this.imageurl,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.65,
      minChildSize: 0.45,
      maxChildSize: 0.92,
      expand: false,
      builder: (_, controller) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade900.withOpacity(0.95),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.6),
                blurRadius: 12,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            children: [
              // Top drag handle
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                height: 5,
                width: 60,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              // Content (scrollable)
              Expanded(
                child: ListView(
                  controller: controller,
                  padding: const EdgeInsets.only(bottom: 20),
                  children: [
                    BottomSheetImage(imageurl: imageurl, title: title),

                    // Description
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: FuturisticText(
                        text: description,
                        size: 16,
                        color: Colors.white,
                        bold: false,
                        glow: true,
                      ),
                    ),

                    // Read more button (opens WebView)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 20,
                          ),
                          elevation: 4,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => WebViewPage(url: url),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.open_in_new,
                          color: Colors.white,
                        ),
                        label: Text(
                          "Read Full Article",
                          style: GoogleFonts.lato(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
