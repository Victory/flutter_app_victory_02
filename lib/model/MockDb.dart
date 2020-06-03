import 'dart:math';

import 'package:flutterappvictory02/model/Answered.dart';

import 'AnswerOption.dart';
import 'Question.dart';

class _Db {
  var _rnd = new Random();

  var _answered = [];

  var _questions = [
    Question(
        label: 'How were you doing when you were a girl in the village?',
        possibleAnswers: [
          AnswerOption(label: 'Good'),
          AnswerOption(label: 'Bad'),
          AnswerOption(label: 'Alright!'),
        ]),
    Question(
      label: 'How long did it take you to become a princess?',
      possibleAnswers: [
        AnswerOption(label: 'Like a year'),
        AnswerOption(label: 'Few Months'),
        AnswerOption(label: 'Overnight!'),
      ],
    )
  ];

  getAllQuestions() {
    return Future.delayed(_getPromiseDuration(), () {
      return _questions;
    });
  }

  saveAnswer(Answered a) {
    return Future.delayed(_getPromiseDuration(), () {
      _answered.add(a);
    });
  }

  _getPromiseDuration() {
    return Duration(milliseconds: _rnd.nextInt(3000));
  }
}

_Db db = new _Db();