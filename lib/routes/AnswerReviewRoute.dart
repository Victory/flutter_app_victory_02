import 'package:flutter/material.dart';
import 'package:flutterappvictory02/model/Answered.dart';
import 'package:flutterappvictory02/model/MockDb.dart';

import 'SpinnerRoute.dart';

class AnswerReviewRoute extends StatefulWidget {
  static const routeName = '/answerreviewroute';

  final List<Answered> _answered;

  AnswerReviewRoute(this._answered);

  static AnswerReviewRoute fromContext(BuildContext context) {
    List<Answered> answered = ModalRoute.of(context).settings.arguments;
    return AnswerReviewRoute(answered);
  }

  static void navigateTo(BuildContext context) {
    SpinnerRoute.navigateTo(context, () {
      db.getAllAnswered().then((answered) {
        Navigator.of(context).pushReplacementNamed(
          AnswerReviewRoute.routeName,
          arguments: answered,
        );
      });
    });
  }

  @override
  State<StatefulWidget> createState() {
    return AnswerReviewWidget(_answered);
  }
}

class AnswerReviewWidget extends State<AnswerReviewRoute> {
  final List<Answered> _answered;

  AnswerReviewWidget(this._answered);

  @override
  Widget build(BuildContext context) {
    final items = _answered
        .map(
          (a) => Container(
            padding: EdgeInsets.all(8.0),
            child: Card(
              elevation: 15,
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(a.questionLabel),
                      subtitle: Text(a.answerLabel),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
        .toList();

    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pushReplacementNamed('/');
        return Future.value(false);
      },
      child: SafeArea(
        child: Scaffold(
          body: CustomScrollView(slivers: [
            const SliverAppBar(
              title: Text("Sometimes we can't mean what we say"),
            ),
            SliverList(
              delegate: SliverChildListDelegate.fixed(items),
            ),
            // ...items,
          ]),
        ),
      ),
    );
  }
}
