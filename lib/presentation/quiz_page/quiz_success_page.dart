part of 'quiz_page.dart';

class _QuizSuccessPage extends ConsumerStatefulWidget {
  const _QuizSuccessPage();

  @override
  ConsumerState<_QuizSuccessPage> createState() => _QuizSinglePageState();
}

class _QuizSinglePageState extends ConsumerState<_QuizSuccessPage> {
  late final PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();
    final questionId = ref.read(quizNotifierProvider).currentQuestionId;
    ref
        .read(questionCountDownNotifierProvider(questionId).notifier)
        .startTimer();

    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final quizTitle = ref.watch(
      quizNotifierProvider.select((state) => state.quizOrCrash.title),
    );

    ref.listen(
      quizNotifierProvider,
      (previous, current) {
        _availableQuestionIndexNotifierListener(
          prevAvailableQuestionIndex: previous?.availableQuestionIndex,
          currAvailableQuestionIndex: current.availableQuestionIndex,
        );

        _availableQuestionListNotifierListener(
          context: context,
          availableQuestionList: current.availableQuestionList,
        );

        _currentQuestionIdNotifierListener(
          prevCurrentQuestionId: previous?.currentQuestionId,
          currCurrentQuestionId: current.currentQuestionId,
        );
      },
    );

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(quizTitle),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: _QuizQuestionPageView(
                pageController: _pageController,
              ),
            ),
            const SizedBox(height: 16),
            const _QuizQuestionIndicator(),
            const SizedBox(height: 16),
            const _QuizSubmitButton(),
          ],
        ),
      ),
    );
  }

  void _availableQuestionIndexNotifierListener({
    required int? prevAvailableQuestionIndex,
    required int currAvailableQuestionIndex,
  }) {
    if (prevAvailableQuestionIndex == currAvailableQuestionIndex) return;
    if (!_pageController.hasClients) return;

    _pageController.animateToPage(
      currAvailableQuestionIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _currentQuestionIdNotifierListener({
    required String? prevCurrentQuestionId,
    required String currCurrentQuestionId,
  }) {
    if (prevCurrentQuestionId == currCurrentQuestionId) return;

    if (prevCurrentQuestionId != null) {
      ref
          .read(
              questionCountDownNotifierProvider(prevCurrentQuestionId).notifier)
          .pauseTimer();
    }

    ref
        .read(questionCountDownNotifierProvider(currCurrentQuestionId).notifier)
        .startTimer();
  }

  void _availableQuestionListNotifierListener({
    required BuildContext context,
    required List<Question> availableQuestionList,
  }) {
    if (availableQuestionList.isNotEmpty) return;
    QuizResultPage.pushReplacement(context, ref);
  }
}
