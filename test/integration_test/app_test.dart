import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:stage_app/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Movie list loads and toggles favorite', (tester) async {
    await tester.pumpWidget(const MyApp());

    // Wait for movies to load
    await tester.pumpAndSettle();

    // Check if at least one movie appears
    expect(find.byType(GridTile), findsWidgets);

    // Tap the first movie's favorite button
    await tester.tap(find.byIcon(Icons.favorite_border).first);
    await tester.pump();

    // Expect favorite icon to be filled
    expect(find.byIcon(Icons.favorite).first, findsOneWidget);
  });
}
