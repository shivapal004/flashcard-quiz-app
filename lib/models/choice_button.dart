import 'package:flutter/material.dart';

class ChoiceButton extends StatelessWidget {
  final String choice;
  final String text;
  final bool isSelected;
  final bool isCorrect;
  final VoidCallback onTap;

  const ChoiceButton({
    required this.choice,
    required this.text,
    required this.isSelected,
    required this.isCorrect,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: isSelected ? Colors.deepPurple[100] : Colors.grey,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: isSelected && isCorrect ? Colors.green : Colors.transparent,
            width: 3.0,
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: isSelected ? Colors.deepPurple : Colors.grey,
              child: Text(choice, style: TextStyle(color: Colors.white)),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(
                text,
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            if (isSelected && isCorrect) Icon(Icons.check_circle, color: Colors.green),
            if (isSelected && !isCorrect) Icon(Icons.close, color: Colors.red),
          ],
        ),
      ),
    );
  }
}
