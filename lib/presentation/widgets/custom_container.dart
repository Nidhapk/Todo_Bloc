import 'package:flutter/material.dart';


class Customcontainer extends StatelessWidget {
  final String leadingText;
  final String title;
  final String discription;
  final String completed;
  final bool isCompleted;
  final Function(String)? onSelected;
  final void Function()? checkBoxOnClicked;

  const Customcontainer(
      {super.key,
      required this.leadingText,
      required this.title,
      required this.discription,
      required this.completed,
      required this.onSelected,
      required this.isCompleted,
      required this.checkBoxOnClicked});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey[850]!
                  : Colors.grey[300]!),
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.grey[900]
              : Colors.white,
        ),
        child: ListTile(
          leading: CircleAvatar(
            child: Text(
              leadingText,
            ),
          ),
          title: Text(
            overflow: TextOverflow.ellipsis,
            title,
            style: TextStyle(
                decoration: isCompleted == true
                    ? TextDecoration.lineThrough
                    : TextDecoration.none),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                'Discription : \n$discription ',
                style: TextStyle(
                    decoration: isCompleted == true
                        ? TextDecoration.lineThrough
                        : TextDecoration.none),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Status :\n$completed',
                style: TextStyle(
                    decoration: isCompleted == true
                        ? TextDecoration.lineThrough
                        : TextDecoration.none),
              )
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: checkBoxOnClicked,
                icon: isCompleted == true
                    ? const Icon(Icons.check_box)
                    : const Icon(Icons.check_box_outline_blank_rounded),
              ),
              PopupMenuButton<String>(
                onSelected: onSelected,
                itemBuilder: (BuildContext context) {
                  return [
                    const PopupMenuItem(
                      value: 'edit',
                      child: Text('Edit'),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Text('Delete'),
                    ),
                  ];
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
