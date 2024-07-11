import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todobloc/presentation/bloc/todo_bloc/bloc_bloc.dart';
import 'package:todobloc/presentation/bloc/todo_bloc/bloc_event.dart';
import 'package:todobloc/presentation/bloc/todo_bloc/bloc_state.dart';
import 'package:todobloc/presentation/widgets/custom_button.dart';
import 'package:todobloc/presentation/widgets/custom_sizedbox.dart';
import 'package:todobloc/presentation/widgets/custom_textfield.dart';

class EditScreen extends StatelessWidget {
  final String id;
  EditScreen({super.key, required this.id});
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    context.read<TodoBloc>().add(
          FetchTodoEventById(id),
        );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Edit task',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
        child: BlocBuilder<TodoBloc, TodoState>(
          builder: (context, state) {
            if (state is TodoSuccesById) {
              titleController.text = state.todo['title'] ?? '';
              descriptionController.text = state.todo['description'] ?? '';
            }
            return Form(
              key: formKey,
              child: ListView(
                children: [
                  CustomTextFormField(
                    // onChanged: (value){},
                    controller: titleController,
                    hintText: 'Enter title here',
                    labelText: 'Title',
                    maxLines: 1,
                    minLines: 1,

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Title cant be empty';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const KsizedBox(),
                  CustomTextFormField(
                    // onChanged: (value){},
                    controller: descriptionController,
                    hintText: 'Enter discription here',
                    keyboardType: TextInputType.multiline,
                    labelText: 'Discription',
                    maxLines: 8,
                    minLines: 4,

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Title cant be empty';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const KsizedBox(),
                  CustomButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<TodoBloc>().add(
                              UpdateTodoEvent(
                                id: id,
                                title: titleController.text.trim(),
                                description: descriptionController.text.trim(),
                              ),
                            );
                        Navigator.of(context).pop();
                        context.read<TodoBloc>().add(
                              FetchTodoEvent(),
                            );
                      }
                    },
                    text: 'Edit',
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
