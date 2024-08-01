import 'package:flashcard_quiz_app/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/flashcard_provider.dart';
import '../models/flashcard.dart';

class AddFlashcardScreen extends StatefulWidget {
  const AddFlashcardScreen({super.key});

  @override
  State<AddFlashcardScreen> createState() => _AddFlashcardScreenState();
}

class _AddFlashcardScreenState extends State<AddFlashcardScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _questionController = TextEditingController();
  final List<TextEditingController> _optionControllers = List.generate(4, (_) => TextEditingController());
  int _correctAnswerIndex = 0;

  @override
  void dispose() {
    _questionController.dispose();
    for (var controller in _optionControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Flashcard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _questionController,
                    decoration: const InputDecoration(
                      labelText: 'Question',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a question';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Options',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _optionControllers.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _optionControllers[index],
                              decoration: InputDecoration(
                                labelText: 'Option ${index + 1}',
                                border: const OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter option ${index + 1}';
                                }
                                return null;
                              },
                            ),
                          ),
                          Radio<int>(
                            value: index,
                            groupValue: _correctAnswerIndex,
                            onChanged: (value) {
                              setState(() {
                                _correctAnswerIndex = value!;
                              });
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20.0),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final flashcard = Flashcard(
                          question: _questionController.text,
                          answer: _optionControllers[_correctAnswerIndex].text,
                          options: _optionControllers.map((controller) => controller.text).toList(),
                          correctAnswerIndex: _correctAnswerIndex,
                        );
                        Provider.of<FlashcardProvider>(context, listen: false).addFlashcard(flashcard);
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                      textStyle: const TextStyle(fontSize: 16.0),
                    ),
                    child: Text('Add Flashcard', style: TextStyle(color: Theme.of(context).lightTextColor),),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
