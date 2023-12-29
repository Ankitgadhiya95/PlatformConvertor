import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'modelclass.dart';

class Edit extends StatefulWidget {
  const Edit({super.key});

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
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
    dynamic Allnn = ModalRoute.of(context)!.settings.arguments;
        _name.text = Allnn.firstname;
    _chat.text = Allnn.chat;
    _phone.text = Allnn.phone;
    formatDate = Allnn.date;
    formTime = Allnn.time;
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit"),
      ),
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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: addcontactkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: _name,
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
                              print(formTime);
                            });
                          },
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
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
                                  int i = contact.indexOf(Allnn);
                                  contact[i] = cont;

                                  setState(() {
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                            "/", (route) => false);
                                  });
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
