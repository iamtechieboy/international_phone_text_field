<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

# International Phone Text Field 🌐

- This package provides a Flutter widget that can be used to input international phone numbers.

- It is highly customizable and can be used to input phone numbers in any format.

- It also provides a way to validate the phone number and return the country code and the phone
  number.

- It also comes with a build-in bottom sheet to select the country code.

### Roadmap for next version 
 -  Adding full support for dark and light theme
 -  Adding ability to fully customize the text field



# Follow and support me

| Telegram                                                                                                                                | LinkedIn                                                                                                                                                                                                                                        | Instaram                                                                                                                                                                                   |
 |-----------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [![Telegram](https://img.shields.io/badge/Telegram-2CA5E0?style=for-the-badge&logo=telegram&logoColor=white)](https://t.me/techiesBlog) | [![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/abduvohobov-isroiljon?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=ios_app) | [![Instagram](https://img.shields.io/badge/Instagram-E4405F?style=for-the-badge&logo=instagram&logoColor=white)](https://www.instagram.com/iamtechie_?igsh=MThldW03eGNkbWt4&utm_source=qr) |

## Features

![banner](https://github.com/iamtechieboy/international_phone_text_field/blob/master/assets/banner.png)

### There are two versions of the widget:

| One line version                                                                                      | Two line version                                                                                      |
|-------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------|
| ![verions1](https://github.com/iamtechieboy/international_phone_text_field/blob/master/assets/oneLine.gif) | ![verions1](https://github.com/iamtechieboy/international_phone_text_field/blob/master/assets/twoLine.gif) |

## Getting started

Add the package to your `pubspec.yaml` file.

```yaml
dependencies:
  international_phone_text_field: ^0.0.1+2
```

and run `flutter pub get` to install the package.

Import the package in your code.

```dart
import 'package:international_phone_text_field/international_phone_text_field.dart';
```

## Usage

To use this package, you need type the following code:

```dart
InternationalPhoneField(
  onChanged: (number) {
    print(number);
  },
)
```

✌️This is minimal code to use the package

## Additional information

If you encounter any issues feel free to open an issue. If you feel the package is missing a
feature, please raise a ticket on Github and I'll look into it. Pull request are also welcome.
