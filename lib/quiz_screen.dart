import 'package:flutter/material.dart';
import 'package:quiz_app/colors/app_colors.dart';
import 'package:quiz_app/data/questions_data.dart';
import 'package:quiz_app/result_page.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentIndex = 0;
  int _correctAnswer = 0, _wrongAnswer = 0;
  List<String> currentAnswers = [];
  String lastAnswer = '';

  @override
  void initState() {
    super.initState();
    setCurrentAnswers();
  }

  void setCurrentAnswers() {
    currentAnswers = List<String>.from(questions[currentIndex].answers);
  }

  void checkAnswer(String userAnswer) {
    String correctAnswer = questions[currentIndex].correctAnswer;
    if (userAnswer == correctAnswer) {
      _correctAnswer++;
    } else {
      _wrongAnswer++;
    }

    if (currentIndex == questions.length - 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => QuizResult(
            correctAnswer: _correctAnswer,
            wrongAnswer: _wrongAnswer,
          ),
        ),
      );
    } else {
      nextQuestion();
    }
  }

  void nextQuestion() {
    setState(() {
      if (currentIndex < questions.length - 1) {
        currentIndex++;
        setCurrentAnswers();
      }
    });
  }

  void previousQuestion() {
    setState(() {
      if (currentIndex > 0) {
        currentIndex--;
        updateAnswer(lastAnswer);
        setCurrentAnswers();
      }
    });
  }

  void updateAnswer(String lastAnswer) {
    if (lastAnswer == _correctAnswer) {
      _correctAnswer--;
    } else {
      _wrongAnswer--;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background(),
      appBar: AppBar(
        title: const Text("Quiz", style: TextStyle(fontSize: 30)),
        shape: const Border(
          bottom: BorderSide(
            style: BorderStyle.solid,
            color: Color.fromARGB(85, 0, 0, 0),
          ),
        ),
        backgroundColor: AppColors.background(),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Transform.translate(
              offset: const Offset(0, -60),
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                width: 400,
                height: 170,
                padding: const EdgeInsets.all(25),
                margin: const EdgeInsets.all(20),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    "${currentIndex + 1}. ${questions[currentIndex].question}",
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 0, 0, 0)),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Column(
              children: currentAnswers.map((answer) {
                return Container(
                  padding: const EdgeInsets.all(0.5),
                  width: 350,
                  child: ElevatedButton(
                      onPressed: () => checkAnswer(answer),
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: AppColors.buttonBackground()),
                      child: Text(answer)),
                );
              }).toList(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: currentIndex > 0 ? previousQuestion : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttonBackground(),
                      foregroundColor: Colors.black,
                    ),
                    child: const Text('Önceki Soru'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
