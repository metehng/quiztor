part of '../quiz_page.dart';

class _QuizSubmitButton extends ConsumerWidget {
  const _QuizSubmitButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allAnswered =
        ref.watch(quizNotifierProvider.select((state) => state.allAnswered));
    if (!allAnswered) return SizedBox();

    return CustomContainer(
      onTap: () {
        QuizResultPage.pushReplacement(context, ref);
      },
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(24, 0, 24, 16),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(50),
      ),
      child: const Text(
        'Submit',
        style: f16w700,
        textAlign: TextAlign.center,
      ),
    );
  }
}
