import 'package:flutter/material.dart';
import 'package:quiz_app/screens/quiz_screen.dart';
import 'package:quiz_app/colors/app_colors.dart';
import 'dart:math';

class StartGame extends StatefulWidget {
  const StartGame({super.key});

  @override
  State<StartGame> createState() => _StartGameState();
}

class _StartGameState extends State<StartGame>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final circleSize = screenWidth * 0.65;
    final outherCircleSize = circleSize * 1.1;

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: PreferredSize(
            preferredSize: Size.fromHeight(80),
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/start_banner.gif'),
                      fit: BoxFit.cover)),
            )),
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/result_wallpaper.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.15),
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Expanded(
                      flex: 5,
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          // dış çember
                          Transform.rotate(
                            angle: _controller.value * 2 * pi,
                            child: Container(
                              width: outherCircleSize,
                              height: outherCircleSize,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(circleSize / 2),
                                border: Border.all(
                                  color: AppColors.buttonBackground(),
                                  width: 8,
                                ),
                              ),
                            ),
                          ),
                          // iç çember
                          Container(
                            width: circleSize * 0.8,
                            height: circleSize * 0.8,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(circleSize / 2),
                              color: AppColors.buttonBackground(),
                            ),
                            child: const Center(
                              child: Text(
                                "Hoşgeldiniz!",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(height: screenHeight * 0.15),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    width: screenWidth * 0.5,
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
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22),
                        ),
                      ),
                      child: const Text(
                        "Başla",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.1),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
