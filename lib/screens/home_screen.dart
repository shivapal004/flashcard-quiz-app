import 'package:flashcard_quiz_app/main.dart';
import 'package:flutter/material.dart';
import '../helper/global.dart';
import 'add_flashcard_screen.dart';
import 'flashcard_screen.dart';
import 'quiz_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initializing device size
    mq = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const Icon(Icons.home_filled),
        title: Text('Flashcard Quiz App',style: TextStyle(color: Theme.of(context).lightTextColor),),
      ),
      // Removed drawer feature
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildNavigationContainer(
              context,
              'Add Flashcard',
              Colors.blue,
              const AddFlashcardScreen(),
            ),
            const SizedBox(height: 20),
            _buildNavigationContainer(
              context,
              'Take Quiz',
              Colors.green,
              const QuizScreen(),
            ),
            const SizedBox(height: 20),
            _buildNavigationContainer(
              context,
              'View Flashcards', // New container to navigate to FlashcardScreen
              Colors.orange,
              const FlashcardScreen(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationContainer(
      BuildContext context,
      String title,
      Color color,
      Widget destination,
      ) {
    return InkWell(
      borderRadius: BorderRadius.circular(10.0),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
