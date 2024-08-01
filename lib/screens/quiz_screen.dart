import 'package:flashcard_quiz_app/main.dart';
import 'package:flashcard_quiz_app/screens/home_screen.dart';
import 'package:flashcard_quiz_app/screens/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/choice_button.dart';
import '../models/flashcard_provider.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentFlashcardIndex = 0;
  int _score = 0;
  bool _answered = false;
  bool _isQuizCompleted = false;
  List<String> _questionStatuses = [];
  int? _selectedAnswerIndex;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final flashcards = Provider.of<FlashcardProvider>(context, listen: false).flashcards;
      setState(() {
        _questionStatuses = List<String>.filled(flashcards.length, 'unanswered');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final flashcards = Provider.of<FlashcardProvider>(context).flashcards;

    if (flashcards.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Quiz'),
          backgroundColor: Colors.deepPurple,
        ),
        body: const Center(
          child: Text('No flashcards available. Please add some.'),
        ),
      );
    }

    final currentFlashcard = flashcards[_currentFlashcardIndex];
    final totalQuestions = flashcards.length;
    final questionNumber = _currentFlashcardIndex + 1;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
        }, icon: const Icon(Icons.arrow_back)),
        title: const Text('Quiz'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Question $questionNumber of $totalQuestions',
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20.0),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    "Ques: ${currentFlashcard.question}",
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).lightTextColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20.0),
                  Column(
                    children: currentFlashcard.options
                        .asMap()
                        .entries
                        .map((entry) {
                      final index = entry.key;
                      final option = entry.value;
                      return ChoiceButton(
                        choice: String.fromCharCode(65 + index),
                        text: option,
                        isSelected: _selectedAnswerIndex == index,
                        isCorrect: index == currentFlashcard.correctAnswerIndex,
                        onTap: () => _handleAnswer(index),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              children: [

                const Spacer(),
                ElevatedButton(
                  onPressed: _currentFlashcardIndex < flashcards.length - 1 ? _nextFlashcard : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text('Next', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            const SizedBox(height: 20.0),

            //submit button
            if (_isQuizCompleted)
              Center(
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultScreen(
                          totalQuestions: Provider.of<FlashcardProvider>(context, listen: false).flashcards.length,
                          correctAnswers: _score,
                        ),
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
                  child: const Text('Submit', style: TextStyle(color: Colors.white),),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _handleAnswer(int selectedIndex) {
    if (_answered) return;

    final flashcards = Provider.of<FlashcardProvider>(context, listen: false).flashcards;
    final currentFlashcard = flashcards[_currentFlashcardIndex];

    setState(() {
      _selectedAnswerIndex = selectedIndex;
      if (selectedIndex == currentFlashcard.correctAnswerIndex) {
        _score++;
        _questionStatuses[_currentFlashcardIndex] = 'right';
      } else {
        _questionStatuses[_currentFlashcardIndex] = 'wrong';
      }
      _answered = true;
    });

    if (_currentFlashcardIndex == flashcards.length - 1) {
      setState(() {
        _isQuizCompleted = true;
      });
    }
  }

  void _nextFlashcard() {
    final flashcards = Provider.of<FlashcardProvider>(context, listen: false).flashcards;
    if (_currentFlashcardIndex < flashcards.length - 1) {
      setState(() {
        _currentFlashcardIndex++;
        _answered = false;
        _selectedAnswerIndex = null;
      });
    }
  }




}
