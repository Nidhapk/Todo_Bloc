import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todobloc/presentation/bloc/theme_bloc/theme_bloc_bloc.dart';
import 'package:todobloc/presentation/bloc/theme_bloc/theme_bloc_event.dart';
import 'package:todobloc/presentation/bloc/todo_bloc/bloc_bloc.dart';
import 'package:todobloc/presentation/bloc/todo_bloc/bloc_event.dart';
import 'package:todobloc/presentation/bloc/todo_bloc/bloc_state.dart';
import 'package:todobloc/presentation/pages/add_screen.dart';
import 'package:todobloc/presentation/pages/edit_screen.dart';
import 'package:todobloc/presentation/widgets/custom_container.dart';
import 'package:todobloc/presentation/widgets/custom_float.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<TodoBloc>().add(
          FetchTodoEvent(),
        );
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.black12
          : Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'TODO',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              final isDark = context.read<ThemeBloc>().state == ThemeMode.dark;
              context.read<ThemeBloc>().add(ToggleThemeEvent(!isDark));
            },
            icon: Icon(
              Theme.of(context).brightness == Brightness.dark
                  ? Icons.sunny
                  : Icons.nightlight,
              color: const Color.fromARGB(255, 227, 200, 44),
            ),
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: SafeArea(
        child: BlocConsumer<TodoBloc, TodoState>(
          listener: (context, state) {
            if (state is TodoUpdateState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('updated successfully'),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is TodoLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TodoSuccess) {
              return ListView.builder(
                itemCount: state.items.length,
                itemBuilder: (context, index) {
                  final item = state.items[index] as Map;
                  return Customcontainer(
                    isCompleted: item['is_completed'],
                    leadingText: (index + 1).toString(),
                    title: item['title'],
                    discription: item['description'],
                    completed: item['is_completed'].toString() == 'true'
                        ? 'Completed'
                        : 'Not Completed',
                    onSelected: (value) {
                      if (value == 'edit') {
                        Navigator.of(context)
                            .push(
                              MaterialPageRoute(
                                builder: (context) => EditScreen(
                                  id: item['_id'],
                                ),
                              ),
                            )
                            .then(
                              (_) => context.read<TodoBloc>().add(
                                    FetchTodoEvent(),
                                  ),
                            );
                      } else if (value == 'delete') {
                        context.read<TodoBloc>().add(
                              DeleteTodoEvent(
                                item['_id'],
                              ),
                            );
                      }
                    },
                    checkBoxOnClicked: () {
                      context.read<TodoBloc>().add(
                            ToggleCheckboxEvent(
                              id: item['_id'],
                              title: item['title'],
                              description: item['description'],
                              isChecked: !item['is_completed'],
                            ),
                          );
                    },
                  );
                },
              );
            } else if (state is TodoError) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return const Center(
                child: Text('No task has been added'),
              );
            }
          },
        ),
      ),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (context) => const AddScreen(),
                ),
              )
              .then(
                (_) => context.read<TodoBloc>().add(
                      FetchTodoEvent(),
                    ),
              );
        },
      ),
    );
  }
}
