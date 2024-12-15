import 'package:flutter/material.dart';
import 'package:quiz_app/questions_summary/question_identifier.dart';

class SummaryItem extends StatelessWidget {
  const SummaryItem(this.data, {super.key});

  final Map<String, Object> data;

  @override
  Widget build(BuildContext context) {
    final isCorrectAnswer = data['user_answer'] == data['correct_answer'];

    return Padding(
      //padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      padding: EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          QuestionIdentifier(
              questionIndex: data['question_index'] as int,
              isCorrectAnswer: isCorrectAnswer),
          SizedBox(width: 20),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data['question'] as String,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 5),
              Text(
                data['user_answer'] as String,
                style: TextStyle(color: Colors.white),
              ),
              Row(
                children: [
                  Text(
                    data['correct_answer'] as String,
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(width: 5),
                  Icon(
                    Icons.check,
                    color: Colors.green.shade300,
                  )
                ],
              ),
            ],
          )),
        ],
      ),
    );
  }
}
