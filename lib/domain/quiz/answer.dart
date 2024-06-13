// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Answer extends Equatable {
  final String id;
  final String text;
  final bool correct;
  final bool selected;

  const Answer({
    required this.id,
    required this.text,
    required this.correct,
    required this.selected,
  });

  factory Answer.fromMap(Map<String, dynamic> map) {
    return Answer(
      id: map['id'] as String,
      text: map['text'] as String,
      correct: map['correct'] as bool,
      selected: map['selected'] as bool? ?? false,
    );
  }
  @override
  List<Object> get props => [id, text, correct, selected];

  Answer copyWith({
    String? id,
    String? text,
    bool? correct,
    bool? selected,
  }) {
    return Answer(
      id: id ?? this.id,
      text: text ?? this.text,
      correct: correct ?? this.correct,
      selected: selected ?? this.selected,
    );
  }
}
