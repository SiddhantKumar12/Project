import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/screens/result_screen.dart';

import '../cubit/auth_cubit.dart';
import '../cubit/quiz_cubit.dart';

class QuizScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuizCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Quiz'),
          actions: [
            IconButton(
                onPressed: () {
                  BlocProvider.of<AuthCubit>(context).signOut();
                  BlocProvider.of<AuthCubit>(context).checkAuthentication();
                },
                icon: Icon(
                  Icons.exit_to_app,
                ))
          ],
        ),
        body: BlocBuilder<QuizCubit, QuizState>(
          builder: (context, state) {
            return state.showResult ? ResultScreen() : QuizContent(state: state);
          },
        ),
      ),
    );
  }
}

class QuizContent extends StatelessWidget {
  final QuizState state;

  const QuizContent({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            state.questions[state.questionIndex]['questionText'],
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 20),
          ...(state.questions[state.questionIndex]['answers'] as List<Map<String, dynamic>>)
              .map((answer) => ElevatedButton(
                    onPressed: () => context.read<QuizCubit>().answerQuestion(answer['isCorrect']),
                    child: Text(answer['text']),
                  ))
              .toList(),
        ],
      ),
    );
  }
}
