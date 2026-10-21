import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:polylingua_plus/intro_screen.dart';

void main() {
  testWidgets('navigates after animation', (tester) async {
    var calls = 0;
    await tester.pumpWidget(MaterialApp(
      home: IntroScreen(onFinished: (_) => calls++),
    ));
    await tester.pump(const Duration(milliseconds: 2600));
    expect(calls, 1);
  });

  testWidgets('tap skips once', (tester) async {
    var calls = 0;
    await tester.pumpWidget(MaterialApp(
      home: IntroScreen(onFinished: (_) => calls++),
    ));
    await tester.tap(find.byType(IntroScreen));
    await tester.pump(const Duration(milliseconds: 2600));
    expect(calls, 1);
  });
}
