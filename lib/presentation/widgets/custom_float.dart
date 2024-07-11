import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final void Function()? onPressed;
  const CustomFloatingActionButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.small(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ?const Color.fromARGB(255, 66, 10, 135)
          : const Color.fromARGB(255, 224, 201, 231),
      foregroundColor: Theme.of(context).brightness == Brightness.dark
          ? const Color.fromARGB(255, 0, 0, 0)
          : Colors.black,
      onPressed: onPressed,
      child: const Icon(Icons.add_task_rounded),
    );
  }
}
