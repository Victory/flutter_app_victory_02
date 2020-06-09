import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterappvictory02/routes/RouteThree.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class LoaderModel with ChangeNotifier {
  var loadOpacity = 1.0;
  var contentOpacity = 0.0;

  void stopLoading() {
    loadOpacity = 0.0;
    contentOpacity = 1.0;
    notifyListeners();
  }

  void startLoading() {
    loadOpacity = 1.0;
    contentOpacity = 0.0;
    notifyListeners();
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() =>  _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays ([SystemUiOverlay.bottom]);

    return ChangeNotifierProvider(
      create: (_) => LoaderModel(),
      child: MaterialApp(
        home: RouteThree(),
        theme: ThemeData(
          brightness: Brightness.light,
          backgroundColor: Color.fromARGB(1, 33, 88, 88),
          primaryColor: Colors.yellow,
          accentColor: Colors.blueAccent,
        ),

        /*
        routes: {
          QuestionAndAnswerRoute.routeName: (context) => QuestionAndAnswerRoute.fromContext(context),
          AnswerReviewRoute.routeName: (context) => AnswerReviewRoute.fromContext(context),
        },
         */
      ),
    );
  }
}
