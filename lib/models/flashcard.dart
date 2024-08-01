class Flashcard {
  final String question;
  final String answer;
  final List<String> options;
  final int correctAnswerIndex;

  Flashcard({
    required this.question,
    required this.answer,
    required this.options,
    required this.correctAnswerIndex,
  });

  factory Flashcard.fromJson(Map<String, dynamic> json) {
    return Flashcard(
      question: json['question'],
      answer: json['answer'],
      options: List<String>.from(json['options']),
      correctAnswerIndex: json['correctAnswerIndex'],
    );
  }

  Map<String, dynamic> toJson() => {
    'question': question,
    'answer': answer,
    'options': options,
    'correctAnswerIndex': correctAnswerIndex,
  };
}
