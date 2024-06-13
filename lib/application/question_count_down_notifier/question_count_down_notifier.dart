import 'dart:async';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiztor/application/question_count_down_notifier/question_count_down_state.dart';
import 'package:quiztor/domain/quiz/question.dart';

final questionCountDownNotifierProvider = StateNotifierProvider.family<
    QuestionCountDownNotifier,
    QuestionCountDownState,
    String>((ref, questionId) {
  return QuestionCountDownNotifier();
});

class QuestionCountDownNotifier extends StateNotifier<QuestionCountDownState> {
  QuestionCountDownNotifier() : super(QuestionCountDownState.initial());
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void pauseTimer() {
    _timer?.cancel();
  }

  void startTimer() {
    const refreshDuration = Duration(milliseconds: 50);
    final progressSeconds =
        refreshDuration.inMilliseconds / 1000 / (Question.MAX_TIME_SECONDS);

    _timer?.cancel();
    _timer = Timer.periodic(
      refreshDuration,
      (timer) {
        final newRemainingTimePercentage =
            max(0.0, state.remainingTimePercentage - progressSeconds);

        state =
            state.copyWith(remainingTimePercentage: newRemainingTimePercentage);
      },
    );
  }
}
