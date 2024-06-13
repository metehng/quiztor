import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiztor/application/quiz_notifier/quiz_state.dart';
import 'package:quiztor/domain/quiz/answer.dart';
import 'package:quiztor/domain/quiz/i_quiz_repository.dart';
import 'package:quiztor/domain/quiz/question.dart';
import 'package:quiztor/infrastructure/quiz/quiz_repository.dart';

final quizNotifierProvider = StateNotifierProvider<QuizNotifier, QuizState>(
  (ref) {
    final quizRepository = ref.watch(quizRepositoryProvider);
    return QuizNotifier(quizRepository);
  },
);

class QuizNotifier extends StateNotifier<QuizState> {
  QuizNotifier(this._iQuizRepository) : super(QuizState.initial());
  final IQuizRepository _iQuizRepository;

  Future<void> fetch() async {
    final quiz = await _iQuizRepository.getQuiz();
    final currentQuestionId = quiz?.questionList.first.id;

    state = state.copyWith(
      quizOption: optionOf(quiz),
      currentQuestionIdOption: optionOf(currentQuestionId),
    );
  }

  void answerQuestion({required String questionId, required Answer answer}) {
    assert(state.quizOption.isSome());

    final questionList = List<Question>.from(state.quizOrCrash.questionList);
    final questionIndex = questionList.indexWhere((q) => q.id == questionId);
    if (questionIndex == -1) return;

    Question question = questionList[questionIndex];
    final answerList = question.answerList
        .map((a) => a.copyWith(selected: a.id == answer.id))
        .toList();

    question = question.copyWith(answerList: answerList);
    questionList[questionIndex] = question;

    final quiz = state.quizOrCrash.copyWith(questionList: questionList);
    state = state.copyWith(quizOption: some(quiz));
  }

  void updateCurrentQuestionId({required String questionId}) {
    state = state.copyWith(currentQuestionIdOption: some(questionId));
  }

  void expireQuestion({required String questionId}) {
    final questionList = List<Question>.from(state.quizOrCrash.questionList);
    final questionIndex = questionList.indexWhere((q) => q.id == questionId);
    Question question = questionList[questionIndex];
    questionList[questionIndex] = question.copyWith(expired: true);

    final quiz = state.quizOrCrash.copyWith(questionList: questionList);

    final newQuestionId = _calculateNewQuestionId();
    final currQuestIdOpt = newQuestionId == null ? null : some(newQuestionId);

    state = state.copyWith(
      quizOption: some(quiz),
      currentQuestionIdOption: currQuestIdOpt,
    );
  }

  String? _calculateNewQuestionId() {
    if (state.availableQuestionList.isEmpty) return null;

    String? questionId;

    questionId = _nextUnansweredQuestionId();
    if (questionId != null) return questionId;

    questionId = _previousUnansweredQuestionId();
    if (questionId != null) return questionId;

    questionId = _availableQuestionId();
    if (questionId != null) return questionId;

    return null;
  }

  String? _nextUnansweredQuestionId() {
    int index = state.availableQuestionIndexOrCrash;

    index = state.availableQuestionList
        .indexWhere((element) => !element.answered, index + 1);
    if (index == -1) return null;

    return state.availableQuestionList[index].id;
  }

  String? _previousUnansweredQuestionId() {
    int index = state.availableQuestionIndexOrCrash;

    index = state.availableQuestionList
        .lastIndexWhere((element) => !element.answered, index - 1);
    if (index == -1) return null;

    return state.availableQuestionList[index].id;
  }

  String? _availableQuestionId() {
    int index = state.availableQuestionIndexOrCrash;
    if (index == state.availableQuestionList.length - 1) {
      index--;
    } else {
      index++;
    }
    if (state.availableQuestionList.length <= index || index < 0) return null;

    return state.availableQuestionList[index].id;
  }
}
