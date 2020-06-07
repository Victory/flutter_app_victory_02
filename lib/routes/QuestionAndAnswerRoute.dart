import 'package:flutter/material.dart';
import 'package:flutterappvictory02/model/AnswerOption.dart';
import 'package:flutterappvictory02/model/Answered.dart';
import 'package:flutterappvictory02/routes/AnswerReviewRoute.dart';
import 'package:flutterappvictory02/routes/SpinnerRoute.dart';

import '../model/MockDb.dart';
import '../model/Question.dart';

class QuestionAndAnswerRoute extends StatefulWidget {
  static const routeName = '/qanda';

  final List<Question> _questions;

  QuestionAndAnswerRoute(this._questions);

  static QuestionAndAnswerRoute fromContext(BuildContext context) {
    List<Question> questions = ModalRoute.of(context).settings.arguments;
    return QuestionAndAnswerRoute(questions);
  }

  static void navigateTo(BuildContext context, {index = 0}) {
    SpinnerRoute.navigateTo(context, () {
      db.getAllQuestions().then((questions) {
        Navigator.of(context).pushReplacementNamed(
          QuestionAndAnswerRoute.routeName,
          arguments: questions,
        );
      });
    });
  }

  @override
  State<StatefulWidget> createState() {
    return _QuestionState(_questions);
  }
}

class _QuestionState extends State<QuestionAndAnswerRoute> {
  final List<Question> _questions;

  int _questionIndex;

  bool _isSaveEnabled = false;

  final _allSaved = <Future>[];

  AnswerOption _sofiasAnswer;

  _QuestionState(this._questions) {
    _questionIndex = 0;
  }

  Question get _question {
    return _questions[_questionIndex];
  }

  int get _numberOfQuestions {
    return _questions.length;
  }

  @override
  Widget build(BuildContext context) {
    var answerWidgets = _question.possibleAnswers.map((ans) {
      return RadioListTile(
        title: Padding(
          padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
          child: Text(ans.label),
        ),
        value: ans,
        groupValue: _sofiasAnswer,
        onChanged: (opt) {
          setState(() {
            _isSaveEnabled = true;
            _sofiasAnswer = opt;
          });
        },
      );
    }).toList();

    Function onSave = () {
      setState(() {
        _isSaveEnabled = false;
      });

      var saved = db.saveAnswer(Answered(
        answerOptionKey: _sofiasAnswer.answerOptionKey,
        answerLabel: _sofiasAnswer.label,
        questionKey: _question.questionKey,
        questionLabel: _question.label,
      ));
      _allSaved.add(saved);

      if (_numberOfQuestions <= _questionIndex + 1) {
        SpinnerRoute.navigateTo(context, () async {
          await Future.wait(_allSaved);
          AnswerReviewRoute.navigateTo(context);
        });
      } else {
        setState(() {
          _questionIndex += 1;
        });
      }
    };

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
                    key: ObjectKey(_question),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        _question.label,
                        textScaleFactor: 1.8,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  ...answerWidgets,
                  ButtonBar(
                    children: [
                      RaisedButton(
                        child: Text('Save'),
                        onPressed: (!_isSaveEnabled) ? null : onSave,
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
