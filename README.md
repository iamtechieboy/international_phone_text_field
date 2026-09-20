# International Phone Text Field 🌐

Flutter widget for entering an international phone number. It formats the local
number with the selected country's mask and returns the dial code plus number
through `onChanged`. Users can choose a country from the built-in bottom sheet.
The widget offers one-line and two-line layouts and follows the app's light or
dark theme.



# Follow and support me

| Telegram                                                                                                                                | LinkedIn                                                                                                                                                                                                                                        |
 |-----------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [![Telegram](https://img.shields.io/badge/Telegram-2CA5E0?style=for-the-badge&logo=telegram&logoColor=white)](https://t.me/techiesBlog) | [![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/abduvohobov-isroiljon?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=ios_app)

## Features

![banner](https://raw.githubusercontent.com/iamtechieboy/international_phone_text_field/master/screenshots/banner.png)

### Two layouts

| One line version                                                                                      | Two line version                                                                                      |
|-------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------|
| ![One-line layout](https://raw.githubusercontent.com/iamtechieboy/international_phone_text_field/master/screenshots/oneLine.gif) | ![Two-line layout](https://raw.githubusercontent.com/iamtechieboy/international_phone_text_field/master/screenshots/twoLine.gif) |

## Getting started

The version in this repository's `pubspec.yaml` is `0.0.2`. Add the package to
your `pubspec.yaml` file:

```yaml
dependencies:
  international_phone_text_field: ^0.0.2
```

Run `flutter pub get`, then import the package:

```dart
import 'package:international_phone_text_field/international_phone_text_field.dart';
```

The theme API described below is currently marked **Unreleased** in this
repository's changelog. Use this source to try it before the next package
release.

## Usage

`onChanged` receives the dial code and unmasked local number as a single string.
The default country is Uzbekistan. Set `inOneLine: true` for the compact layout.

```dart
InternationalPhoneTextField(
  onChanged: (number) => print(number),
  onCountrySelected: (country) => print(country.countryCode),
)
```

The widget formats input; it does not validate whether a phone number is real
or complete.

## Customize the appearance

The widget follows `Theme.of(context).brightness` automatically. Light mode keeps
the original appearance; dark mode uses the built-in dark palette. To follow the
device setting, configure your app with `theme: ThemeData.light()`,
`darkTheme: ThemeData.dark()`, and `themeMode: ThemeMode.system`.

Use `theme` to change light mode and `darkTheme` to change dark mode. Use
`InternationalPhoneTextFieldTheme.dark(...)` for dark overrides so the other
dark defaults stay in place:

```dart
InternationalPhoneTextField(
  onChanged: (number) {},
  inOneLine: true,
  theme: const InternationalPhoneTextFieldTheme(
    countryTextStyle: TextStyle(color: Colors.indigo),
  ),
  darkTheme: const InternationalPhoneTextFieldTheme.dark(
    countryTextStyle: TextStyle(color: Colors.cyanAccent),
    sheetBackgroundColor: Color(0xFF0F172A),
  ),
)
```

`InternationalPhoneTextFieldTheme` also exposes field text, hint, cursor,
divider, border and background settings; country title and unknown-flag styles;
and bottom-sheet search, list, button, separator and barrier colors. The search
placeholder and cancel label are `searchHint` and `cancelLabel`.

The existing `style`, `hintStyle`, `cursorColor`, `dividerColor`, and `decoration`
parameters remain available. A value set in the active `theme` or `darkTheme`
takes precedence over its matching widget parameter. In one-line mode, a custom
`decoration` replaces the built-in field decoration.

## Additional information

If you encounter any issues feel free to open an issue. If you feel the package is missing a
feature, please raise a ticket on Github and I'll look into it. Pull request are also welcome.
