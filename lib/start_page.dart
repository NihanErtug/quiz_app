import 'package:flutter/material.dart';
import 'package:quiz_app/colors/app_colors.dart';
import 'package:quiz_app/quiz_screen.dart';

class StartGame extends StatelessWidget {
  const StartGame({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz Uygulaması"),
        centerTitle: true,
        backgroundColor: AppColors.background(),
      ),
      backgroundColor: AppColors.background(),
      body: Center(
        child: Column(
          children: [
            Container(
              width: 200,
              height: 200,
              margin: const EdgeInsets.only(top: 145),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(300),
                color: AppColors.buttonBackground(),
              ),
              child: const Center(
                child: Text(
                  "Hoşgeldiniz!",
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
            Container(
              width: 300,
              margin: const EdgeInsetsDirectional.only(top: 120),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const QuizScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: AppColors.buttonBackground(),
                ),
                child: const Text("Başla"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
