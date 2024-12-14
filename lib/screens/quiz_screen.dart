import 'package:flutter/material.dart';
import 'package:quiz_app/colors/app_colors.dart';
import 'package:quiz_app/data/questions_data.dart';
import 'package:quiz_app/main.dart';
import 'package:quiz_app/screens/result_page.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentIndex = 0;
  int _correctAnswer = 0, _wrongAnswer = 0;
  List<String> currentAnswers = [];
  List<String?> selectedAnswers = [];

  @override
  void initState() {
    super.initState();
    selectedAnswers = List<String?>.filled(questions.length, null);
    setCurrentAnswers();
  }

  void setCurrentAnswers() {
    if (questions.isNotEmpty) {
      currentAnswers = List<String>.from(questions[currentIndex].answers);
    }
  }

  void checkAnswer(String userAnswer) {
    if (questions.isEmpty) return;

    String correctAnswer = questions[currentIndex].correctAnswer;

    // Eğer önceki cevap varsa D-Y sayısı güncellensin diye
    String? previousAnswer = selectedAnswers[currentIndex];
    if (previousAnswer != null) {
      if (previousAnswer == correctAnswer) {
        _correctAnswer--;
      } else {
        _wrongAnswer--;
      }
    }

    if (userAnswer == correctAnswer) {
      _correctAnswer++;
    } else {
      _wrongAnswer++;
    }

    selectedAnswers[currentIndex] = userAnswer;

    setState(() {});

    if (currentIndex == questions.length - 1) {
      _showConfirmation(context);
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
        setCurrentAnswers();
      }
    });
  }

  Future<bool?> _showConfirmation(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color.fromARGB(255, 175, 183, 230),
        title: Text("Quiz'i bitir"),
        content: Text("Quiz'i bitirmek istediğinizden emin misiniz?"),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text("Hayır")),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.buttonBackground()),
              onPressed: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizResult(
                        correctAnswer: _correctAnswer,
                        wrongAnswer: _wrongAnswer,
                      ),
                    ),
                  ),
              child: Text("Evet")),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/banner.png'),
                      fit: BoxFit.cover)),
            )),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const MainApp()));
            },
            icon: Icon(Icons.home, color: Colors.white54),
          ),
        ],
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/wallpaper.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white54,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  padding: const EdgeInsets.all(25),
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
              const SizedBox(height: 30),
              Expanded(
                child: ListView.builder(
                  itemCount: currentAnswers.length,
                  itemBuilder: (context, index) {
                    String answer = currentAnswers[index];
                    bool isSelected = selectedAnswers[currentIndex] == answer;
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 20),
                      child: ElevatedButton(
                        onPressed: () => checkAnswer(answer),
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: isSelected
                                ? Colors.green
                                : AppColors.buttonBackground()),
                        child: Text(answer),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (currentIndex > 0)
                      SizedBox(
                        width: 150,
                        child: ElevatedButton(
                          onPressed: previousQuestion,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.buttonBackground(),
                            foregroundColor: Colors.black,
                          ),
                          child: const Text('Önceki Soru'),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
