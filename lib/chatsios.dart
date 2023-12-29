import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'modelclass.dart';

class ChatsIos extends StatefulWidget {
  const ChatsIos({super.key});

  @override
  State<ChatsIos> createState() => _ChatsIosState();
}

class _ChatsIosState extends State<ChatsIos> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: Container(
          alignment: Alignment.center,
          child: (contact.isEmpty)
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      "No any chats yet...",
                      //style:
                    ),
                  ],
                )
              : ListView.builder(
                  itemCount: contact.length,
                  itemBuilder: (context, i) {
                    return CupertinoListTile(
                      onTap: () async {
                        showCupertinoModalPopup(
                            context: context,
                            builder: (context) {
                              return Container(
                                height: 300,
                                width: 390,
                                color: CupertinoColors.white,
                                child: Center(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      CircleAvatar(
                                        backgroundColor:
                                            CupertinoColors.inactiveGray,
                                        radius: 40,
                                        backgroundImage:
                                            (contact[i].image != null)
                                                ? FileImage(
                                                    contact[i].image! as File)
                                                : null,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "${contact[i].firstname} ",
                                        style: TextStyle(
                                            fontSize: 25,
                                            color: CupertinoColors.black),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text("${contact[i].chat} ",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: CupertinoColors.black)),
                                      SizedBox(
                                        height: 0,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CupertinoButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              Navigator.of(context).pushNamed(
                                                  '/edit',
                                                  arguments: contact[i]);
                                            },
                                            child: Icon(CupertinoIcons.pencil),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          CupertinoButton(
                                            onPressed: () {
                                              setState(() {
                                                contact.removeAt(i);
                                                Navigator.of(context).pop();
                                              });
                                            },
                                            child: Icon(CupertinoIcons.delete),
                                          ),
                                        ],
                                      ),
                                      CupertinoButton(
                                        color: CupertinoColors.activeBlue,
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          "Cancel",
                                          style: TextStyle(
                                              color: CupertinoColors.white),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      leading: CircleAvatar(
                        backgroundColor: CupertinoColors.inactiveGray,
                        // radius: 50,
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
                              Text(
                                "${contact[i].date},",
                                style: TextStyle(fontSize: 12),
                              ),
                              Text(
                                "${contact[i].time}",
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
