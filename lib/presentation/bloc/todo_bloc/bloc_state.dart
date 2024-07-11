import 'package:equatable/equatable.dart';

abstract class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

class TodoInitial extends TodoState {}

class TodoLoading extends TodoState {}

class TodoSuccess extends TodoState {
  final List items;
  const TodoSuccess(this.items);
  @override
  List<Object> get props => [items];
}

class TodoSuccesById extends TodoState {

  final Map<String, dynamic> todo;

  const TodoSuccesById(this.todo);

  @override
  List<Object> get props => [todo];
}

class TodoError extends TodoState {
  final String message;

  const TodoError(this.message);

  @override
  List<Object> get props => [message];
  
}
class TodoUpdateState extends TodoState {
  final List<Map<String, dynamic>> updatedItems; // Example: Updated list of items

  const TodoUpdateState(this.updatedItems);

  @override
  List<Object> get props => [updatedItems];
}