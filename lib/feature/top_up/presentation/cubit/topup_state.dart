import 'package:da_technical_assessment/core/enums/enums.dart';
import 'package:equatable/equatable.dart';

class TopUpState extends Equatable {
  StatusEnum status;
  String message;
  String tabName;

  TopUpState({
    this.status = StatusEnum.initial,
    this.message = '',
    this.tabName = '',
  });

  @override
  List<Object> get props => [status, message, tabName];

  TopUpState copyWith({
    StatusEnum? status,
    String? message,
    String? tabName,
  }) {
    return TopUpState(
      status: status ?? this.status,
      message: message ?? this.message,
      tabName: tabName ?? this.tabName,
    );
  }
}
