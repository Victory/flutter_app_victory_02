import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

class SpinnerRoute extends StatelessWidget {
  /// Show the spinner and call the navigateCallback
  static navigateTo(BuildContext context, VoidCallback navigateCallback) {
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (BuildContext context) {
      return SpinnerRoute();
    }));
    navigateCallback();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: SpinKitPouringHourglass(color: Colors.blue),
      ),
    );
  }
}
