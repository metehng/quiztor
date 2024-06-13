import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:quiztor/domain/quiz/question.dart';

import 'package:quiztor/domain/quiz/quiz.dart';

class QuizState extends Equatable {
  final Option<Quiz> quizOption;
  final Option<String> currentQuestionIdOption;

  const QuizState({
    required this.quizOption,
    required this.currentQuestionIdOption,
  });

  Quiz? get quizOrNull => quizOption.fold(() => null, (quiz) => quiz);
  Quiz get quizOrCrash => quizOption.getOrElse(
      () => throw StateError('quizOption should be some in this case!'));

  int get correctAnswerCount {
    return (quizOrNull?.questionList ?? []).where((question) {
      return question.answerList.any((answer) {
        return answer.selected && answer.correct;
      });
    }).length;
  }

  int get wrongAnswerCount {
    return (quizOrNull?.questionList ?? []).where((question) {
      return question.answerList.any((answer) {
        return answer.selected && !answer.correct;
      });
    }).length;
  }

  int get totalQuestionCount => quizOrNull?.questionList.length ?? 0;

  int get unansweredQuestionCount {
    return (quizOrNull?.questionList ?? []).where((question) {
      return !question.answered;
    }).length;
  }

  bool get allAnswered =>
      availableQuestionList.every((element) => element.answered);

  String get currentQuestionId => currentQuestionIdOption.getOrElse(
        () => throw StateError(
          'currentQuestionIdOption cannot be none in this case!',
        ),
      );

  factory QuizState.initial() {
    return QuizState(
      currentQuestionIdOption: none(),
      quizOption: none(),
    );
  }

  int get availableQuestionIndex {
    return availableQuestionList.indexWhere((question) {
      return question.id == currentQuestionIdOption.getOrElse(() => '');
    });
  }

  int get questionIndex {
    return (quizOrNull?.questionList ?? []).indexWhere((question) {
      return question.id == currentQuestionIdOption.getOrElse(() => '');
    });
  }

  List<Question> get availableQuestionList {
    return (quizOrNull?.questionList ?? []).where((question) {
      return !question.expired;
    }).toList();
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
