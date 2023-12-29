import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platform/platformconverterprovider.dart';
import 'package:provider/provider.dart';

class SettingsIos extends StatefulWidget {
  const SettingsIos({super.key});

  @override
  State<SettingsIos> createState() => _SettingsIosState();
}

class _SettingsIosState extends State<SettingsIos> {
  ImagePicker _picker = ImagePicker();
  File? _image;
  bool profile = false;
  TextEditingController name = TextEditingController();
  TextEditingController bio = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState

    final darkTheme =
        Provider.of<PlatformConverterProvider>(context, listen: false);
    if (darkTheme.getName != '') {
      name.text = darkTheme.getName;
    }
    if (darkTheme.getBio != '') {
      bio.text = darkTheme.getBio;
    }
    if (darkTheme.getImage != '') {
      print("Hello");
      setState(() {
        _image = File(darkTheme.getImage);
      });
      super.initState();
    }
  }

  @override
  Widget build(BuildContext context) {
    final darkTheme =
        Provider.of<PlatformConverterProvider>(context, listen: true);
    return CupertinoPageScaffold(
      child: Center(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(children: [
              CupertinoListTile(
                leading: Icon(
                  CupertinoIcons.person,
                ),
                title: Text("Profile"),
                subtitle: Text("Update Profile Data"),
                trailing: CupertinoSwitch(
                  activeColor: CupertinoColors.activeGreen,
                  value: profile,
                  onChanged: (bool value) {
                    setState(() {
                      profile = value;
                    });
                  },
                ),
              ),
              if (profile == true)
                Container(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          XFile? xfile = await _picker.pickImage(
                              source: ImageSource.camera);
                          String path = xfile!.path;
                          setState(() {
                            _image = File(path);
                          });
                        },
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.blue,
                          backgroundImage:
                              (_image != null) ? FileImage(_image!) : null,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              (_image != null)
                                  ? Container()
                                  : Icon(
                                      CupertinoIcons.camera,
                                      color: CupertinoColors.white,
                                    ),
                            ],
                          ),
                        ),
                      ),
                      CupertinoTextField(
                        controller: name,
                        textAlign: TextAlign.center,
                        placeholder: "Enter your Name....",
                        decoration: BoxDecoration(
                            border: Border.all(style: BorderStyle.none)),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      CupertinoTextField(
                        controller: bio,
                        textAlign: TextAlign.center,
                        placeholder: "Enter your Bio....",
                        decoration: BoxDecoration(
                            border: Border.all(style: BorderStyle.none)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CupertinoButton(
                              onPressed: () {
                                darkTheme.setName = name.text;
                                darkTheme.setBio = bio.text;
                                darkTheme.setImage = _image!.path;
                              },
                              child: Text("Save")),
                          CupertinoButton(
                              onPressed: () {
                                name.clear();
                                bio.clear();
                                darkTheme.setName = '';
                                darkTheme.setBio = '';
                              },
                              child: Text("CLEAR")),
                        ],
                      ),
                    ],
                  ),
                ),
              Divider(
                color: CupertinoColors.systemGrey4,
                thickness: 0.8,
              ),
              CupertinoListTile(
                leading: Icon(CupertinoIcons.sun_max),
                title: Text("Theme"),
                subtitle: Text("Change Theme"),
                trailing: CupertinoSwitch(
                  activeColor: CupertinoColors.activeGreen,
                  value: darkTheme.theme,
                  onChanged: (value) {
                    darkTheme.setDarkTheme = value;
                  },
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
