import 'package:flutter/foundation.dart';

class Answered {
  final String answerOptionKey;
  final String questionKey;

  final String questionLabel;
  final String answerLabel;

  Answered({@required this.answerOptionKey, this.questionKey, this.questionLabel, this.answerLabel });
}