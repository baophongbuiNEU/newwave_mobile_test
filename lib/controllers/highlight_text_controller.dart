import 'package:flutter/material.dart';

class HighlightTextController {
  static TextSpan buildHighlightedText(String text, String searchQuery) {
    final List<TextSpan> spans = [];
    final lowercaseLocation = text.toLowerCase();
    final lowercaseSearch = searchQuery.toLowerCase();

    if (!lowercaseLocation.contains(lowercaseSearch)) {
      // If no match, return the whole text in normal style
      return TextSpan(
        text: text,
        style: const TextStyle(color: Colors.black38),
      );
    }

    int startIndex = 0;
    int matchIndex;

    // Find and highlight all occurrences of the search query
    while ((matchIndex = lowercaseLocation.indexOf(
          lowercaseSearch,
          startIndex,
        )) !=
        -1) {
      // Add non-matching text before highlight
      if (matchIndex > startIndex) {
        spans.add(
          TextSpan(
            text: text.substring(startIndex, matchIndex),
            style: const TextStyle(color: Colors.black38),
          ),
        );
      }

      // Add highlighted text
      spans.add(
        TextSpan(
          text: text.substring(matchIndex, matchIndex + searchQuery.length),
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

      startIndex = matchIndex + searchQuery.length;
    }

    // Add remaining text after last match
    if (startIndex < text.length) {
      spans.add(
        TextSpan(
          text: text.substring(startIndex),
          style: const TextStyle(color: Colors.black38),
        ),
      );
    }

    return TextSpan(children: spans);
  }
}
