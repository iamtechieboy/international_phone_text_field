import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:international_phone_text_field/international_phone_text_field.dart';

void main() {
  testWidgets('custom theme reaches the field and country selector',
      (tester) async {
    const theme = InternationalPhoneTextFieldTheme(
      fieldBackgroundColor: Color(0xFF102030),
      focusedBorderColor: Color(0xFF708090),
      unfocusedBorderColor: Color(0xFF203040),
      phoneTextStyle: TextStyle(color: Color(0xFFABCDEF)),
      phoneCursorColor: Color(0xFF123456),
      countryTextStyle: TextStyle(color: Color(0xFF654321)),
      sheetBackgroundColor: Color(0xFF304050),
      searchIconColor: Color(0xFF405060),
      cancelTextStyle: TextStyle(color: Color(0xFF506070)),
      cancelLabel: 'Close',
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: InternationalPhoneTextField(
            onChanged: (_) {},
            inOneLine: true,
            theme: theme,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final field = tester.widget<TextField>(
      find.descendant(
        of: find.byType(TextFormField).last,
        matching: find.byType(TextField),
      ),
    );
    expect(field.style?.color, const Color(0xFFABCDEF));
    expect(field.cursorColor, const Color(0xFF123456));
    final decoratedField = tester.widget<Container>(
      find.byWidgetPredicate(
        (widget) =>
            widget is Container &&
            widget.decoration is BoxDecoration &&
            (widget.decoration! as BoxDecoration).color ==
                const Color(0xFF102030),
      ),
    );
    final decoration = decoratedField.decoration! as BoxDecoration;
    expect((decoration.border! as Border).top.color, const Color(0xFF708090));

    await tester.tap(find.byType(AnimatedCrossFade));
    await tester.pumpAndSettle();

    expect(find.text('Close'), findsOneWidget);
    expect(
      tester.widget<Text>(find.text('Close')).style?.color,
      const Color(0xFF506070),
    );
    expect(tester.widget<Icon>(find.byIcon(Icons.search)).color,
        const Color(0xFF405060));
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is ColoredBox && widget.color == const Color(0xFF304050),
      ),
      findsOneWidget,
    );
  });

  testWidgets('default country title keeps the original blue text',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: InternationalPhoneTextField(onChanged: (_) {}),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(
        tester.widget<Text>(find.text('Uzbekistan')).style?.color, Colors.blue);
  });

  testWidgets('follows light and dark app themes automatically',
      (tester) async {
    Future<void> showMode(ThemeMode mode) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: mode,
          home: Scaffold(
            body: InternationalPhoneTextField(
              onChanged: (_) {},
              inOneLine: true,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
    }

    TextField phoneField() => tester.widget<TextField>(
          find.descendant(
            of: find.byType(TextFormField).last,
            matching: find.byType(TextField),
          ),
        );

    await showMode(ThemeMode.light);
    expect(phoneField().style?.color, Colors.black);
    expect(phoneField().cursorColor, Colors.black);

    await tester.tap(find.byType(AnimatedCrossFade));
    await tester.pumpAndSettle();
    expect(
      find.byWidgetPredicate(
        (widget) => widget is ColoredBox && widget.color == Colors.white,
      ),
      findsOneWidget,
    );

    await showMode(ThemeMode.dark);
    expect(phoneField().style?.color, Colors.white);
    expect(phoneField().cursorColor, Colors.lightBlueAccent);
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is ColoredBox && widget.color == const Color(0xFF121212),
      ),
      findsOneWidget,
    );
  });

  testWidgets('explicit darkTheme overrides automatic colors', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData.dark(),
        home: Scaffold(
          body: InternationalPhoneTextField(
            onChanged: (_) {},
            style: const TextStyle(color: Colors.red),
            darkTheme: const InternationalPhoneTextFieldTheme.dark(
              phoneTextStyle: TextStyle(color: Colors.green),
              sheetBackgroundColor: Color(0xFF234567),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final field = tester.widget<TextField>(
      find.descendant(
        of: find.byType(TextFormField).last,
        matching: find.byType(TextField),
      ),
    );
    expect(field.style?.color, Colors.green);

    await tester.tap(find.text('Uzbekistan'));
    await tester.pumpAndSettle();
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is ColoredBox && widget.color == const Color(0xFF234567),
      ),
      findsOneWidget,
    );
  });

  testWidgets('existing style parameter still overrides automatic dark default',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData.dark(),
        home: Scaffold(
          body: InternationalPhoneTextField(
            onChanged: (_) {},
            style: const TextStyle(color: Colors.green),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final field = tester.widget<TextField>(
      find.descendant(
        of: find.byType(TextFormField).last,
        matching: find.byType(TextField),
      ),
    );
    expect(field.style?.color, Colors.green);
  });
}
