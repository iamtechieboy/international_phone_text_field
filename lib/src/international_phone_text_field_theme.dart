import 'package:flutter/material.dart';

/// Visual settings for the phone field and country selector.
/// Nullable phone field values fall back to the existing widget parameters.
class InternationalPhoneTextFieldTheme {
  const InternationalPhoneTextFieldTheme({
    this.phoneTextStyle,
    this.phoneHintStyle,
    this.phoneCursorColor,
    this.dividerColor,
    this.fieldBackgroundColor,
    this.focusedBorderColor = Colors.lightBlueAccent,
    this.unfocusedBorderColor = Colors.black12,
    this.countryTextStyle = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Colors.blue,
    ),
    this.unknownFlagColor = const Color(0xFFE0E0E0),
    this.unknownFlagTextStyle = const TextStyle(),
    this.sheetBackgroundColor = Colors.white,
    this.searchBackgroundColor = Colors.white24,
    this.searchBorderColor = const Color(0xFFE0E0E0),
    this.searchIconColor = const Color(0xFF9E9E9E),
    this.clearIconColor = const Color(0xFF9E9E9E),
    this.searchCursorColor,
    this.searchTextStyle = const TextStyle(color: Colors.black, fontSize: 16),
    this.searchHintStyle =
        const TextStyle(color: Color(0xFFBDBDBD), fontSize: 16),
    this.searchHint = 'Search',
    this.cancelLabel = 'Cancel',
    this.cancelTextStyle = const TextStyle(
      color: Colors.blue,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
    this.sheetCountryTextStyle = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),
    this.sheetDialCodeTextStyle = const TextStyle(
      fontSize: 16,
      color: Color(0xFF9E9E9E),
    ),
    this.sheetDividerColor = const Color(0xFFE0E0E0),
    this.sheetBarrierColor,
  });

  /// Defaults used when the surrounding Flutter theme is dark.
  const InternationalPhoneTextFieldTheme.dark({
    this.phoneTextStyle = const TextStyle(
        fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
    this.phoneHintStyle = const TextStyle(
        fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white54),
    this.phoneCursorColor = Colors.lightBlueAccent,
    this.dividerColor = Colors.white24,
    this.fieldBackgroundColor,
    this.focusedBorderColor = Colors.lightBlueAccent,
    this.unfocusedBorderColor = Colors.white24,
    this.countryTextStyle = const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.lightBlueAccent),
    this.unknownFlagColor = const Color(0xFF424242),
    this.unknownFlagTextStyle = const TextStyle(color: Colors.white),
    this.sheetBackgroundColor = const Color(0xFF121212),
    this.searchBackgroundColor = const Color(0xFF2A2A2A),
    this.searchBorderColor = Colors.white24,
    this.searchIconColor = Colors.white70,
    this.clearIconColor = Colors.white70,
    this.searchCursorColor = Colors.lightBlueAccent,
    this.searchTextStyle = const TextStyle(color: Colors.white, fontSize: 16),
    this.searchHintStyle = const TextStyle(color: Colors.white54, fontSize: 16),
    this.searchHint = 'Search',
    this.cancelLabel = 'Cancel',
    this.cancelTextStyle = const TextStyle(
        color: Colors.lightBlueAccent,
        fontSize: 14,
        fontWeight: FontWeight.w600),
    this.sheetCountryTextStyle = const TextStyle(
        fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
    this.sheetDialCodeTextStyle =
        const TextStyle(fontSize: 16, color: Colors.white70),
    this.sheetDividerColor = Colors.white24,
    this.sheetBarrierColor,
  });

  final TextStyle? phoneTextStyle;
  final TextStyle? phoneHintStyle;
  final Color? phoneCursorColor;
  final Color? dividerColor;

  /// Transparent by default, matching the original field.
  final Color? fieldBackgroundColor;
  final Color focusedBorderColor;
  final Color unfocusedBorderColor;
  final TextStyle countryTextStyle;
  final Color unknownFlagColor;
  final TextStyle unknownFlagTextStyle;
  final Color sheetBackgroundColor;
  final Color searchBackgroundColor;
  final Color searchBorderColor;
  final Color searchIconColor;
  final Color clearIconColor;
  final Color? searchCursorColor;
  final TextStyle searchTextStyle;
  final TextStyle searchHintStyle;
  final String searchHint;
  final String cancelLabel;
  final TextStyle cancelTextStyle;
  final TextStyle sheetCountryTextStyle;
  final TextStyle sheetDialCodeTextStyle;
  final Color sheetDividerColor;
  final Color? sheetBarrierColor;
}
