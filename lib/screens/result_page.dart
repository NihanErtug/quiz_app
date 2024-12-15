import 'package:flutter/material.dart';
import 'package:quiz_app/colors/app_colors.dart';
import 'package:quiz_app/data/questions_data.dart';
import 'package:quiz_app/main.dart';
import 'package:quiz_app/questions_summary/questions_summary.dart';

class QuizResult extends StatelessWidget {
  const QuizResult({
    super.key,
    required this.correctAnswer,
    required this.wrongAnswer,
    required this.selectedAnswers,
  });

  final int correctAnswer;
  final int wrongAnswer;
  final List<String?> selectedAnswers;

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < selectedAnswers.length; i++) {
      summary.add({
        'question_index': i,
        'question': questions[i].question,
        'correct_answer': questions[i].correctAnswer,
        'user_answer': selectedAnswers[i] ?? 'Cevaplanmadı',
      });
    }
    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final summaryData = getSummaryData();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: PreferredSize(
            preferredSize: Size.fromHeight(70),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/result_banner.png'),
                    fit: BoxFit.cover),
              ),
            )),
      ),
      body: Center(
        child: Stack(
          children: [
            Image.asset(
              'assets/result_wallpaper.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Flexible(
              flex: 1,
              child: SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.check,
                          color: Colors.green.shade300,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Doğru Cevaplar: $correctAnswer',
                          style: const TextStyle(
                              fontSize: 20, color: Colors.white),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Divider(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.close_sharp, color: Colors.red.shade400),
                        SizedBox(width: 8),
                        Text(
                          'Yanlış Cevaplar: $wrongAnswer',
                          style: const TextStyle(
                              fontSize: 20, color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Flexible(
                        flex: 4,
                        child: QuestionsSummary(summaryData: summaryData)),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MainApp(),
                            ));
                      },
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: AppColors.buttonBackground()),
                      child: const Text('Tekrar Başla'),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
