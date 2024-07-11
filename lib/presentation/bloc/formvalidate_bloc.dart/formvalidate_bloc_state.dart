import 'package:equatable/equatable.dart';

abstract class FormValidationState extends Equatable {
  const FormValidationState();

  @override
  List<Object> get props => [];
}

class FormInitial extends FormValidationState {}

class FormValid extends FormValidationState {}

class FormInvalid extends FormValidationState {
  final String message;

  const FormInvalid(this.message);

  @override
  List<Object> get props => [message];
}
