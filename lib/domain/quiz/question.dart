import 'package:equatable/equatable.dart';
import 'package:quiztor/domain/quiz/answer.dart';

class Question extends Equatable {
  final String id;
  final String text;
  final List<Answer> answerList;
  final bool expired;

  const Question({
    required this.id,
    required this.text,
    required this.answerList,
    required this.expired,
  });

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map['id'] as String,
      text: map['text'] as String,
      answerList: List<Answer>.from(
        ((map["answer_list"] ?? []) as List<dynamic>).map(
          (x) => Answer.fromMap(x as Map<String, dynamic>),
        ),
      ),
      expired: map['expired'] as bool? ?? false,
    );
  }

  static const MAX_TIME_SECONDS = 10;

  bool get answered => answerList.any((element) => element.selected);

  @override
  List<Object?> get props => [
        id,
        text,
        answerList,
        expired,
      ];

  Question copyWith({
    String? id,
    String? text,
    List<Answer>? answerList,
    bool? expired,
  }) {
    return Question(
      id: id ?? this.id,
      text: text ?? this.text,
      answerList: answerList ?? this.answerList,
      expired: expired ?? this.expired,
    );
  }
}
