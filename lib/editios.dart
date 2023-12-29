import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:platform/platformconverterprovider.dart';
import 'package:provider/provider.dart';
import 'modelclass.dart';

class EditIos extends StatefulWidget {
  const EditIos({super.key});

  @override
  State<EditIos> createState() => _EditIosState();
}

class _EditIosState extends State<EditIos> {
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

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Edit"),
      ),
      child: Container(
               alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Expanded(
              flex: 2,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  GestureDetector(
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
                              : Icon(CupertinoIcons.camera,
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
                        Row(
                          children: [
                            Icon(CupertinoIcons.person),
                            Expanded(
                              flex: 1,
                              child: CupertinoTextFormFieldRow(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10)),
                                controller: _name,
                                onSaved: (value) {
                                  name = value;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Icon(Icons.call_outlined),
                            Expanded(
                              flex: 1,
                              child: CupertinoTextFormFieldRow(
                                controller: _phone,
                                onSaved: (value) {
                                  phone = value;
                                },
                                keyboardType: TextInputType.number,
                                maxLength: 10,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Icon(CupertinoIcons.chat_bubble_2),
                            Expanded(
                              flex: 1,
                              child: CupertinoTextFormFieldRow(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10)),
                                controller: _chat,
                                onSaved: (value) {
                                  chat = value;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            showCupertinoModalPopup(
                              context: context,
                              builder: (BuildContext context) {
                                return Consumer<PlatformConverterProvider>(
                                    builder: (context, providerios, child) {
                                  return Container(
                                    color: providerios.isDarkMethod == true
                                        ? CupertinoColors.black
                                        : CupertinoColors.white,
                                    height: 300,
                                    child: CupertinoDatePicker(
                                      mode: CupertinoDatePickerMode.date,
                                      initialDateTime: DateTime.now(),
                                      onDateTimeChanged: (DateTime value) {
                                        setState(() {
                                          formatDate = DateFormat('dd/MM/yyyy')
                                              .format(value!);
                                          print(formatDate);
                                        });
                                      },
                                    ),
                                  );
                                });
                              },
                            );
                          },
                          child: Row(
                            children: [
                              Icon(CupertinoIcons.calendar),
                              SizedBox(
                                width: 20,
                              ),
                              (formatDate != '')
                                  ? Text(formatDate)
                                  : Text("Pick Date"),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            showCupertinoModalPopup(
                              context: context,
                              builder: (BuildContext context) {
                                return Consumer<PlatformConverterProvider>(
                                    builder: (context, providerios, child) {
                                  return Container(
                                    color: providerios.isDarkMethod == true
                                        ? CupertinoColors.black
                                        : CupertinoColors.white,
                                    height: 300,
                                    child: CupertinoTimerPicker(
                                      mode: CupertinoTimerPickerMode.hms,
                                      onTimerDurationChanged: (Duration value) {
                                        print(value);

                                        setState(() {
                                          formTime =
                                              value.toString().substring(0, 8);
                                        });
                                      },
                                    ),
                                  );
                                });
                              },
                            );
                          },
                          child: Row(
                            children: [
                              Icon(CupertinoIcons.time),
                              SizedBox(
                                width: 20,
                              ),
                              (formTime != '')
                                  ? Text(formTime)
                                  : Text("Pick Time"),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        CupertinoButton(
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
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      "/", (route) => false);
                                });
                              }
                            });
                          },
                          color: CupertinoColors.activeBlue,
                          child: Text(
                            "Save",
                            style: TextStyle(color: CupertinoColors.white),
                          ),
                        )
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
