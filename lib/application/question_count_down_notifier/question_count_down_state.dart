import 'package:equatable/equatable.dart';

class QuestionCountDownState extends Equatable {
  final double remainingTimePercentage;

  const QuestionCountDownState({required this.remainingTimePercentage});

  factory QuestionCountDownState.initial() {
    return QuestionCountDownState(
      remainingTimePercentage: 1,
    );
  }

  @override
  List<Object> get props => [remainingTimePercentage];

  QuestionCountDownState copyWith({
    double? remainingTimePercentage,
  }) {
    return QuestionCountDownState(
      remainingTimePercentage:
          remainingTimePercentage ?? this.remainingTimePercentage,
    );
  }
}
