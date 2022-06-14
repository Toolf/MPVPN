import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  final Widget logo;
  final IconButton? actionButton;
  final List<List<IconButton>> groups;

  const Sidebar({
    Key? key,
    this.actionButton,
    required this.logo,
    required this.groups,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      child: Padding(
        padding: const EdgeInsets.only(top: 30, bottom: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            logo,
            Column(
              children: [
                prepareGroups(),
                actionButton ?? Container(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget prepareGroups() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: groups
              .map(
                (group) => Column(
                  children: group,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
