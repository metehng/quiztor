part of '../quiz_page.dart';

class _QuizQuestionTextSection extends ConsumerWidget {
  const _QuizQuestionTextSection({required this.text});
  final String text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final number = ref.watch(
        quizNotifierProvider.select((value) => value.questionIndexOrCrash + 1));

    return Container(
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height * .4,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      decoration: BoxDecoration(
        color: primaryColor,
        border: Border.all(color: primaryColor),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Align(
            child: Text(
              text,
              style: f18w700,
              textAlign: TextAlign.center,
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: bgColor,
                shape: BoxShape.circle,
              ),
              child: Text(
                number.toString(),
                style: f14w700.copyWith(color: primaryColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
