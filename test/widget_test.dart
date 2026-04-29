import 'package:flutter_test/flutter_test.dart';
import 'package:udsm_connected_intelligent_system/main.dart';

void main() {
  testWidgets('staff can choose staff login and open the staff dashboard', (tester) async {
    await tester.pumpWidget(const UcisAdminApp());

    expect(find.text('UDSM MOBILE\nAPPLICATION'), findsOneWidget);
    expect(find.text('Login as Staff'), findsOneWidget);
    expect(find.text('Login as Student'), findsOneWidget);

    await tester.tap(find.text('Login as Staff'));
    await tester.pumpAndSettle();

    expect(find.text('Staff Login'), findsOneWidget);

    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Dr. James Kalolo'), findsOneWidget);
    expect(find.text('Quick Access'), findsOneWidget);
    expect(find.text('My Tasks'), findsOneWidget);

    await tester.tap(find.text('Logout'));
    await tester.pumpAndSettle();

    expect(find.text('Login as Staff'), findsOneWidget);
  });
}
