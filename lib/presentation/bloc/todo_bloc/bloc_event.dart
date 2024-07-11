import 'package:equatable/equatable.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class SubmitTodoEvent extends TodoEvent {
  final String title;
  final String discription;

  const SubmitTodoEvent(this.title, this.discription);

  @override
  List<Object> get props => [title, discription];
}

class FetchTodoEvent extends TodoEvent {}

class DeleteTodoEvent extends TodoEvent {
  final String id;
  const DeleteTodoEvent(this.id);

  @override
  List<Object> get props => [id];
}

class FetchTodoEventById extends TodoEvent {
  final String id;
  const FetchTodoEventById(this.id);

  @override
  List<Object> get props => [id];
}

class UpdateTodoEvent extends TodoEvent {
  final String id;
  final String title;
  final String description;

  const UpdateTodoEvent({
    required this.id,
    required this.title,
    required this.description,
  });

  @override
  List<Object> get props => [id, title, description];
}

class ToggleCheckboxEvent extends TodoEvent {
  final String id;
  final String title;
  final String description;
  final bool isChecked;

  const ToggleCheckboxEvent(
      {required this.id,
      required this.title,
      required this.description,
      required this.isChecked});
}
