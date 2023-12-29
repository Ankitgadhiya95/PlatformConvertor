import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform/callsios.dart';
import 'package:platform/chatsios.dart';
import 'package:platform/platformconverterprovider.dart';
import 'package:platform/settingios.dart';
import 'package:provider/provider.dart';
import 'contactaddios.dart';

class IosHomeScreen extends StatefulWidget {
  const IosHomeScreen({super.key, required String title});

  @override
  State<IosHomeScreen> createState() => _IosHomeScreenState();
}

class _IosHomeScreenState extends State<IosHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<PlatformConverterProvider>(context, listen: true);
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Platform Converter"),
        trailing: CupertinoSwitch(
          activeColor: CupertinoColors.activeGreen,
          value: provider.isIos,
          onChanged: (bool value) {
            provider.isIos = value;
          },
        ),
      ),
      child: Center(
        child: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.person_add),
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.chat_bubble_2),
                label: 'CHATS',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.call_outlined),
                label: 'CALLS',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.settings),
                label: 'SETTINGS',
              ),
            ],
          ),
          tabBuilder: (BuildContext context, int index) {
            return CupertinoTabView(
              builder: (BuildContext context) {
                if (index == 0) {
                  return ContactAddIos();
                } else if (index == 1) {
                  return ChatsIos();
                } else if (index == 2) {
                  return CallsIos();
                } else {
                  return SettingsIos();
                }
              },
            );
          },
        ),
      ),
    );
  }
}
