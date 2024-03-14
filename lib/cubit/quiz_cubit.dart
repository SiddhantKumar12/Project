import 'package:flutter_bloc/flutter_bloc.dart';

class QuizCubit extends Cubit<QuizState> {
  QuizCubit() : super(QuizState.initial());

  void answerQuestion(bool isCorrect) {
    if (isCorrect) {
      emit(state.copyWith(score: state.score + 1));
    }
    if (state.questionIndex < state.questions.length - 1) {
      emit(state.copyWith(questionIndex: state.questionIndex + 1));
    } else {
      if (state.score > state.highScore) {
        emit(state.copyWith(highScore: state.score));
      }
      emit(state.copyWith(showResult: true));
    }
  }

  void resetQuiz() {
    emit(QuizState.initial());
  }
}

class QuizState {
  final int questionIndex;
  final int score;
  final int highScore;
  final bool showResult;
  final List<Map<String, dynamic>> questions;

  QuizState({
    required this.questionIndex,
    required this.score,
    required this.highScore,
    required this.showResult,
    required this.questions,
  });

  factory QuizState.initial() {
    return QuizState(
      questionIndex: 0,
      score: 0,
      highScore: 0,
      showResult: false,
      questions: [
        {
          'questionText': 'How many days do we have in a week',
          'answers': [
            {'text': '1', 'isCorrect': false},
            {'text': '7', 'isCorrect': true},
            {'text': '365', 'isCorrect': false},
            {'text': '30', 'isCorrect': false},
          ],
        },
        {
          'questionText': 'What is 2 + 2?',
          'answers': [
            {'text': '4', 'isCorrect': true},
            {'text': '5', 'isCorrect': false},
            {'text': '6', 'isCorrect': false},
            {'text': '3', 'isCorrect': false},
          ],
        },
        {
          'questionText': 'Which animal is known as the ‘Ship of the Desert?',
          'answers': [
            {'text': 'Camel', 'isCorrect': true},
            {'text': 'Lion', 'isCorrect': false},
            {'text': 'Tiger', 'isCorrect': false},
            {'text': 'Goat', 'isCorrect': false},
          ],
        },
        {
          'questionText': 'How many letters are there in the English alphabet?',
          'answers': [
            {'text': '26', 'isCorrect': true},
            {'text': '55', 'isCorrect': false},
            {'text': '6', 'isCorrect': false},
            {'text': '30', 'isCorrect': false},
          ],
        },
      ],
    );
  }

  QuizState copyWith({
    int? questionIndex,
    int? score,
    int? highScore,
    bool? showResult,
  }) {
    return QuizState(
      questionIndex: questionIndex ?? this.questionIndex,
      score: score ?? this.score,
      highScore: highScore ?? this.highScore,
      showResult: showResult ?? this.showResult,
      questions: this.questions,
    );
  }
}
