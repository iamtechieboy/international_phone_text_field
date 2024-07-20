import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:international_phone_text_field/src/controller/phone_controller_bloc.dart';
import 'package:international_phone_text_field/src/entity/country_code_entity.dart';

class CountriesBottomSheet extends StatefulWidget {
  const CountriesBottomSheet({
    super.key,
  });

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
          child: DraggableScrollableSheet(
            maxChildSize: .95,
            initialChildSize: .95,
            minChildSize: .5,
            expand: false,
            builder: (BuildContext context, ScrollController scrollController) {
              return ColoredBox(
                color: Colors.white,
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
                              color: Colors.white24,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.search,
                                  color: Colors.grey.shade500,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: TextFormField(
                                      controller: controller,
                                      autofocus: true,
                                      onChanged: (String text) {
                                        context
                                            .read<PhoneControllerBloc>()
                                            .add(SearchCountryCodesEvent(text));
                                      },
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: "Search",
                                        hintStyle: TextStyle(
                                          color: Colors.grey.shade400,
                                          fontSize: 16,
                                        ),
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
                                          color: Colors.grey.shade500,
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
                              'Cancel',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
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
                                        'assets/flags/${country.countryCode.toLowerCase()}.png',
                                        height: 20,
                                        width: 38,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text.rich(
                                      TextSpan(
                                        text: country.country,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    "+${country.internalPhoneCode}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey.shade500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider(
                            indent: 10,
                            color: Colors.grey.shade300,
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
