import 'package:flutter/material.dart';
import 'package:international_phone_text_field/src/international_phone_text_field_theme.dart';

class WrongFlagContainer extends StatelessWidget {
  const WrongFlagContainer({
    super.key,
    this.theme = const InternationalPhoneTextFieldTheme(),
  });

  final InternationalPhoneTextFieldTheme theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 18,
      width: 34,
      decoration: BoxDecoration(
        color: theme.unknownFlagColor,
        borderRadius: BorderRadius.circular(3),
      ),
      alignment: Alignment.center,
      child: Text("?", style: theme.unknownFlagTextStyle),
    );
  }
}
