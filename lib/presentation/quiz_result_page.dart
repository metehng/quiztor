import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiztor/application/quiz_notifier/quiz_notifier.dart';
import 'package:quiztor/presentation/constants/colors.dart';
import 'package:quiztor/presentation/constants/text_styles.dart';
import 'package:quiztor/presentation/core/custom_container.dart';

class QuizResultPage extends ConsumerWidget {
  const QuizResultPage._();

  static Future<T?> pushReplacement<T extends Object?, TO extends Object?>(
    BuildContext context,
    WidgetRef ref,
  ) {
    return Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const QuizResultPage._(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final correctAnswerCount = ref.watch(
      quizNotifierProvider.select((state) => state.correctAnswerCount),
    );

    final wrongAnswerCount = ref.watch(
      quizNotifierProvider.select((state) => state.wrongAnswerCount),
    );

    final unansweredQuestionCount = ref.watch(
      quizNotifierProvider.select((state) => state.unansweredQuestionCount),
    );
    final totalQuestionCount = ref.watch(
      quizNotifierProvider.select((state) => state.totalQuestionCount),
    );

    final point = ((correctAnswerCount / totalQuestionCount) * 100).ceil();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'You have completed the quiz!',
                style: f20w700.copyWith(color: primaryColor),
              ),
              SizedBox(height: 24),
              _QuizResultScoreSection(point: point),
              SizedBox(height: 32),
              _QuizResultDescriptionTile(
                color: correctAnswerColor,
                icon: Icon(
                  Icons.check_rounded,
                  color: bgColor,
                ),
                text: '$correctAnswerCount correct answers',
              ),
              _QuizResultDescriptionTile(
                color: wrongAnswerColor,
                icon: Icon(
                  Icons.close_rounded,
                  color: bgColor,
                ),
                text: '$wrongAnswerCount wrong answers',
              ),
              _QuizResultDescriptionTile(
                color: unansweredQuestionColor,
                icon: Icon(
                  Icons.question_mark_rounded,
                  color: bgColor,
                ),
                text: '$unansweredQuestionCount unanswered questions',
              ),
              SizedBox(height: 48),
              _QuizResultReturnButton(),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuizResultScoreSection extends StatelessWidget {
  const _QuizResultScoreSection({
    required this.point,
  });

  final int point;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 48),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Your score',
            style: f24w700.copyWith(color: bgColor),
          ),
          Text(
            "$point/100",
            style: f48w700,
          ),
        ],
      ),
    );
  }
}

class _QuizResultDescriptionTile extends StatelessWidget {
  const _QuizResultDescriptionTile({
    required this.text,
    required this.icon,
    required this.color,
  });

  final String text;
  final Icon icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: icon,
          ),
          SizedBox(width: 8),
          Text(
            text,
            style: f16w500.copyWith(color: darkColor),
          ),
        ],
      ),
    );
  }
}

class _QuizResultReturnButton extends StatelessWidget {
  const _QuizResultReturnButton();

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Text(
        'Return to the home page',
        style: f16w500,
      ),
      onTap: () {
        Navigator.of(context).pop();
      },
    );
  }
}
