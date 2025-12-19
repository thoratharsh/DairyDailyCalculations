import 'package:flutter_test/flutter_test.dart';

import 'package:dairycalculations/main.dart';

void main() {
  testWidgets('App renders home page', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const DairyDailyApp());

    // Verify the home page renders with the title
    expect(find.text('Dairy Daily'), findsOneWidget);
    expect(find.text('Calculations made simple'), findsOneWidget);

    // Verify calculation type cards are present
    expect(find.text('Daily Calculation'), findsOneWidget);
    expect(find.text('10 Days Calculation'), findsOneWidget);
    expect(find.text('Monthly Calculation'), findsOneWidget);
  });
}
