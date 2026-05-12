import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:udsm_connected_intelligent_system/main.dart';

void main() {
  testWidgets('staff and alumni can sign in from the shared welcome screen',
      (tester) async {
    await tester.pumpWidget(const UcisAdminApp());

    expect(find.text('UDSM MOBILE\nAPPLICATION'), findsOneWidget);
    expect(find.text('Login as Staff'), findsOneWidget);
    expect(find.text('Login as Alumni'), findsOneWidget);
    expect(find.text('Login as Student'), findsOneWidget);

    await tester.tap(find.text('Login as Staff'));
    await tester.pumpAndSettle();

    expect(find.text('Staff Login'), findsOneWidget);

    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Dr. James Kalolo'), findsOneWidget);
    expect(find.text('Quick Actions'), findsOneWidget);
    expect(find.text('Today\'s Tasks'), findsOneWidget);

    await tester.drag(find.byType(Scrollable).first, const Offset(0, -260));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Info').last);
    await tester.pumpAndSettle();

    expect(find.text('Staff account details and security'), findsOneWidget);

    await tester.scrollUntilVisible(find.text('Logout'), 140);
    await tester.tap(find.text('Logout'));
    await tester.pumpAndSettle();

    expect(find.text('Login as Staff'), findsOneWidget);

    await tester.tap(find.text('Login as Alumni'));
    await tester.pumpAndSettle();

    expect(find.text('Alumni Login'), findsOneWidget);
    expect(find.text('Register as Alumni'), findsOneWidget);

    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    expect(find.text('Session timeout warning'), findsOneWidget);

    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Hello, Asha'), findsOneWidget);
    expect(find.text('Latest Announcements'), findsOneWidget);
  });
}
