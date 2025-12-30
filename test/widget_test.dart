import 'package:catproject/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("My cat widget has title", (WidgetTester widgetTester) async {
    await widgetTester.pumpWidget(const MyApp());

    final titleFinder = find.text('Random Cat Viewer 🐱');

    expect(titleFinder, findsOneWidget);
  });
}
