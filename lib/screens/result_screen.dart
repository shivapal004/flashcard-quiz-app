import 'package:flashcard_quiz_app/screens/quiz_screen.dart';
import 'package:flutter/material.dart';

import '../helper/global.dart';

class ResultScreen extends StatelessWidget {
  final int totalQuestions;
  final int correctAnswers;

  const ResultScreen({super.key, required this.totalQuestions, required this.correctAnswers});

  @override
  Widget build(BuildContext context) {
    double scorePercentage = (correctAnswers / totalQuestions) * 100;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Result'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            height: mq.height * .6,
            width: mq.width * .8,
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: mq.height * .2,
                      child: Image.asset("assets/images/congratulation.png")),
                  const SizedBox(height: 10.0),
                  const Text(
                    'Congratulations!',
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    '${scorePercentage.toStringAsFixed(0)}% Score',
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  const Text(
                    'Quiz completed successfully.',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.black87
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    'You attempted $totalQuestions questions and \nfrom that $correctAnswers answers are correct.',
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const QuizScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                      textStyle: const TextStyle(fontSize: 18.0),
                    ),
                    child: const Text('Retake Quiz',style: TextStyle(color: Colors.black87),),
                  ),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
