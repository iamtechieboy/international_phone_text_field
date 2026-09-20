part of 'phone_controller_bloc.dart';

class PhoneControllerState extends Equatable {
  final List<CountryCodes> countryCodes;
  final List<CountryCodes> searchedCountryCodes;
  final CountryCodes selectedCountryCode;
  final FormzSubmissionStatus selectionStatus;
  final FormzSubmissionStatus findStatus;

  PhoneControllerState({
    this.countryCodes = const [],
    this.searchedCountryCodes = const [],
    this.selectedCountryCode = const CountryCodes(),
    this.selectionStatus = FormzSubmissionStatus.initial,
    this.findStatus = FormzSubmissionStatus.initial,
  });

  PhoneControllerState copyWith({
    List<CountryCodes>? countryCodes,
    List<CountryCodes>? searchedCountryCodes,
    CountryCodes? selectedCountryCode,
    FormzSubmissionStatus? selectionStatus,
    FormzSubmissionStatus? findStatus,
  }) {
    return PhoneControllerState(
      countryCodes: countryCodes ?? this.countryCodes,
      searchedCountryCodes: searchedCountryCodes ?? this.searchedCountryCodes,
      selectedCountryCode: selectedCountryCode ?? this.selectedCountryCode,
      selectionStatus: selectionStatus ?? this.selectionStatus,
      findStatus: findStatus ?? this.findStatus,
    );
  }

  @override
  List<Object?> get props => [
        countryCodes,
        searchedCountryCodes,
        selectedCountryCode,
        selectionStatus,
        findStatus,
      ];
}
