import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:international_phone_text_field/src/controller/phone_controller_bloc.dart';
import 'package:international_phone_text_field/src/entity/country_code_entity.dart';
import 'package:international_phone_text_field/src/international_phone_text_field_theme.dart';
import 'package:international_phone_text_field/src/utils/wrong_flag_container.dart';

class CountriesBottomSheet extends StatefulWidget {
  const CountriesBottomSheet({
    super.key,
    this.theme = const InternationalPhoneTextFieldTheme(),
  });

  final InternationalPhoneTextFieldTheme theme;

  @override
  State<CountriesBottomSheet> createState() => _CountriesBottomSheetState();
}

class _CountriesBottomSheetState extends State<CountriesBottomSheet> {
  late TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhoneControllerBloc, PhoneControllerState>(
      builder: (_, state) {
        return Material(
          color: widget.theme.sheetBackgroundColor,
          child: DraggableScrollableSheet(
            maxChildSize: .90,
            initialChildSize: .90,
            minChildSize: .5,
            expand: false,
            builder: (BuildContext context, ScrollController scrollController) {
              return ColoredBox(
                color: widget.theme.sheetBackgroundColor,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 44,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            margin: const EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 16)
                                .copyWith(right: 0),
                            decoration: BoxDecoration(
                              color: widget.theme.searchBackgroundColor,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: widget.theme.searchBorderColor,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.search,
                                  color: widget.theme.searchIconColor,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: TextFormField(
                                      controller: controller,
                                      autofocus: true,
                                      cursorColor:
                                          widget.theme.searchCursorColor,
                                      onChanged: (String text) {
                                        context
                                            .read<PhoneControllerBloc>()
                                            .add(SearchCountryCodesEvent(text));
                                      },
                                      style: widget.theme.searchTextStyle,
                                      decoration: InputDecoration(
                                        hintText: widget.theme.searchHint,
                                        hintStyle: widget.theme.searchHintStyle,
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                                ValueListenableBuilder(
                                  valueListenable: controller,
                                  builder: (_, value, child) {
                                    if (value.text.isNotEmpty) {
                                      return GestureDetector(
                                        onTap: () {
                                          controller.clear();
                                          context
                                              .read<PhoneControllerBloc>()
                                              .add(SearchCountryCodesEvent(''));
                                        },
                                        child: Icon(
                                          Icons.clear,
                                          color: widget.theme.clearIconColor,
                                        ),
                                      );
                                    } else {
                                      return const SizedBox.shrink();
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.clear();
                            context
                                .read<PhoneControllerBloc>()
                                .add(SearchCountryCodesEvent(''));
                            Navigator.pop(context);
                          },
                          behavior: HitTestBehavior.opaque,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              widget.theme.cancelLabel,
                              style: widget.theme.cancelTextStyle,
                            ),
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: ListView.separated(
                        controller: scrollController,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          CountryCodes? country =
                              state.searchedCountryCodes[index];
                          return GestureDetector(
                            onTap: () {
                              context
                                  .read<PhoneControllerBloc>()
                                  .add(SelectCountryCodeEvent(country));
                              Navigator.pop(context);
                              controller.clear();
                              context
                                  .read<PhoneControllerBloc>()
                                  .add(SearchCountryCodesEvent(''));
                            },
                            behavior: HitTestBehavior.opaque,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: Row(
                                children: [
                                  Container(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(3),
                                      child: Image.asset(
                                        'assets/flag/${country.countryCode}.png',
                                        height: 18,
                                        width: 34,
                                        fit: BoxFit.contain,
                                        package: "international_phone_text_field",
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                WrongFlagContainer(
                                                    theme: widget.theme),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text.rich(
                                      TextSpan(
                                        text: country.country,
                                        style:
                                            widget.theme.sheetCountryTextStyle,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    "+${country.internalPhoneCode}",
                                    style: widget.theme.sheetDialCodeTextStyle,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider(
                            indent: 10,
                            color: widget.theme.sheetDividerColor,
                          );
                        },
                        itemCount: state.searchedCountryCodes.length,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
