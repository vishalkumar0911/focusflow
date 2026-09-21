import 'package:flutter_test/flutter_test.dart';

import 'package:focusflow/main.dart';

void main() {
  testWidgets('FocusFlow app loads correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const FocusFlowApp());

    expect(find.text('FocusFlow'), findsOneWidget);
    expect(find.text("Today's Progress"), findsOneWidget);
    expect(find.text("Today's Schedule"), findsOneWidget);
  });
}
