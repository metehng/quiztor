import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiztor/application/question_count_down_notifier/question_count_down_notifier.dart';
import 'package:quiztor/application/quiz_notifier/quiz_notifier.dart';
import 'package:quiztor/domain/quiz/answer.dart';
import 'package:quiztor/domain/quiz/question.dart';
import 'package:quiztor/presentation/constants/colors.dart';
import 'package:quiztor/presentation/constants/text_styles.dart';
import 'package:quiztor/presentation/core/custom_container.dart';
import 'package:quiztor/presentation/quiz_result_page.dart';

part 'quiz_success_page.dart';
part 'widgets/quiz_question_page_view.dart';
part 'widgets/quiz_question_text_section.dart';
part 'widgets/quiz_question_counter_section.dart';
part 'widgets/quiz_question_indicator.dart';
part 'widgets/quiz_question_answer_section.dart';
part 'widgets/quiz_submit_button.dart';

class QuizPage extends ConsumerWidget {
  const QuizPage({super.key});

  static Future<T?> push<T extends Object?>(
    BuildContext context,
    WidgetRef ref,
  ) {
    ref.read(quizNotifierProvider.notifier).fetch();

    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const QuizPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showLoading = ref.watch(
      quizNotifierProvider.select((state) => state.quizOption.isNone()),
    );

    if (showLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return const _QuizSuccessPage();
  }
}
