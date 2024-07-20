import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:international_phone_text_field/src/entity/country_code_entity.dart';
import 'package:international_phone_text_field/src/utils/country_phone_codes.dart';
import 'package:international_phone_text_field/src/utils/format_util.dart';

part 'phone_controller_event.dart';

part 'phone_controller_state.dart';

class PhoneControllerBloc
    extends Bloc<PhoneControllerEvent, PhoneControllerState> {
  PhoneControllerBloc() : super(PhoneControllerState()) {
    on<LoadCountryCodesEvent>(
      (event, emit) {
        List<CountryCodes> countryCodes = countryPhoneCodes
            .map((e) => CountryCodes(
                  country: e['country'],
                  countryRU: e['countryRU'],
                  internalPhoneCode: e['internalPhoneCode'],
                  countryCode: e['countryCode'],
                  phoneMask: e['phoneMask'],
                ))
            .toList();
        emit(
          state.copyWith(
            countryCodes: countryCodes,
            searchedCountryCodes: countryCodes,
            selectedCountryCode: CountryCodes(
              country: 'Uzbekistan',
              countryCode: 'UZ',
              internalPhoneCode: '998',
              countryRU: "Узбекистан",
              phoneMask: "## ### ## ##",
            ),
          ),
        );
      },
    );
    on<SelectCountryCodeEvent>(
      (event, emit) {
        emit(
          state.copyWith(
            selectedCountryCode: event.selectedCountryCode,
            selectionStatus: FormzSubmissionStatus.success,
          ),
        );
        emit(state.copyWith(selectionStatus: FormzSubmissionStatus.initial));
      },
    );
    on<SearchCountryCodesEvent>((event, emit) {
      if (event.searchQuery.isEmpty) {
        emit(state.copyWith(searchedCountryCodes: state.countryCodes));
        return;
      } else {
        List<CountryCodes> searchedCountryCodes = state.countryCodes
            .where((element) => element.country
                .toLowerCase()
                .contains(event.searchQuery.toLowerCase()))
            .toList();
        emit(state.copyWith(searchedCountryCodes: searchedCountryCodes));
      }
    });
    on<FindCountryCode>((event, emit) {
      final code = event.code.replaceAll(nonWidthSpace, "").trim();
      final CountryCodes country = state.countryCodes.firstWhere(
        (element) => code == element.internalPhoneCode,
        orElse: () => CountryCodes(),
      );
      emit(
        state.copyWith(
          selectedCountryCode: country,
          findStatus: FormzSubmissionStatus.success,
        ),
      );
      emit(state.copyWith(findStatus: FormzSubmissionStatus.initial));
    });

    /// This additional finder is for the case when there will be another country
    /// after matching country code above.
    on<AdditionalFinder>((event, emit) {
      final code = event.code.replaceAll(nonWidthSpace, "").trim();
      final finalCode = state.selectedCountryCode.internalPhoneCode + code;
      final CountryCodes country = state.countryCodes.firstWhere(
        (element) => finalCode == element.internalPhoneCode,
        orElse: () => CountryCodes(),
      );
      if (country.isNotEmpty()) {
        emit(
          state.copyWith(
            selectedCountryCode: country,
            findStatus: FormzSubmissionStatus.success,
          ),
        );
        emit(state.copyWith(findStatus: FormzSubmissionStatus.initial));
      }
    });
  }
}
