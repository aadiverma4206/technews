// lib/utils/function.dart

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:technews/component/searchbar.dart';
import 'package:technews/utils/key.dart'; // make sure this path is correct

Future<List<Map<String, dynamic>>> fetchNews() async {
  final query = SearchBar.searchcontroller.text.trim();

  final params = <String, String>{
    'country': 'us',
    'category': 'technology',
    'pageSize': '100',
    'apiKey': ApiKey.value,
    if (query.isNotEmpty) 'q': query,
  };

  final uri = Uri.https('newsapi.org', '/v2/top-headlines', params);

  try {
    final response = await http
        .get(uri, headers: {HttpHeaders.acceptHeader: 'application/json'})
        .timeout(const Duration(seconds: 12));

    if (response.statusCode != 200) {
      if (kDebugMode) {
        debugPrint('fetchNews: HTTP ${response.statusCode} ${response.reasonPhrase}');
        debugPrint(response.body);
      }
      return const [];
    }

    final Map<String, dynamic> json = jsonDecode(response.body);

    if (json['status'] != 'ok') {
      if (kDebugMode) debugPrint('fetchNews: API error: ${json['message']}');
      return const [];
    }

    final rawArticles = json['articles'];
    if (rawArticles is! List) return const [];

    final List<Map<String, dynamic>> articles = [];

    for (final item in rawArticles) {
      if (item is Map<String, dynamic>) {
        articles.add(item);
      }
    }

    // Deduplicate articles by URL
    final seenUrls = <String>{};
    final dedupedArticles = <Map<String, dynamic>>[];

    for (final article in articles) {
      final url = article['url'] as String? ?? '';
      if (url.isNotEmpty && seenUrls.add(url)) {
        dedupedArticles.add(article);
      }
    }

    return dedupedArticles;
  } on SocketException {
    if (kDebugMode) debugPrint('fetchNews: No internet connection');
    return const [];
  } on TimeoutException {
    if (kDebugMode) debugPrint('fetchNews: Request timed out');
    return const [];
  } on FormatException catch (e) {
    if (kDebugMode) debugPrint('fetchNews: JSON format error: $e');
    return const [];
  } catch (e) {
    if (kDebugMode) debugPrint('fetchNews: Unexpected error: $e');
    return const [];
  }
}
