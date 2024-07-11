// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todobloc/presentation/bloc/todo_bloc/bloc_bloc.dart';
import 'package:todobloc/presentation/bloc/todo_bloc/bloc_event.dart';
import 'package:todobloc/presentation/bloc/todo_bloc/bloc_state.dart';
import 'package:todobloc/presentation/widgets/custom_button.dart';
import 'package:todobloc/presentation/widgets/custom_sizedbox.dart';
import 'package:todobloc/presentation/widgets/custom_textfield.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final titleController = TextEditingController();

  final descriptionController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.black12
          : Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Add task',
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
        child: BlocListener<TodoBloc, TodoState>(
          listener: (context, state) {
            if (state is TodoSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Todo successfully created!'),
                ),
              );
              Navigator.of(context).pop();
            } else if (state is TodoError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          child: BlocBuilder<TodoBloc, TodoState>(
            builder: (context, state) {
              if (state is TodoLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Form(
                key: formKey,
                child: ListView(
                  children: [
                    CustomTextFormField(
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
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
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
                          final title = titleController.text;
                          final description = descriptionController.text;
                          if (formKey.currentState!.validate()) {
                            context.read<TodoBloc>().add(
                                  SubmitTodoEvent(title, description),
                                );
                          }
                        },
                        text: 'Add')
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
