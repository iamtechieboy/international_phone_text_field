import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

MaskTextInputFormatter phoneFormatter({String? mask, String? initial}) =>
    MaskTextInputFormatter(
      mask: mask ?? '##-###-##-##',
      filter: {'#': RegExp(r'[+0-9]')},
      type: MaskAutoCompletionType.lazy,
      initialText: initial,
    );

String nonWidthSpace = String.fromCharCode(0x200B);
