import 'AnswerOption.dart';
import 'Question.dart';

class Db {
  var _questions = [
    Question(
        question: 'How were you doing when you were a girl in the village?',
        possibleAnswers: [
          AnswerOption(label: 'Good'),
          AnswerOption(label: 'Bad'),
          AnswerOption(label: 'Alright!'),
        ])
  ];

  getAllQuestions() {
    return Future.delayed(_getPromiseDuration(), () {
      return _questions;
    });
  }

  _getPromiseDuration() {
    return Duration(milliseconds: 300);
  }
}