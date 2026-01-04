import 'package:catproject/repository/service/cats_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

class MockHttpClient extends Mock implements http.Client {}

class MockHttpResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  group('Cat service tests', () {
    late MockHttpClient httpClient;
    late CatsService catsService;

    setUpAll(() {
      registerFallbackValue(FakeUri());
    });

    setUp(() {
      httpClient = MockHttpClient();
      catsService = CatsService();
    });

    group('constructor', () {
      test('does not require an httpClient', () {
        expect(CatsService(), isNotNull);
      });
    });
  });
}
