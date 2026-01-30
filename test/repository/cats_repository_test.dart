import 'package:catproject/repository/cats_repository.dart';
import 'package:catproject/repository/models/cat.dart';
import 'package:catproject/repository/service/cats_service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockCatsService extends Mock implements CatsService {}

void main() {
  group('CatsRepository', () {
    late MockCatsService mockCatsService;
    late CatsRepository catsRepository;

    setUp(() {
      mockCatsService = MockCatsService();
      catsRepository = CatsRepository(service: mockCatsService);
    });

    group('fetchNewCat', () {
      test('returns a Cat when service call is successful', () async {
        // Arrange
        const testCat = Cat(
          catId: 'test-id-123',
          imageUrl: 'https://example.com/cat.jpg',
        );
        when(() => mockCatsService.fetchNewCat())
            .thenAnswer((_) async => testCat);

        // Act
        final result = await catsRepository.fetchNewCat();

        // Assert
        expect(result, equals(testCat));
        expect(result.catId, equals('test-id-123'));
        expect(result.imageUrl, equals('https://example.com/cat.jpg'));
        verify(() => mockCatsService.fetchNewCat()).called(1);
      });

      test('returns a Cat without imageUrl when service provides it', () async {
        // Arrange
        const testCat = Cat(
          catId: 'test-id-456',
          imageUrl: null,
        );
        when(() => mockCatsService.fetchNewCat())
            .thenAnswer((_) async => testCat);

        // Act
        final result = await catsRepository.fetchNewCat();

        // Assert
        expect(result, equals(testCat));
        expect(result.catId, equals('test-id-456'));
        expect(result.imageUrl, isNull);
      });

      test('throws exception when service throws ErrorSearchingCat', () async {
        // Arrange
        when(() => mockCatsService.fetchNewCat())
            .thenThrow(ErrorSearchingCat());

        // Act & Assert
        expect(
          () => catsRepository.fetchNewCat(),
          throwsA(isA<ErrorSearchingCat>()),
        );
        verify(() => mockCatsService.fetchNewCat()).called(1);
      });

      test('throws exception when service throws ErrorEmptyResponse', () async {
        // Arrange
        when(() => mockCatsService.fetchNewCat())
            .thenThrow(ErrorEmptyResponse());

        // Act & Assert
        expect(
          () => catsRepository.fetchNewCat(),
          throwsA(isA<ErrorEmptyResponse>()),
        );
        verify(() => mockCatsService.fetchNewCat()).called(1);
      });

      test('calls service fetchNewCat exactly once', () async {
        // Arrange
        const testCat = Cat(
          catId: 'test-id-789',
          imageUrl: 'https://example.com/another-cat.jpg',
        );
        when(() => mockCatsService.fetchNewCat())
            .thenAnswer((_) async => testCat);

        // Act
        await catsRepository.fetchNewCat();

        // Assert
        verify(() => mockCatsService.fetchNewCat()).called(1);
      });
    });
  });
}
