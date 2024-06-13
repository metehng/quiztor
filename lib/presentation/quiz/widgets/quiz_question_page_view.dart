part of '../quiz_page.dart';

class _QuizQuestionPageView extends ConsumerWidget {
  const _QuizQuestionPageView({required this.pageController});
  final PageController pageController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final availableQuestionList = ref.watch(quizNotifierProvider.select(
      (state) => state.availableQuestionList,
    ));

    return PageView.builder(
      controller: pageController,
      itemCount: availableQuestionList.length,
      onPageChanged: (newIndex) {
        _onPageChanged(
          pageController: pageController,
          newIndex: newIndex,
          ref: ref,
        );
      },
      itemBuilder: (context, index) {
        final question = availableQuestionList[index];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _QuizQuestionCounterSection(questionId: question.id),
            _QuizQuestionTextSection(text: question.text),
            _QuizQuestionAnswerSection(
              questionId: question.id,
              answerList: question.answerList,
            ),
          ],
        );
      },
    );
  }

  void _onPageChanged({
    required PageController pageController,
    required int newIndex,
    required WidgetRef ref,
  }) {
    final questionList = ref.read(
        quizNotifierProvider.select((state) => state.availableQuestionList));

    final currIndex = ref.read(
        quizNotifierProvider.select((state) => state.availableQuestionIndex));
    if (pageController.page == null) return;

    final difference = (currIndex.toDouble() - pageController.page!).abs();
    if (difference >= 1) return; //* Prevents multiple page changes

    final quizNotifer = ref.read(quizNotifierProvider.notifier);
    final questionId = questionList[newIndex].id;
    quizNotifer.updateCurrentQuestionId(questionId: questionId);
  }
}
