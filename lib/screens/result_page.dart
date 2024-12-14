import 'package:flutter/material.dart';
import 'package:quiz_app/colors/app_colors.dart';
import 'package:quiz_app/main.dart';

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
            SizedBox(
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
                        style:
                            const TextStyle(fontSize: 20, color: Colors.white),
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
                        style:
                            const TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ],
                  ),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
