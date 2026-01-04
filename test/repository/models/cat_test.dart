import "package:catproject/repository/models/cat.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  test('we transform correctly from JSON to model', () {
    final json = {
      'id': 'abc123',
      'url': 'https://example.com/cat.jpg',
    };

    final cat = Cat.fromJson(json);

    expect(cat.catId, 'abc123');
    expect(cat.imageUrl, 'https://example.com/cat.jpg');
  });

  test('empty cat is defined correctly', () {
    const emptyCat = Cat.empty;

    expect(emptyCat.catId, '');
    expect(emptyCat.imageUrl, null);
  });

  test('cats with same id and image are considered equals', () {
    final catA = Cat(catId: 'xyz', imageUrl: 'https://example.com/catA.jpg');
    final catB = Cat(catId: 'xyz', imageUrl: 'https://example.com/catA.jpg');

    expect(catA, equals(catB));
  });

  test('tests with different id OR imageId are considered different', () {
    final catB = Cat(catId: 'xyz', imageUrl: 'https://example.com/catB.jpg');
    final catC = Cat(catId: 'abc', imageUrl: 'https://example.com/catA.jpg');

    expect(catB, isNot(equals(catC)));
  });
}
