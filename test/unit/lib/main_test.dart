import 'package:eitangocho/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('main widget is rendered', (widgetTester) async {
    await widgetTester.pumpWidget(const MainApp());
  });
}
