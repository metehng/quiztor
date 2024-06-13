part of '../quiz_page.dart';

class _QuizQuestionAnswerSection extends ConsumerWidget {
  const _QuizQuestionAnswerSection({
    required this.questionId,
    required this.answerList,
  });

  final String questionId;
  final List<Answer> answerList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Flexible(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        itemCount: answerList.length,
        itemBuilder: (context, index) {
          final answer = answerList[index];
          final selected = answer.selected;

          final borderColor = selected ? primaryColor : unansweredQuestionColor;
          return CustomContainer(
            onTap: () {
              ref
                  .read(quizNotifierProvider.notifier)
                  .answerQuestion(questionId: questionId, answer: answer);
            },
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              border: Border.all(color: borderColor),
              borderRadius: BorderRadius.circular(50),
              color: selected ? primaryColor.withOpacity(.25) : bgColor,
            ),
            child: Text(
              answer.text,
              textAlign: TextAlign.center,
              style: f16w500.copyWith(color: primaryColor),
            ),
          );
        },
      ),
    );
  }
}
