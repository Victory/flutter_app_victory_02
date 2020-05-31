import 'dart:math';

import 'AnswerOption.dart';
import 'Question.dart';

class _Db {
  var _rnd = new Random();

  var _questions = [
    Question(
        question: 'How were you doing when you were a girl in the village?',
        possibleAnswers: [
          AnswerOption(label: 'Good'),
          AnswerOption(label: 'Bad'),
          AnswerOption(label: 'Alright!'),
        ]),
    Question(
      question: 'How long did it take you to become a princess?',
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

  _getPromiseDuration() {
    return Duration(milliseconds: _rnd.nextInt(3000));
  }
}

_Db db = new _Db();