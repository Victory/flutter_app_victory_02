import 'dart:math';

import 'package:flutterappvictory02/model/Answered.dart';

import 'AnswerOption.dart';
import 'Question.dart';

class _Db {
  final _rnd = Random();

  final _answered = <Answered>[];

  final _questions = [
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

  /// Get all available answers
  Future<List<Question>> getAllQuestions() {
    return Future.delayed(_getPromiseDuration(), () {
      return _questions;
    });
  }

  /// Get the number of available questions
  Future<int> getNumberOfQuestions() {
    return Future.delayed(_getPromiseDuration(), () {
      return _questions.length;
    });
  }

  /// Save the given answer
  Future<Null> saveAnswer(Answered a) {
    return Future.delayed(_getPromiseDuration(), () {
      _answered.add(a);
    });
  }

  /// get all answered questions
  Future<List<Answered>> getAllAnswered() {
    return Future.delayed(_getPromiseDuration(), () {
      return _answered;
    });
  }

  Duration _getPromiseDuration() {
    return Duration(milliseconds: _rnd.nextInt(200));
  }
}

_Db db = _Db();