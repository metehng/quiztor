import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiztor/presentation/constants/colors.dart';
import 'package:quiztor/presentation/constants/text_styles.dart';
import 'package:quiztor/presentation/core/custom_container.dart';
import 'package:quiztor/presentation/quiz/quiz_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({required this.title});
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
          child: CustomContainer(
        margin: const EdgeInsets.only(bottom: 8),
        shrinkWrap: true,
        onTap: () {
          QuizPage.push(context, ref);
        },
        padding: const EdgeInsets.all(32),
        decoration: const BoxDecoration(
          color: primaryColor,
          shape: BoxShape.circle,
        ),
        child: Text('Start!', style: f20w700),
      )),
    );
  }
}
