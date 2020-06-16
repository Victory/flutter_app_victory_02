import 'package:flutter/material.dart';
import 'package:flutterappvictory02/components/FullPageScaffold.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class RouteThree extends StatefulWidget {
  @override
  _RouteThreeState createState() => _RouteThreeState();
}

class _RouteThreeState extends State<RouteThree> {
  @override
  Widget build(BuildContext context) {
    print('because your worth it');

    return FullPageScaffold(
      child: FutureBuilder(
        future: Future.delayed(Duration(milliseconds: 2234), () {
          print('step on the gas');
          Provider.of<LoaderModel>(context, listen: false).stopLoading();
        }),
        builder: (context, snapshot) {
          print('step on the breaks');
          return Text('Route Three');
        },
      )
    );
  }
}
