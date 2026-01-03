import "package:catproject/repository/models/cat.dart";
import 'package:http/http.dart' as http;
import 'dart:convert';

class CatsService {
  final String baseUrl;
  final String apiKey;

  CatsService({this.baseUrl = 'https://api.thecatapi.com/v1', String? apiKey})
      : apiKey = apiKey ??
            const String.fromEnvironment('THECATAPI_KEY', defaultValue: '');

  Future<Cat> fetchNewCat() async {
    try {
      final headers = apiKey.isNotEmpty ? {'x-api-key': apiKey} : null;
      final response = await http.get(
        Uri.parse('$baseUrl/images/search'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        Cat cat = Cat.fromJson(json.decode(response.body)[0]);

        return cat;
      } else {
        throw Exception('Failed to load cat');
      }
    } catch (e) {
      print('Error fetching cat 😿: $e');
      return Cat(catId: 'error', imageUrl: null);
    }
  }
}
