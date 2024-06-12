import 'package:flutter/material.dart';

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false, // Quitar la etiqueta "debug"
      home: QuizScreen(),
    );
  }
}

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> with SingleTickerProviderStateMixin {
  int _currentQuestionIndex = 0;
  bool _isAnswered = false;
  bool _isCorrect = false;
  int? _selectedAnswerIndex;

  final List<Question> _questions = [
    Question(
      text: '¿Cuál es la capital de Francia?',
      options: ['París', 'Londres', 'Madrid', 'Roma'],
      correctAnswerIndex: 0,
    ),
    Question(
      text: '¿Qué planeta es conocido como el planeta rojo?',
      options: ['Marte', 'Júpiter', 'Saturno', 'Venus'],
      correctAnswerIndex: 0,
    ),
    Question(
      text: '¿Qué país tiene la mayor esperanza de vida?',
      options: ['Mexico', 'Hong Kong', 'Rusia', 'USA'],
      correctAnswerIndex: 1,
    ),
        Question(
      text: '¿En qué ciudad estarías si te encontraras en las escaleras de la Plaza de España? ',
      options: ['Japon', 'China', 'España', 'Roma'],
      correctAnswerIndex: 3,
    ),
            Question(
      text: '¿Qué lengua tiene más hablantes nativos? ',
      options: ['Inges', 'Español', 'Chino', 'Holandes'],
      correctAnswerIndex: 3,
    ),
  ];

  void _selectAnswer(int index) {
    setState(() {
      _isAnswered = true;
      _isCorrect = index == _questions[_currentQuestionIndex].correctAnswerIndex;
      _selectedAnswerIndex = index;
    });

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _currentQuestionIndex = (_currentQuestionIndex + 1) % _questions.length;
        _isAnswered = false;
        _isCorrect = false;
        _selectedAnswerIndex = null;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final question = _questions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Quiz App')), 
        backgroundColor: Colors.blue, 
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              question.text,
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            ...question.options.asMap().entries.map((entry) {
              final idx = entry.key;
              final text = entry.value;
              return AnimatedContainer(
                duration: Duration(milliseconds: 500),
                margin: EdgeInsets.symmetric(vertical: 8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: _isAnswered
                      ? (idx == _selectedAnswerIndex
                          ? (idx == _questions[_currentQuestionIndex].correctAnswerIndex
                              ? Colors.green
                              : Colors.red)
                          : Colors.white)
                      : Colors.white,
                  border: Border.all(
                    color: _isAnswered
                        ? (idx == _selectedAnswerIndex
                            ? (idx == _questions[_currentQuestionIndex].correctAnswerIndex
                                ? Colors.green
                                : Colors.red)
                            : Colors.red)
                        : Colors.blue,
                    width: 2.0,
                  ),
                ),
                child: ListTile(
                  title: Text(text),
                  onTap: _isAnswered ? null : () => _selectAnswer(idx),
                ),
              );
            }),
            if (_isAnswered)
              Center(
                child: Text(
                  _isCorrect ? '¡Correcto!' : 'Incorrecto',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: _isCorrect ? Colors.green : Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class Question {
  final String text;
  final List<String> options;
  final int correctAnswerIndex;

  Question({
    required this.text,
    required this.options,
    required this.correctAnswerIndex,
  });
}
