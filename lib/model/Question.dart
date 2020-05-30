import 'AnswerOption.dart';

class Question {
  final questionId = 11;
  final String question;
  final List<AnswerOption> possibleAnswers;
  final questionVersion = 1.0;

  Question({this.question, this.possibleAnswers});
}
