import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:quiztor/domain/quiz/answer.dart';
import 'package:quiztor/domain/quiz/question.dart';

import 'package:quiztor/domain/quiz/quiz.dart';

class QuizState extends Equatable {
  final Option<Quiz> quizOption;
  final Option<String> currentQuestionIdOption;

  const QuizState({
    required this.quizOption,
    required this.currentQuestionIdOption,
  });

  factory QuizState.initial() {
    return QuizState(
      currentQuestionIdOption: none(),
      quizOption: none(),
    );
  }

  Quiz get quizOrCrash => quizOption.getOrElse(
      () => throw StateError('quizOption should be some in this case!'));

  int get correctAnswerCount {
    return _getSelectedAnswerCount(expression: (answer) {
      return answer.correct;
    });
  }

  int get wrongAnswerCount {
    return _getSelectedAnswerCount(expression: (answer) {
      return !answer.correct;
    });
  }

  int get totalQuestionCount => quizOrCrash.questionList.length;

  int get unansweredQuestionCount {
    return quizOrCrash.questionList.where((question) {
      return !question.answered;
    }).length;
  }

  List<Question> get availableQuestionList {
    return quizOrCrash.questionList.where((question) {
      return !question.expired;
    }).toList();
  }

  bool get allAnswered =>
      availableQuestionList.every((element) => element.answered);

  String get currentQuestionIdOrCrash => currentQuestionIdOption.getOrElse(
        () => throw StateError(
          'currentQuestionIdOption cannot be none in this case!',
        ),
      );

  int get availableQuestionIndexOrCrash {
    return availableQuestionList.indexWhere((question) {
      return question.id == currentQuestionIdOrCrash;
    });
  }

  int get questionIndexOrCrash {
    return quizOrCrash.questionList.indexWhere((question) {
      return question.id == currentQuestionIdOrCrash;
    });
  }

  int _getSelectedAnswerCount({required bool Function(Answer) expression}) {
    return quizOrCrash.questionList.where((question) {
      return question.answerList.any((answer) {
        return answer.selected && expression(answer);
      });
    }).length;
  }

  @override
  List<Object> get props => [quizOption, currentQuestionIdOption];

  QuizState copyWith({
    Option<Quiz>? quizOption,
    Option<String>? currentQuestionIdOption,
  }) {
    return QuizState(
      quizOption: quizOption ?? this.quizOption,
      currentQuestionIdOption:
          currentQuestionIdOption ?? this.currentQuestionIdOption,
    );
  }
}
