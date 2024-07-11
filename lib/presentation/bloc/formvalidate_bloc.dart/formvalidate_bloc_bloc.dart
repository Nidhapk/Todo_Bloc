
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todobloc/presentation/bloc/formvalidate_bloc.dart/formvalidate_bloc_event.dart';
import 'package:todobloc/presentation/bloc/formvalidate_bloc.dart/formvalidate_bloc_state.dart';

class FormBloc extends Bloc<FormEvent, FormValidationState> {
  FormBloc() : super(FormInitial()) {
    on<ValidateForm>((event, emit) {
      if (event.title.isEmpty) {
        emit(const FormInvalid('Title cannot be empty'));
      } else if (event.description.isEmpty) {
        emit(const FormInvalid('Description cannot be empty'));
      } else {
        emit(FormValid());
      }
    });
  }
}
