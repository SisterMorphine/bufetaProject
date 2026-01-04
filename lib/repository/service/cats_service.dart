import "package:catproject/repository/models/cat.dart";
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:http/http.dart';

class CatsService {
  final String baseUrl;
  final String apiKey;
  final http.Client httpClient;

  CatsService({
    http.Client? httpClient,
    this.baseUrl = 'https://api.thecatapi.com/v1',
    String? apiKey,
  })  : httpClient = httpClient ?? http.Client(),
        apiKey = apiKey ?? const String.fromEnvironment('THECATAPI_KEY');

  Future<Cat> fetchNewCat() async {
    try {
      final headers = apiKey.isNotEmpty ? {'x-api-key': apiKey} : null;
      final response = await http.get(
        Uri.parse('$baseUrl/images/search'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          Cat cat = Cat.fromJson(json.decode(response.body)[0]);
          return cat;
        } else {
          throw ErrorEmptyResponse();
        }
      } else {
        throw ErrorSearchingCat();
      }
    } catch (e) {
      print('Error fetching cat 😿: $e');
      return Cat(catId: 'error', imageUrl: null);
    }
  }
}

class ErrorSearchingCat implements Exception {}

class ErrorEmptyResponse implements Exception {}
