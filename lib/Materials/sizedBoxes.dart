import 'package:flutter/material.dart';

class SizedBoxes {
  Widget verticalSizedBox({double verticalSize = 10}) {
    return SizedBox(
      height: verticalSize,
    );
  }

  Widget horizontalSizedBox({double horizontalSize = 10}) {
    return SizedBox(
      width: horizontalSize,
    );
  }
}
