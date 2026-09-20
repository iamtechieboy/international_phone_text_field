import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:international_phone_text_field/src/controller/phone_controller_bloc.dart';
import 'package:international_phone_text_field/src/entity/country_code_entity.dart';
import 'package:international_phone_text_field/src/international_phone_text_field_theme.dart';
import 'package:international_phone_text_field/src/utils/bottomsheet.dart';
import 'package:international_phone_text_field/src/utils/code_part_widget.dart';
import 'package:international_phone_text_field/src/utils/country_title_widget.dart';
import 'package:international_phone_text_field/src/utils/format_util.dart';

class InternationalPhoneTextField extends StatefulWidget {
  /// Divider color between code and phone number
  /// Default is Colors.black12
  final Color? dividerColor;

  /// Cursor color of the phone number field
  /// Default is Colors.black
  final Color? cursorColor;

  /// Not found country message to show when country is not selected
  /// Default is "Country"
  final String notFoundCountryMessage;

  /// Not found number message to show when phone number is not selected
  /// Default is "Your phone number"
  final String notFoundNumberMessage;

  /// Auto focus for the phone number field
  /// Default is false
  final bool autoFocus;

  /// Text style for the phone number field
  /// Default is TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black)
  final TextStyle? style;

  /// Hint text style for the phone number field
  /// Default is TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black26)
  final TextStyle? hintStyle;

  /// On change callback for the phone number field
  /// Required
  /// It will return the full phone number with country code
  final Function(String number) onChanged;

  /// On country selected callback
  /// It will return the selected country code
  final Function(CountryCodes selectedCountryCode)? onCountrySelected;

  /// There is two type of view for the phone number field
  /// If inOneLine is true, it will show in one line phone number field
  /// If inOneLine is false, it will show in two lines phone number field
  /// Default is false
  final bool inOneLine;

  /// Decoration for the phone number field
  final BoxDecoration? decoration;

  /// Visual settings for light mode. Defaults match the original appearance.
  final InternationalPhoneTextFieldTheme? theme;

  /// Visual settings for dark mode. Defaults to the built-in dark palette.
  final InternationalPhoneTextFieldTheme? darkTheme;

  InternationalPhoneTextField({
    Key? key,
    this.autoFocus = false,
    this.style,
    this.hintStyle,
    required this.onChanged,
    this.onCountrySelected,
    this.cursorColor,
    this.notFoundCountryMessage = "Country",
    this.notFoundNumberMessage = "Your phone number",
    this.dividerColor,
    this.inOneLine = false,
    this.decoration,
    this.theme,
    this.darkTheme,
  }) : super(key: key);

  @override
  State<InternationalPhoneTextField> createState() =>
      _InternationalPhoneTextFieldState();
}

class _InternationalPhoneTextFieldState
    extends State<InternationalPhoneTextField> {
  final TextEditingController phoneController =
      TextEditingController(text: nonWidthSpace);
  final TextEditingController codeController = TextEditingController();
  final _phoneFocusNode = FocusNode();
  final _codeFocusNode = FocusNode();
  List<TextInputFormatter> formatter = [];
  late final PhoneControllerBloc controllerBloc;

  @override
  void initState() {
    super.initState();
    _phoneFocusNode.addListener(_onFocusChanged);
    _codeFocusNode.addListener(_onFocusChanged);
    codeController.text = "998";
    controllerBloc = PhoneControllerBloc()..add(LoadCountryCodesEvent());
  }

  void _onFocusChanged() => setState(() {});

  InternationalPhoneTextFieldTheme _effectiveTheme(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? widget.darkTheme ?? const InternationalPhoneTextFieldTheme.dark()
          : widget.theme ?? const InternationalPhoneTextFieldTheme();

  @override
  Widget build(BuildContext context) {
    final theme = _effectiveTheme(context);
    final explicitTheme = Theme.of(context).brightness == Brightness.dark
        ? widget.darkTheme
        : widget.theme;
    final phoneStyle = explicitTheme?.phoneTextStyle ??
        widget.style ??
        theme.phoneTextStyle ??
        const TextStyle(
            fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black);
    final hintStyle = explicitTheme?.phoneHintStyle ??
        widget.hintStyle ??
        theme.phoneHintStyle ??
        const TextStyle(
            fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black26);
    final cursorColor = explicitTheme?.phoneCursorColor ??
        widget.cursorColor ??
        theme.phoneCursorColor ??
        Colors.black;
    final dividerColor = explicitTheme?.dividerColor ??
        widget.dividerColor ??
        theme.dividerColor ??
        Colors.black12;
    return BlocProvider.value(
      value: controllerBloc,
      child: BlocConsumer<PhoneControllerBloc, PhoneControllerState>(
        listener: (context, state) {
          /// change state for phone code finder
          if (state.findStatus.isSuccess) {
            if (state.selectedCountryCode.isNotEmpty()) {
              phoneController.text = nonWidthSpace;
              _phoneFocusNode.requestFocus();
              codeController.text = state.selectedCountryCode.internalPhoneCode;
              if (widget.onCountrySelected != null) {
                widget.onCountrySelected!(state.selectedCountryCode);
              }
            }
          }

          /// change state for country selection
          if (state.selectionStatus.isSuccess) {
            codeController.text = state.selectedCountryCode.internalPhoneCode;
            phoneController.text = nonWidthSpace;
            _phoneFocusNode.requestFocus();
            if (widget.onCountrySelected != null) {
              widget.onCountrySelected!(state.selectedCountryCode);
            }
          }

          /// Clear cached formatter
          if (state.selectedCountryCode.isNotEmpty()) {
            if (state.selectedCountryCode.isNotEmpty()) {
              formatter = [
                LengthLimitingTextInputFormatter(
                    state.selectedCountryCode.phoneMask.length),
                phoneFormatter(mask: state.selectedCountryCode.phoneMask),
              ];
            }
          } else {
            formatter = [];
          }
        },
        builder: (_, state) {
          return Container(
            decoration: widget.inOneLine
                ? widget.decoration ??
                    BoxDecoration(
                      color: theme.fieldBackgroundColor,
                      border: Border.all(
                        color: (_phoneFocusNode.hasFocus ||
                                _codeFocusNode.hasFocus)
                            ? theme.focusedBorderColor
                            : theme.unfocusedBorderColor,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    )
                : theme.fieldBackgroundColor == null
                    ? null
                    : BoxDecoration(color: theme.fieldBackgroundColor),
            child: Column(
              children: [
                /// If inOneLine is true, show only phone field
                if (!widget.inOneLine) ...[
                  CountryTitle(
                    state: state,
                    theme: theme,
                    notFoundCountryMessage: widget.notFoundCountryMessage,
                    inOneLine: widget.inOneLine,
                    onTap: () => showCountryList(controllerBloc),
                  ),
                  SizedBox(height: 12),
                  Divider(
                    color: dividerColor,
                    height: 0,
                  )
                ],
                Row(
                  children: [
                    if (widget.inOneLine) ...[
                      CountryTitle(
                        state: state,
                        theme: theme,
                        notFoundCountryMessage: widget.notFoundCountryMessage,
                        inOneLine: widget.inOneLine,
                        onTap: () => showCountryList(controllerBloc),
                      ),
                    ],
                    CodePartWidget(
                      codeController: codeController,
                      codeFocusNode: _codeFocusNode,
                      controllerBloc: controllerBloc,
                      style: phoneStyle,
                      cursorColor: cursorColor,
                    ),
                    Container(
                      width: 1,
                      margin: EdgeInsets.symmetric(horizontal: 12),
                      height: 30,
                      color: dividerColor,
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.phone,
                            controller: phoneController,
                            focusNode: _phoneFocusNode,
                            maxLines: 1,
                            maxLength: 20,
                            autofocus: true,
                            inputFormatters: formatter,
                            style: phoneStyle,
                            cursorColor: cursorColor,
                            decoration: InputDecoration(
                              counterText: "",
                              border: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                            ),
                            onChanged: (String text) {
                              if (text.isEmpty) {
                                _codeFocusNode.requestFocus();
                              } else if (!state.selectedCountryCode
                                  .isNotEmpty()) {
                                controllerBloc.add(FindCountryCode(code: text));
                              } else {
                                controllerBloc
                                    .add(AdditionalFinder(code: text));
                              }

                              var actualText = phoneFormatter(
                                      mask: state.selectedCountryCode.phoneMask)
                                  .unmaskText(
                                      text.replaceAll(nonWidthSpace, ""));
                              widget.onChanged(
                                  "+${state.selectedCountryCode.internalPhoneCode}${actualText}");
                            },
                            onTap: () {
                              if (phoneController.text.isEmpty) {
                                phoneController.text = nonWidthSpace;
                              }
                            },
                          ),

                          /// This is a hint text field to show the mask of the phone number
                          IgnorePointer(
                            child: ValueListenableBuilder(
                              valueListenable: phoneController,
                              builder: (_, value, child) {
                                final hintController = TextEditingController();
                                if (state.selectedCountryCode.isNotEmpty()) {
                                  var phoneLength = value.text
                                      .replaceAll(nonWidthSpace, "")
                                      .length;
                                  var actualText = phoneFormatter(
                                          mask: state
                                              .selectedCountryCode.phoneMask)
                                      .unmaskText(value.text
                                          .replaceAll(nonWidthSpace, ""));
                                  String maskFull = List.generate(
                                          state.selectedCountryCode.phoneMask
                                                  .length -
                                              phoneLength,
                                          (index) => "0")
                                      .toString()
                                      .replaceAll("[", "")
                                      .replaceAll("]", "")
                                      .replaceAll(",", "")
                                      .replaceAll(" ", "");

                                  final actualMaskText = actualText + maskFull;

                                  var finalMaskText = phoneFormatter(
                                          mask: state
                                              .selectedCountryCode.phoneMask)
                                      .maskText(
                                    actualMaskText,
                                  );
                                  hintController.text = finalMaskText;
                                } else if (value.text
                                    .replaceAll(nonWidthSpace, "")
                                    .isNotEmpty) {
                                  hintController.text = value.text;
                                }
                                return TextField(
                                  style: hintStyle,
                                  controller: hintController,
                                  decoration: InputDecoration(
                                    enabled: false,
                                    counterText: "",
                                    hintText: widget.notFoundNumberMessage,
                                    hintStyle: hintStyle,
                                    border: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  dispose() {
    _phoneFocusNode.removeListener(_onFocusChanged);
    _codeFocusNode.removeListener(_onFocusChanged);
    phoneController.dispose();
    codeController.dispose();
    _phoneFocusNode.dispose();
    _codeFocusNode.dispose();
    controllerBloc.close();
    super.dispose();
  }

  void showCountryList(PhoneControllerBloc bloc) async {
    final theme = _effectiveTheme(context);
    return await showModalBottomSheet(
      barrierColor: theme.sheetBarrierColor,
      isDismissible: true,
      enableDrag: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        final sheetTheme = Theme.of(ctx).brightness == Brightness.dark
            ? widget.darkTheme ?? const InternationalPhoneTextFieldTheme.dark()
            : widget.theme ?? const InternationalPhoneTextFieldTheme();
        return ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          child: BlocProvider.value(
            value: bloc,
            child: CountriesBottomSheet(theme: sheetTheme),
          ),
        );
      },
    );
  }
}
