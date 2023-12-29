import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'modelclass.dart';

class Contacts extends StatefulWidget {
  const Contacts({super.key});

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  GlobalKey<FormState> addcontactkey = GlobalKey<FormState>();
  TextEditingController _name = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _chat = TextEditingController();
  ImagePicker _picker = ImagePicker();
  File? _image;
  String formatDate = '';
  String formTime = '';

  String? name;
  String? phone;
  String? chat;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).backgroundColor,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            Expanded(
              flex: 2,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      XFile? xfile =
                          await _picker.pickImage(source: ImageSource.camera);
                      String path = xfile!.path;
                      setState(() {
                        _image = File(path);
                      });
                    },
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Color(0XFFEADEFF),
                      backgroundImage:
                          (_image != null) ? FileImage(_image!) : null,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          (_image != null)
                              ? Container()
                              : Icon(Icons.camera_alt_outlined,
                                  color: Color(0XFF21005D)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 8,
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(28),
                  child: Form(
                    key: addcontactkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: _name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter firstname here";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            name = value;
                          },
                          decoration: InputDecoration(
                            hintText: "Full name",
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: _phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Phone number';
                            } else if (value.length != 10) {
                              return "Please enter velid Phone Number";
                            }
                          },
                          onSaved: (value) {
                            phone = value;
                          },
                          keyboardType: TextInputType.number,
                          maxLength: 10,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.call),
                            hintText: "Phone Number",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: _chat,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Chat here";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            chat = value;
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.chat),
                            hintText: "Chat Conversation",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 10),
                        ListTile(
                          title: (formatDate != '')
                              ? Text(formatDate)
                              : Text("Pick Date"),
                          leading: Icon(Icons.date_range),
                          onTap: () async {
                            var date = await showDatePicker(
                                context: context,
                                firstDate: DateTime(1950),
                                lastDate: DateTime(3000),
                                initialDate: DateTime.now());
                            setState(() {
                              print(date);
                              formatDate =
                                  DateFormat('dd/MM/yyyy').format(date!);
                              print(formatDate);
                            });
                          },
                        ),
                        ListTile(
                          title: (formTime != '')
                              ? Text(formTime)
                              : Text("Pick Time"),
                          leading: Icon(Icons.access_time_outlined),
                          onTap: () async {
                            var time = await showTimePicker(
                                context: context, initialTime: TimeOfDay.now());

                            setState(() {
                              final time1 = MaterialLocalizations.of(context);
                              formTime = time1.formatTimeOfDay(time!);
                            });
                          },
                        ),
                        SizedBox(height: 20),
                        OutlinedButton(

                            onPressed: () {
                              setState(() {
                                if (addcontactkey.currentState!.validate()) {
                                  addcontactkey.currentState!.save();
                                  Contact cont = Contact(
                                    firstname: _name.text,
                                    phone: _phone.text,
                                    image: _image,
                                    chat: _chat.text,
                                    date: formatDate,
                                    time: formTime,
                                  );
                                  contact.add(cont);
                                }
                              });
                            },
                            child: Text("Save"))
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
