import 'dart:io';
import 'package:flutter/material.dart';
import 'modelclass.dart';

class Calls extends StatefulWidget {
  const Calls({super.key});

  @override
  State<Calls> createState() => _ChatsState();
}

class _ChatsState extends State<Calls> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).backgroundColor,
        alignment: Alignment.center,
        child: (contact.isEmpty)
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  Text(
                    "No any Calls yet...",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              )
            : ListView.builder(
                itemCount: contact.length,
                itemBuilder: (context, i) {
                  return ListTile(
                    onTap: () async {
                      Navigator.of(context)
                          .pushNamed("detailpage", arguments: contact[i]);
                    },
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 26,
                      backgroundImage: (contact[i].image != null)
                          ? FileImage(contact[i].image! as File)
                          : null,
                    ),
                    title: Text("${contact[i].firstname} "),
                    subtitle: Text("+91 ${contact[i].phone}"),
                    trailing: IconButton(
                      icon: Icon(Icons.call, color: Colors.green, size: 33),
                      onPressed: () async {},
                    ),
                  );
                },
              ),
      ),
    );
  }
}
