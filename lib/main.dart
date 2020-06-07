import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterappvictory02/routes/WelcomeRoute.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays ([SystemUiOverlay.bottom]);

    return MaterialApp(
      title: 'Welcome.',
      home: WelcomeRoute(),
      theme: ThemeData(
        backgroundColor: Color.fromARGB(1, 33, 88, 88),
        primaryColor: Colors.yellow,
        accentColor: Colors.amberAccent,
      ),
      /*
      routes: {
        QuestionAndAnswerRoute.routeName: (context) => QuestionAndAnswerRoute.fromContext(context),
        AnswerReviewRoute.routeName: (context) => AnswerReviewRoute.fromContext(context),
      },
       */
    );
  }
}
