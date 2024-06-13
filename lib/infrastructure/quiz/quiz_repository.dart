import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiztor/domain/quiz/i_quiz_repository.dart';
import 'package:quiztor/domain/quiz/quiz.dart';

final quizRepositoryProvider = Provider<QuizRepository>((ref) {
  return QuizRepository();
});

class QuizRepository extends IQuizRepository {
  @override
  Future<Quiz?> getQuiz() async {
    try {
      final path = 'assets/dummy_data/capital_of_countries.json';
      final response = await rootBundle.loadString(path);

      final map = jsonDecode(response) as Map<String, dynamic>;
      return Quiz.fromMap(map['quiz']);
    } catch (e) {
      return null;
    }
  }
}
