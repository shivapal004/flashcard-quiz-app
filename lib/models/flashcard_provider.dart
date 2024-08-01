import 'dart:convert';
import 'package:flutter/material.dart';
import 'flashcard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FlashcardProvider extends ChangeNotifier {
  List<Flashcard> _flashcards = [];
  int _score = 0;

  List<Flashcard> get flashcards => _flashcards;
  int get score => _score;

  FlashcardProvider() {
    loadFlashcards();
  }

  void addFlashcard(Flashcard flashcard) {
    _flashcards.add(flashcard);
    saveFlashcards();
    notifyListeners();
  }

  void deleteFlashcard(int index) {
    if (index >= 0 && index < _flashcards.length) {
      _flashcards.removeAt(index);
      saveFlashcards();
      notifyListeners();
    } else {
      // Handle invalid index if necessary
      print('Invalid flashcard index: $index');
    }
  }

  void updateScore(int newScore) {
    _score = newScore;
    notifyListeners();
  }

  Future<void> loadFlashcards() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final flashcardsString = prefs.getString('flashcards');
      if (flashcardsString != null) {
        final List<dynamic> flashcardListJson = jsonDecode(flashcardsString);
        _flashcards = flashcardListJson
            .map((json) => Flashcard.fromJson(json as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      // Handle JSON parsing or SharedPreferences errors
      print('Error loading flashcards: $e');
    }
    notifyListeners();
  }

  Future<void> saveFlashcards() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final flashcardsString = jsonEncode(
        _flashcards.map((flashcard) => flashcard.toJson()).toList(),
      );
      await prefs.setString('flashcards', flashcardsString);
    } catch (e) {
      // Handle SharedPreferences errors
      print('Error saving flashcards: $e');
    }
  }
}
