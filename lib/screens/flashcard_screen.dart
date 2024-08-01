import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'add_flashcard_screen.dart';
import '../models/flashcard.dart';
import '../models/flashcard_provider.dart';

class FlashcardScreen extends StatefulWidget {
  const FlashcardScreen({super.key});

  @override
  State<FlashcardScreen> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  @override
  Widget build(BuildContext context) {
    final flashcardProvider = Provider.of<FlashcardProvider>(context);
    final flashcards = flashcardProvider.flashcards;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flashcards'),
      ),
      body: flashcards.isEmpty
          ? const Center(child: Text('No flashcards available. Please add some.'))
          : ListView.builder(
        itemCount: flashcards.length,
        itemBuilder: (context, index) {
          final flashcard = flashcards[index];
          return _buildFlashcardCard(context, flashcard, index, flashcardProvider);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddFlashcardScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildFlashcardCard(BuildContext context, Flashcard flashcard, int index, FlashcardProvider flashcardProvider) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(15.0),
        onTap: () {
          _showFlashcardDetails(context, flashcard);
        },
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Colors.lightBlueAccent, Colors.blueAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                flashcard.question,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10.0),
              const Text(
                'Tap to view options',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showFlashcardDetails(BuildContext context, Flashcard flashcard) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Flashcard Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Question:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(flashcard.question),
              const SizedBox(height: 10.0),
              const Text(
                'Options:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              ...flashcard.options.map((option) => Text(option)),
              const SizedBox(height: 10.0),
              const Text(
                'Answer:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(flashcard.options[flashcard.correctAnswerIndex]),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
            TextButton(
              onPressed: () {
                // Delete flashcard and close dialog
                final flashcardProvider = Provider.of<FlashcardProvider>(context, listen: false);
                flashcardProvider.deleteFlashcard(flashcardProvider.flashcards.indexOf(flashcard));
                Navigator.of(context).pop();
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
