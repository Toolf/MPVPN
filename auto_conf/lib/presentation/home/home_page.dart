import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../common/component/sidebar.dart';
import '../theme/default.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                mainDarkColor,
                mainColor,
              ],
            ),
          ),
          child: Row(
            children: [
              prepareSidebar(),
              prepareContent(),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (kDebugMode) {
              print("add new network interface");
            }
          },
          backgroundColor: mainDarkColor,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget prepareSidebar() {
    return Sidebar(
      logo: const Icon(
        Icons.logo_dev,
        size: 52,
      ),
      groups: [
        [
          IconButton(
            icon: const Icon(Icons.settings),
            iconSize: 48,
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            iconSize: 48,
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            iconSize: 48,
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            iconSize: 48,
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            iconSize: 48,
            onPressed: () {},
          ),
        ]
      ],
      actionButton: IconButton(
        icon: const Icon(Icons.arrow_circle_left_rounded),
        iconSize: 48,
        onPressed: () {},
        padding: EdgeInsets.zero,
      ),
    );
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return mainColor;
    }
    return Colors.black;
  }

  Widget prepareContent() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 30,
          right: 30,
          bottom: 30,
        ),
        child: FractionallySizedBox(
          heightFactor: 1.0,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 30,
                left: 50.0,
                bottom: 50.0,
                right: 50.0,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    onlyDefaultButton(),
                    defaultNetworkInterface(),
                    networkInterface(),
                    networkInterface(),
                    networkInterface(),
                    networkInterface(),
                    networkInterface(),
                    networkInterface(),
                    networkInterface(),
                    networkInterface(),
                    networkInterface(),
                    networkInterface(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget onlyDefaultButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      // Only default
      children: [
        Checkbox(
          checkColor: Colors.white,
          fillColor: MaterialStateProperty.resolveWith(getColor),
          value: false,
          onChanged: (bool? value) {
            if (kDebugMode) {
              print("click");
            }
          },
        ),
        const Text('Only default'),
      ],
    );
  }

  Widget defaultNetworkInterface() {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.black),
          ),
          margin: const EdgeInsets.only(bottom: 30, top: 10),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: const [
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Name',
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Index',
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Fwmark',
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'ipAddress',
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Metric',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 20,
          child: Container(
            color: Colors.white,
            child: const Text(
              "Default Network Interface",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget networkInterface() {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.black),
          ),
          margin: const EdgeInsets.only(bottom: 30, top: 10),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                const Flexible(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Name',
                      ),
                    ),
                  ),
                ),
                const Flexible(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Ip address',
                      ),
                    ),
                  ),
                ),
                const Flexible(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Via',
                      ),
                    ),
                  ),
                ),
                const Flexible(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Fwmark',
                      ),
                    ),
                  ),
                ),
                const Flexible(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Index',
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    if (kDebugMode) {
                      print("delete configuration");
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 20,
          child: Container(
            color: Colors.white,
            child: const Text(
              "Network Interface #1",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
