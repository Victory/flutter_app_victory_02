import 'package:flutter/material.dart';
import 'package:flutterappvictory02/model/AnswerOption.dart';

import 'model/MockDb.dart';
import 'model/Question.dart';

class QuestionAndAnswerWidget extends StatefulWidget {
  static const routeName = '/qanda';

  final Question _q;

  QuestionAndAnswerWidget(this._q);

  static fromContext(BuildContext context) {
    Question q = ModalRoute.of(context).settings.arguments;
    return QuestionAndAnswerWidget(q);
  }

  static navigateTo(BuildContext context) {
    Db().getAllQuestions().then((questions) {
      Navigator.of(context).pushNamed(QuestionAndAnswerWidget.routeName, arguments: questions[0]);
    });
  }

  @override
  State<StatefulWidget> createState() {
    return new QuestionState(_q);
  }
}

class QuestionState extends State<QuestionAndAnswerWidget> {
  final Question _q;

  AnswerOption _sofias_anwser;

  QuestionState(this._q);

  @override
  Widget build(BuildContext context) {
    var answerWidgets = _q.possibleAnswers.map((ans) {
      return RadioListTile(
        title: Padding(
          padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
          child: Text(ans.label),
        ),
        value: ans,
        groupValue: _sofias_anwser,
        onChanged: (opt) {
          setState(() {
            _sofias_anwser = opt;
          });
        },
      );
    }).toList();

    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            const SliverAppBar(
              title: Text('There are Choices in Life'),
            ),
            SliverList(
              delegate: SliverChildListDelegate.fixed(
                [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        _q.question,
                        textScaleFactor: 1.8,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate.fixed(answerWidgets),
            ),
            SliverList(
              delegate: SliverChildListDelegate.fixed(
                [
                  ButtonBar(
                    children: [
                      RaisedButton(
                        child: Text('save'),
                        onPressed: () {
                          print('Saving!');
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
