import 'package:flutter/material.dart';
import 'package:quiz_app/colors/app_colors.dart';
import 'package:quiz_app/start_page.dart';

class QuizResult extends StatelessWidget {
  const QuizResult({
    super.key,
    required this.correctAnswer,
    required this.wrongAnswer,
  });

  final int correctAnswer;
  final int wrongAnswer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.resultBackground(),
      appBar: AppBar(
        title: const Text(
          'Quiz Sonuçları',
          style: TextStyle(fontSize: 30),
        ),
        shape: const Border(
            bottom: BorderSide(
                style: BorderStyle.solid,
                color: Color.fromRGBO(0, 0, 0, 1),
                width: 1.2)),
        centerTitle: true,
        backgroundColor: AppColors.resultBackground(),
      ),
      body: Center(
        child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Doğru Cevaplar: $correctAnswer',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              Text(
                'Yanlış Cevaplar: $wrongAnswer',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const StartGame(),
                      ));
                },
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: AppColors.buttonBackground()),
                child: const Text('Tekrar Başla'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
