import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/cubit/quiz_cubit.dart';

import '../cubit/auth_cubit.dart';

class ResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.read<QuizCubit>().state;
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Result'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Your Score: ${state.score}/${state.questions.length}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'High Score: ${state.highScore}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.read<QuizCubit>().resetQuiz();
              },
              child: Text('Restart Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}
