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
      catsService = CatsService(httpClient: httpClient);
    });

    group('constructor', () {
      test('does not require an httpClient', () {
        expect(CatsService(), isNotNull);
      });
    });

    group('api tests for real', () {
      test(
          'When service returns 200 but empty response we shuld should throw ErrorEmptyResponse',
          () async {
        final mockResponse = MockHttpResponse();

        when(() => mockResponse.statusCode).thenReturn(200);
        when(() => mockResponse.body).thenReturn('');

        when(() => httpClient.get(any(), headers: any(named: 'headers')))
            .thenAnswer((_) async => mockResponse);

        final service = CatsService(httpClient: httpClient);

        expect(service.fetchNewCat(), throwsA(isA<ErrorEmptyResponse>()));
      });

      test(
          'When service returns non-200 response we should throw ErrorSearchingCat',
          () async {
        final mockResponse = MockHttpResponse();

        when(() => mockResponse.statusCode).thenReturn(500);
        when(() => mockResponse.body).thenReturn('Not Found');

        when(() => httpClient.get(any(), headers: any(named: 'headers')))
            .thenAnswer((_) async => mockResponse);

        catsService = CatsService(httpClient: httpClient);

        expect(catsService.fetchNewCat(), throwsA(isA<ErrorSearchingCat>()));
      });

      test(
          'When service returns 200 with valid response we should get Cat object',
          () async {
        final mockResponse = MockHttpResponse();
        final jsonResponse = '''
        [
          {
            "id": "abc123",
            "url": "https://cdn2.thecatapi.com/images/abc123.jpg"
          }
        ]
        ''';

        when(() => mockResponse.statusCode).thenReturn(200);
        when(() => mockResponse.body).thenReturn(jsonResponse);

        when(() => httpClient.get(any(), headers: any(named: 'headers')))
            .thenAnswer((_) async => mockResponse);

        catsService = CatsService(httpClient: httpClient);

        final cat = await catsService.fetchNewCat();

        expect(cat.catId, 'abc123');
        expect(cat.imageUrl, 'https://cdn2.thecatapi.com/images/abc123.jpg');
      });
    });
  });
}
