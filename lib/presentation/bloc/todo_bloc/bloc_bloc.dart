import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:todobloc/presentation/bloc/todo_bloc/bloc_event.dart';
import 'package:todobloc/presentation/bloc/todo_bloc/bloc_state.dart';
import 'dart:convert';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitial()) {
    on<FetchTodoEvent>(_onFetchTodos);
    on<SubmitTodoEvent>(_onSubmitTodoEvent);
    on<DeleteTodoEvent>(_onDeleteTodo);
    on<FetchTodoEventById>(_onFetchTodoById);
    on<UpdateTodoEvent>(_onUpdateTodo);
    on<ToggleCheckboxEvent>(_onClickedCheckBox);
  }

  Future<void> _onFetchTodos(
      FetchTodoEvent event, Emitter<TodoState> emit) async {
    const url = 'https://api.nstack.in/v1/todos?page=1&limit=10';
    emit(TodoLoading());
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 30));
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map;
        final result = json['items'] as List;
        emit(TodoSuccess(result));
      } else {
        emit(const TodoError('Failed to load todos'));
      }
    } catch (e) {
      emit(TodoError('An error occurred: $e'));
    }
  }

  Future<void> _onSubmitTodoEvent(
      SubmitTodoEvent event, Emitter<TodoState> emit) async {
    emit(TodoLoading());
    final body = {
      "title": event.title.trim(),
      "description": event.discription.trim(),
      "is_completed": false,
    };
    const url = 'https://api.nstack.in/v1/todos';
    try {
      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(const TodoSuccess([]));
      } else {
        emit(TodoError(
            'Error: ${response.statusCode} - ${response.reasonPhrase}'));
      }
    } catch (error) {
      emit(TodoError('An error occurred: $error'));
    }
  }

  Future<void> _onDeleteTodo(
      DeleteTodoEvent event, Emitter<TodoState> emit) async {
    final url = 'https://api.nstack.in/v1/todos/${event.id}';
    emit(TodoLoading());
    try {
      final response = await http.delete(Uri.parse(url));
      if (response.statusCode == 200) {
        
        add(FetchTodoEvent());
      } else {
        emit(TodoError('Failed to delete todo: ${response.reasonPhrase}'));
      }
    } catch (e) {
      emit(TodoError('An error occurred: $e'));
    }
  }

  Future<void> _onFetchTodoById(
      FetchTodoEventById event, Emitter<TodoState> emit) async {
    emit(TodoLoading());
    final url = 'https://api.nstack.in/v1/todos/${event.id}';
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        final todoItem = json['data'] as Map<String, dynamic>;
        emit(TodoSuccesById(todoItem));
      } else {
        emit(const TodoError('Failed to load todo'));
      }
    } catch (e) {
      emit(TodoError('An error occurred: $e'));
    }
  }

  Future<void> _onUpdateTodo(
      UpdateTodoEvent event, Emitter<TodoState> emit) async {
    final url = 'https://api.nstack.in/v1/todos/${event.id}';
    emit(TodoLoading());
    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'title': event.title.trim(),
          'description': event.description.trim(),
        }),
      );

      if (response.statusCode == 200) {
        
        add(FetchTodoEvent());
      } else {
        emit(TodoError('Failed to delete todo: ${response.reasonPhrase}'));
      }
    } catch (e) {
      emit(TodoError('An error occurred: $e'));
    }
  }

  Future<void> _onClickedCheckBox(
      ToggleCheckboxEvent event, Emitter<TodoState> emit) async {
    final url = 'https://api.nstack.in/v1/todos/${event.id}';
    emit(TodoLoading());
    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'title': event.title,
          'description': event.description.trim(),
          'is_completed': event.isChecked,
        }),
      );

      if (response.statusCode == 200) {
        
        add(FetchTodoEvent());
      } else {
        emit(TodoError('Failed to delete todo: ${response.reasonPhrase}'));
      }
    } catch (e) {
      emit(TodoError('An error occurred: $e'));
    }
  }
}
