import 'package:equatable/equatable.dart';
import 'package:quiztor/domain/quiz/question.dart';

class Quiz extends Equatable {
  final String id;
  final String title;
  final List<Question> questionList;

  const Quiz({
    required this.id,
    required this.title,
    required this.questionList,
  });

  @override
  List<Object> get props => [id, title, questionList];

  factory Quiz.fromMap(Map<String, dynamic> map) {
    return Quiz(
      id: map['id'] as String,
      title: map['name'] as String,
      questionList: List<Question>.from(
        ((map["question_list"] ?? []) as List<dynamic>).map(
          (x) => Question.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  Quiz copyWith({
    String? id,
    String? title,
    List<Question>? questionList,
  }) {
    return Quiz(
      id: id ?? this.id,
      title: title ?? this.title,
      questionList: questionList ?? this.questionList,
    );
  }
}
