import 'package:equatable/equatable.dart';

class CountryCodes extends Equatable {
  final String country;
  final String countryRU;
  final String internalPhoneCode;
  final String countryCode;
  final String phoneMask;

  const CountryCodes({
    this.country = '',
    this.countryRU = '',
    this.internalPhoneCode = '',
    this.countryCode = '',
    this.phoneMask = '',
  });

  bool isNotEmpty() {
    return country.isNotEmpty &&
        countryRU.isNotEmpty &&
        internalPhoneCode.isNotEmpty &&
        countryCode.isNotEmpty &&
        phoneMask.isNotEmpty;
  }

  @override
  List<Object?> get props => [
        country,
        countryRU,
        internalPhoneCode,
        countryCode,
        phoneMask,
      ];
}
