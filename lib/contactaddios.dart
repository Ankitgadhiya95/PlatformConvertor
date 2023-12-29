import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:platform/platformconverterprovider.dart';
import 'package:provider/provider.dart';

import 'modelclass.dart';

class ContactAddIos extends StatefulWidget {
  const ContactAddIos({super.key});

  @override
  State<ContactAddIos> createState() => _ContactAddIosState();
}

class _ContactAddIosState extends State<ContactAddIos> {
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
    return CupertinoPageScaffold(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: addcontactkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
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
                        radius: 50,
                        backgroundColor: Color(0XFF1876D2),
                        backgroundImage:
                            (_image != null) ? FileImage(_image!) : null,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            (_image != null)
                                ? Container()
                                : Icon(Icons.camera_alt_outlined,
                                    color: Color(0XFFffffff)),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Icon(CupertinoIcons.person),
                        Expanded(
                          flex: 1,
                          child: CupertinoTextFormFieldRow(
                            placeholder: 'Full Name',
                            controller: _name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter Full Name here";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              name = value;
                            },
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.call_outlined),
                        Expanded(
                          flex: 1,
                          child: CupertinoTextFormFieldRow(
                            controller: _phone,
                            placeholder: 'Phone Number',
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
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(CupertinoIcons.chat_bubble_2),
                        Expanded(
                          flex: 1,
                          child: CupertinoTextFormFieldRow(
                            controller: _chat,
                            placeholder: 'Chat Conversation',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter Chat here";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              chat = value;
                            },
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(5)),
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
                    SizedBox(
                      height: 10,
                    ),
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
                          (formTime != '') ? Text(formTime) : Text("Pick Time"),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CupertinoButton(
                        color: CupertinoColors.activeBlue,
                        child: Text(
                          "SAVE",
                          style: TextStyle(color: CupertinoColors.white),
                        ),
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
                              _name.clear();
                              _chat.clear();
                              _phone.clear();
                              _image = null;
                              formTime = '';
                              formatDate = '';
                            }
                          });
                        })
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
