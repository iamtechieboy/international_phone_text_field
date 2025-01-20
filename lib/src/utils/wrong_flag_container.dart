import 'package:flutter/material.dart';

class WrongFlagContainer extends StatelessWidget {
  const WrongFlagContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 18,
      width: 34,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(3),
      ),
      alignment: Alignment.center,
      child: Text("?"),
    );
  }
}
