part of '../quiz_page.dart';

class _QuizQuestionCounterSection extends ConsumerWidget {
  const _QuizQuestionCounterSection({required this.questionId});
  final String questionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      questionCountDownNotifierProvider(questionId)
          .select((value) => value.remainingTimePercentage),
      (previous, next) {
        if (previous == next || next > 0) return;
        ref.read(quizNotifierProvider.notifier).expireQuestion(
              questionId: questionId,
            );
      },
    );

    final remainingTimePercentage = ref.watch(
        questionCountDownNotifierProvider(questionId)
            .select((value) => value.remainingTimePercentage));

    final countDownText =
        "${(remainingTimePercentage * Question.MAX_TIME_SECONDS).ceil()}";

    return SizedBox(
      height: 36,
      width: 36,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
            height: 28,
            width: 28,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: primaryColor,
              shape: BoxShape.circle,
            ),
            child: Text(
              countDownText,
              style: f14w400,
            ),
          ),
          CircularProgressIndicator(
            color: primaryColor,
            strokeAlign: -1,
            value: remainingTimePercentage,
            strokeCap: StrokeCap.round,
            strokeWidth: 3,
          )
        ],
      ),
    );
  }
}
