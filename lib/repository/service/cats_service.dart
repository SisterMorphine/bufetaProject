import "package:catproject/repository/models/cat.dart";
import 'package:http/http.dart' as http;
import 'dart:convert';

class CatsService {
  final String baseUrl;

  CatsService({this.baseUrl = 'https://api.thecatapi.com/v1'});

  Future<Cat> fetchNewCat() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/images/search'));

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
