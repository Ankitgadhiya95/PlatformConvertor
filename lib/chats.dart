import 'dart:io';
import 'package:flutter/material.dart';
import 'modelclass.dart';

class Chats extends StatefulWidget {
  const Chats({super.key});

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
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
                    "No any chats yet...",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              )
            : ListView.builder(
                itemCount: contact.length,
                itemBuilder: (context, i) {
                  return ListTile(
                    onTap: () async {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              height: 310,
                              width: 390,
                              child: Center(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 25,
                                    ),
                                    CircleAvatar(
                                      backgroundColor: Colors.grey,
                                      radius: 50,
                                      backgroundImage: (contact[i].image !=
                                              null)
                                          ? FileImage(contact[i].image! as File)
                                          : null,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "${contact[i].firstname} ",
                                      style: TextStyle(fontSize: 25),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text("${contact[i].chat} ",
                                        style: TextStyle(fontSize: 16)),
                                    SizedBox(
                                      height: 18,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            Navigator.of(context).pushNamed(
                                                '/edit',
                                                arguments: contact[i]);
                                          },
                                          icon: Icon(Icons.edit),
                                        ),
                                        SizedBox(
                                          width: 17,
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              contact.removeAt(i);
                                            });
                                          },
                                          icon: Icon(Icons.delete),
                                        ),
                                      ],
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("Cancel"))
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 26,
                      backgroundImage: (contact[i].image != null)
                          ? FileImage(contact[i].image! as File)
                          : null,
                    ),
                    title: Text("${contact[i].firstname} "),
                    subtitle: Text(""
                        "${contact[i].chat}"),
                    trailing: Container(
                      width: 95,
                      height: 55,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("${contact[i].date},"),
                            Text("${contact[i].time},"),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
