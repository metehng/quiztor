import 'package:quiztor/domain/quiz/quiz.dart';

abstract class IQuizRepository {
  Future<Quiz?> getQuiz();
}
