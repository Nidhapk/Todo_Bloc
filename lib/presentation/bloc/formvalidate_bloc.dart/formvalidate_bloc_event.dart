import 'package:equatable/equatable.dart';

abstract class FormEvent extends Equatable {
  const FormEvent();
}

class ValidateForm extends FormEvent {
  final String title;
  final String description;

  const ValidateForm(this.title, this.description);

  @override
  List<Object> get props => [title, description];
}
