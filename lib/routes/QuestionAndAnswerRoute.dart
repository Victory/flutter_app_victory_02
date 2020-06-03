import 'package:flutter/material.dart';
import 'package:flutterappvictory02/model/AnswerOption.dart';
import 'package:flutterappvictory02/model/Answered.dart';
import 'package:flutterappvictory02/routes/SpinnerRoute.dart';

import '../model/MockDb.dart';
import '../model/Question.dart';

class QuestionAndAnswerRoute extends StatefulWidget {
  static const routeName = '/qanda';

  final Question _q;

  QuestionAndAnswerRoute(this._q);

  static fromContext(BuildContext context) {
    Question q = ModalRoute.of(context).settings.arguments;
    return QuestionAndAnswerRoute(q);
  }

  static navigateTo(BuildContext context, {index = 0}) {
    SpinnerRoute.navigateTo(context, () {
      db.getAllQuestions().then((questions) {
        Navigator.of(context).pushReplacementNamed(
          QuestionAndAnswerRoute.routeName,
          arguments: questions[index],
        );
      });
    });
  }

  @override
  State<StatefulWidget> createState() {
    return new _QuestionState(_q);
  }
}

class _QuestionState extends State<QuestionAndAnswerRoute> {
  Question _q;

  bool _isSaveEnabled = false;

  AnswerOption _sofiasAnwser;

  _QuestionState(this._q);

  @override
  Widget build(BuildContext context) {
    var answerWidgets = _q.possibleAnswers.map((ans) {
      return RadioListTile(
        title: Padding(
          padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
          child: Text(ans.label),
        ),
        value: ans,
        groupValue: _sofiasAnwser,
        onChanged: (opt) {
          setState(() {
            _isSaveEnabled = true;
            _sofiasAnwser = opt;
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
                    key: ObjectKey(_q),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        _q.label,
                        textScaleFactor: 1.8,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  ...answerWidgets,
                  ButtonBar(
                    children: [
                      RaisedButton(
                        child: Text('save'),
                        onPressed: (!_isSaveEnabled) ? null : () {
                          _isSaveEnabled = false;
                          db.saveAnswer(Answered(
                            answerOptionKey: _sofiasAnwser.answerOptionKey,
                            answerLabel: _sofiasAnwser.label,
                            questionKey: _q.questionKey,
                            questionLabel: _q.label,
                          ));

                          db.getAllQuestions().then((questions) {
                            setState(() {
                              _q = questions[1];
                            });
                          });
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
