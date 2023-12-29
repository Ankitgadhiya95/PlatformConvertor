import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platform/platformconverterprovider.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
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
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(children: [
              ListTile(
                leading: Icon(Icons.person),
                title: Text("Profile"),
                subtitle: Text("Update Profile Data"),
                trailing: Switch(
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
                      InkWell(
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
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: name,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration.collapsed(
                            hintText: "Enter your name....",
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: bio,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration.collapsed(
                            hintText: "Enter your Bio....",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            )),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: () {
                                darkTheme.setName = name.text;
                                darkTheme.setBio = bio.text;
                                darkTheme.setImage = _image!.path;
                              },
                              child: Text("Save")),
                          TextButton(
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
                thickness: 0.8,
                color: Colors.grey.shade400,
              ),
              ListTile(
                leading: Icon(Icons.wb_sunny_outlined),
                title: Text("Theme"),
                subtitle: Text("Change Theme"),
                trailing: Switch(
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
