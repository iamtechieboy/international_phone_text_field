import 'package:flutter/material.dart';
import 'package:international_phone_text_field/src/controller/phone_controller_bloc.dart';
import 'package:international_phone_text_field/src/utils/wrong_flag_container.dart';

class CountryTitle extends StatelessWidget {
  CountryTitle({
    super.key,
    required this.state,
    this.style = const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
    required this.notFoundCountryMessage,
    this.countryTextStyle,
  });

  final PhoneControllerState state;
  final TextStyle style;
  final TextStyle? countryTextStyle;
  final String notFoundCountryMessage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16),
      child: AnimatedCrossFade(
        firstChild: Row(
          children: [
            if (state.selectedCountryCode.countryCode.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(3),
                child: Image.asset(
                  'assets/flag/${state.selectedCountryCode.countryCode}.png',
                  height: 19,
                  fit: BoxFit.fitHeight,
                  errorBuilder: (context, error, stackTrace) => WrongFlagContainer(),
                  package: "international_phone_text_field",
                ),
              )
          ],
        ),
        secondChild: WrongFlagContainer(),
        crossFadeState: state.selectedCountryCode.isNotEmpty() ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        duration: Duration(milliseconds: 400),
      ),
    );
  }
}
