part of '../quiz_page.dart';

class _QuizQuestionIndicator extends ConsumerWidget {
  const _QuizQuestionIndicator();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizState = ref.watch(quizNotifierProvider);
    final questionList = quizState.quizOrCrash.questionList;

    return SizedBox(
      height: 36,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        itemCount: questionList.length,
        itemBuilder: (context, index) {
          final question = questionList[index];

          final lastItem = index >= questionList.length - 1;

          final color = question.expired
              ? expireedQuestionColor
              : question.answered
                  ? answeredQuestionColor
                  : unansweredQuestionColor;

          final highlightColor = quizState.questionIndex == index;
          final borderColor = highlightColor ? darkColor : Colors.transparent;

          return IgnorePointer(
            ignoring: question.expired,
            child: CustomContainer(
              onTap: () {
                ref.read(quizNotifierProvider.notifier).updateCurrentQuestionId(
                      questionId: question.id,
                    );
              },
              height: 32,
              width: 32,
              margin: EdgeInsets.only(right: lastItem ? 0 : 6),
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: Border.all(
                  color: borderColor,
                  width: 2,
                  strokeAlign: 1,
                ),
              ),
              child: Text((index + 1).toString(), style: f16w700),
            ),
          );
        },
      ),
    );
  }
}
