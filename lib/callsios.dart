import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'modelclass.dart';

class CallsIos extends StatefulWidget {
  const CallsIos({super.key});

  @override
  State<CallsIos> createState() => _CallsIosState();
}

class _CallsIosState extends State<CallsIos> {
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
                      "No any Calls yet...",
                    ),
                  ],
                )
              : ListView.builder(
                  itemCount: contact.length,
                  itemBuilder: (context, i) {
                    return CupertinoListTile(
                      onTap: () async {
                        Navigator.of(context)
                            .pushNamed("detailpage", arguments: contact[i]);
                      },
                      leading: CircleAvatar(
                        radius: 26,
                        backgroundImage: (contact[i].image != null)
                            ? FileImage(contact[i].image! as File)
                            : null,
                      ),
                      title: Text("${contact[i].firstname} "),
                      subtitle: Text("+91 ${contact[i].phone}"),
                      trailing: GestureDetector(
                        child: Icon(Icons.call,
                            color: CupertinoColors.activeBlue, size: 25),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
