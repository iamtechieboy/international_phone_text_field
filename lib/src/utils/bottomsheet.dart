import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:international_phone_text_field/src/controller/phone_controller_bloc.dart';
import 'package:international_phone_text_field/src/entity/country_code_entity.dart';

class CountriesBottomSheet extends StatefulWidget {
  const CountriesBottomSheet({
    super.key,
    required this.searchText,
    required this.title, required this.cancel,
  });

  final String searchText;
  final String title;
  final String cancel;

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
            maxChildSize: .93,
            initialChildSize: .93,
            minChildSize: .5,
            expand: false,
            builder: (BuildContext context, ScrollController scrollController) {
              return ColoredBox(
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(
                      height: 56,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: SvgPicture.asset(
                                  'assets/icons/newUI/18/chevron_left18.svg',
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              widget.title,
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 48,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16).copyWith(right: 0),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.onPrimary,
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(color: Theme.of(context).primaryColor, width: 3),
                            ),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/newUI/16/search16.svg',
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    child: TextFormField(
                                      controller: controller,
                                      autofocus: true,
                                      onChanged: (String text) {
                                        context.read<PhoneControllerBloc>().add(SearchCountryCodesEvent(text));
                                      },
                                      style: Theme.of(context).textTheme.headlineSmall,
                                      decoration: InputDecoration(
                                        hintText: widget.searchText,
                                        hintStyle: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                              color: Colors.grey.shade500,
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
                                          context.read<PhoneControllerBloc>().add(SearchCountryCodesEvent(''));
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
                            context.read<PhoneControllerBloc>().add(SearchCountryCodesEvent(''));
                            Navigator.pop(context);
                          },
                          behavior: HitTestBehavior.opaque,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              widget.cancel,
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
                    Divider(thickness: 2),
                    Expanded(
                      child: ListView.separated(
                        controller: scrollController,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          CountryCodes? country = state.searchedCountryCodes[index];
                          return GestureDetector(
                            onTap: () {
                              context.read<PhoneControllerBloc>().add(SelectCountryCodeEvent(country));
                              Navigator.pop(context);
                              controller.clear();
                              context.read<PhoneControllerBloc>().add(SearchCountryCodesEvent(''));
                            },
                            behavior: HitTestBehavior.opaque,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              child: Row(
                                children: [
                                  Container(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(3),
                                      child: Image.asset(
                                        'assets/flag/${country.countryCode}.png',
                                        height: 20,
                                        width: 28,
                                        fit: BoxFit.contain,
                                        package: "international_phone_text_field",
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      country.country,
                                      style: Theme.of(context).textTheme.headlineSmall!,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    "+${country.internalPhoneCode}",
                                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                          color: Theme.of(context).colorScheme.secondary,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider(thickness: 2);
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
