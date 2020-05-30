import 'package:uuid/uuid.dart';

class AnswerOption {
  final key =  Uuid().v4();
  final String label;

  AnswerOption({this.label});
}
