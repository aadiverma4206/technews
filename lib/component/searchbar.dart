import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:technews/utils/color.dart';
import 'package:technews/backend/functions.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);
  static TextEditingController searchcontroller = TextEditingController(
    text: '',
  );

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar>
    with SingleTickerProviderStateMixin {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Animated Search Box
        Expanded(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeInOut,
            height: 55,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(40),
              border: Border.all(
                color: _isFocused
                    ? Theme.of(context).colorScheme.primary.withOpacity(0.8)
                    : Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
                width: 1.2,
              ),

              boxShadow: _isFocused
                  ? [
                      BoxShadow(
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withOpacity(0.6),
                        blurRadius: 15,
                        spreadRadius: 1,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : [],
            ),
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  color: _isFocused
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(
                          context,
                        ).colorScheme.onSurface.withOpacity(0.6),
                ),

                const SizedBox(width: 12),
                Expanded(
                  child: Focus(
                    onFocusChange: (hasFocus) {
                      setState(() => _isFocused = hasFocus);
                    },
                    child: TextField(
                      controller: SearchBar.searchcontroller,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Search a keyword or phrase...',
                        hintStyle: GoogleFonts.poppins(
                          color: Colors.white70,
                          fontSize: 15,
                        ),
                        border: InputBorder.none,
                      ),
                      cursorColor: Theme.of(context).colorScheme.primary,

                      textInputAction: TextInputAction.search,
                      onSubmitted: (query) {
                        fetchNews(); // trigger news fetch
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Animated Glowing Button
        GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            fetchNews();
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.primary.withGreen(10),
                  
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                  blurRadius: 15,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: const Icon(
              Icons.arrow_forward_rounded,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}
