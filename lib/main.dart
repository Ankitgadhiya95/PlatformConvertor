import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform/edit.dart';
import 'package:platform/platformconverterprovider.dart';
import 'package:platform/settings.dart';
import 'package:provider/provider.dart';
import 'calls.dart';
import 'chats.dart';
import 'contactadd.dart';
import 'editios.dart';
import 'ioshome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PlatformConverterProvider())
      ],
      child: Consumer<PlatformConverterProvider>(
          builder: (context, providerios, child) {
        return providerios.isIos == true
            ? CupertinoApp(
                theme: providerios.isDarkMethod == true
                    ? CupertinoThemeData.raw(
                        Brightness.dark,
                        CupertinoColors.activeBlue,
                        Colors.red,
                        CupertinoTextThemeData(
                            primaryColor: CupertinoColors.white),
                        CupertinoColors.darkBackgroundGray,
                        CupertinoColors.black,
                        true)
                    : CupertinoThemeData.raw(
                        Brightness.light,
                        CupertinoColors.activeBlue,
                        CupertinoColors.white,
                        CupertinoTextThemeData(),
                        CupertinoColors.white,
                        CupertinoColors.white,
                        true),
                routes: {
                  '/': (context) => IosHomeScreen(title: 'title'),
                  '/edit': (context) => EditIos(),
                },
                initialRoute: '/',
                debugShowCheckedModeBanner: false,
              )
            : MaterialApp(
                routes: {
                  '/': (context) => MyHomePage(title: 'title'),
                  '/edit': (context) => Edit(),
                },
                title: 'Flutter Demo',
                debugShowCheckedModeBanner: false,
                theme: providerios.isDarkMethod == true
                    ? ThemeData.dark(useMaterial3: true)
                    : ThemeData.light(useMaterial3: true),
                initialRoute: '/',
              );
      }),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<PlatformConverterProvider>(context, listen: true);
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          appBar: AppBar(
            title: Text("Platform Converter"),
            actions: [
              Switch(
                  value: provider.isIos,
                  onChanged: (value) {
                    provider.isIos = value;
                  })
            ],
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.contacts)),
                Tab(text: "CHATS"),
                Tab(text: "CALLS"),
                Tab(text: "SETTINGS"),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Contacts(),
              Chats(),
              Calls(),
              Settings(),
            ],
          )),
    );
  }
}
