import 'package:uuid/uuid.dart';

import 'AnswerOption.dart';

class Question {
  final questionKey = Uuid().v4();
  final String label;
  final List<AnswerOption> possibleAnswers;
  final questionVersion = 1.0;

  Question({this.label, this.possibleAnswers});
}
