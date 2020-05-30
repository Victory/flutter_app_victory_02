import 'package:flutter/material.dart';
import 'package:flutterappvictory02/model/AnswerOption.dart';

import 'model/Question.dart';

/*
class QuestionAndAnswerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text('There are Choices in Life'),
          )
        ],
      ),
    );
  }
}
 */

class QuestionAndAnswerWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new QuestionState();
  }
}

class QuestionState extends State<QuestionAndAnswerWidget> {
  var _questions = [
    Question(
        question: 'How were you doing when you were a girl in the village?',
        possibleAnswers: [
          AnswerOption(label: 'Good'),
          AnswerOption(label: 'Bad'),
          AnswerOption(label: 'Alright!'),
        ])
  ];

  AnswerOption _sofias_anwser;

  @override
  Widget build(BuildContext context) {
    var _q = _questions[0];

    var answerWidgets = _q.possibleAnswers.map((ans) {
      return RadioListTile(
        title: Padding(
          padding: const EdgeInsets.fromLTRB(8, 36, 0, 36),
          child: Text(ans.label),
        ),
        value: ans,
        groupValue: _sofias_anwser,
        onChanged: (opt) {
          setState(() {
            _sofias_anwser = opt;
          });
        },
      );
    }).toList();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text('There are Choices in Life'),
          ),
          SliverList(
            delegate: SliverChildListDelegate.fixed(
              [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _q.question,
                      textScaleFactor: 1.8,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate.fixed(answerWidgets),
          ),
          SliverList(
            delegate: SliverChildListDelegate.fixed(
              [
                ButtonBar(
                  children: [
                    RaisedButton(
                      child: Text('save'),
                      onPressed: () {
                        print('Saving!');
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
