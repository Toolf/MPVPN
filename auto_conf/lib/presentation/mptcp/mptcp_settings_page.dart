import 'dart:io';

import 'package:auto_conf/application/mptcp/mptcp_settings/mptcp_settings_bloc.dart';
import 'package:auto_conf/domain/mptcp/network_interface_config.dart';
import 'package:auto_conf/infrastructure/mptcp/config_storage/mptcp_config_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../common/component/sidebar.dart';
import '../theme/default.dart';
import '../vtrunkd/vtrunkd_settings_page.dart';

class MptcpSettingsPage extends StatelessWidget {
  const MptcpSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (_) => MptcpSettingsBloc(MptcpConfigStorage()),
        child: const MptcpSettingsView(),
      ),
    );
  }
}

class MptcpSettingsView extends StatelessWidget {
  const MptcpSettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            prepareSidebar(context),
            prepareContent(context),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (kDebugMode) {
            print("add new network interface");
          }
          context.read<MptcpSettingsBloc>().add(
                MptcpSettingsAddNetworkInterfaceEvent(),
              );
        },
        backgroundColor: mainDarkColor,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget prepareSidebar(BuildContext context) {
    return Sidebar(
      logo: const Icon(
        Icons.logo_dev,
        size: 52,
      ),
      groups: [
        [
          IconButton(
            icon: const Icon(Icons.emoji_transportation),
            iconSize: 48,
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.vpn_lock),
            iconSize: 48,
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, TextFormFieldanimation1, animation2) =>
                      const VtrunkdSettingsPage(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              );
            },
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

  Widget prepareContent(BuildContext context) {
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
              child: BlocBuilder<MptcpSettingsBloc, MptcpSettingsState>(
                builder: (context, state) {
                  if (state is MptcpSettingsInitial) {
                    context
                        .read<MptcpSettingsBloc>()
                        .add(MptcpSettingsLoadingEvent());
                    return Container();
                  }
                  return ListView.builder(
                    itemCount: 1 + state.config.networkInterfaceConfigs.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 0) return defaultNetworkInterface(context);
                      return networkInterface(
                        context,
                        state.config.networkInterfaceConfigs.values
                            .elementAt(index - 1),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget onlyDefaultButton(BuildContext context) {
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

  Widget defaultNetworkInterface(BuildContext context) {
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
                        hintText: 'Ip address',
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

  Widget networkInterface(
      BuildContext context, NetworkInterfaceConfig interfaceConfig) {
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
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextFormField(
                      initialValue: interfaceConfig.dev,
                      decoration: const InputDecoration(
                        hintText: 'Device',
                      ),
                      onChanged: (val) {
                        print("update dev");
                        interfaceConfig.dev = val;
                        context.read<MptcpSettingsBloc>().add(
                              MptcpSettingsUpdateNetworkInterfaceEvent(
                                networkInterfaceConfig: interfaceConfig,
                              ),
                            );
                      },
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextFormField(
                      initialValue: interfaceConfig.ipAddress?.address ?? "",
                      decoration: const InputDecoration(
                        hintText: 'Ip address',
                      ),
                      onChanged: (val) {
                        try {
                          print("update ip address");
                          interfaceConfig.ipAddress = InternetAddress(val);
                          context.read<MptcpSettingsBloc>().add(
                                MptcpSettingsUpdateNetworkInterfaceEvent(
                                  networkInterfaceConfig: interfaceConfig,
                                ),
                              );
                        } catch (e) {
                          print("error");
                        }
                      },
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextFormField(
                      initialValue: interfaceConfig.via?.address ?? "",
                      decoration: const InputDecoration(
                        hintText: 'Via',
                      ),
                      onChanged: (val) {
                        try {
                          print("update via");
                          interfaceConfig.via = InternetAddress(val);
                          context.read<MptcpSettingsBloc>().add(
                                MptcpSettingsUpdateNetworkInterfaceEvent(
                                  networkInterfaceConfig: interfaceConfig,
                                ),
                              );
                        } catch (e) {
                          print("error");
                        }
                      },
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextFormField(
                      initialValue: interfaceConfig.fwmark?.toString() ?? "",
                      decoration: const InputDecoration(
                        hintText: 'Fwmark',
                      ),
                      onChanged: (val) {
                        try {
                          print("update fwmark");
                          interfaceConfig.fwmark = int.parse(val);
                          context.read<MptcpSettingsBloc>().add(
                                MptcpSettingsUpdateNetworkInterfaceEvent(
                                  networkInterfaceConfig: interfaceConfig,
                                ),
                              );
                        } catch (e) {
                          print("error");
                        }
                      },
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextFormField(
                      initialValue: interfaceConfig.metric.toString(),
                      decoration: const InputDecoration(
                        hintText: 'Metric',
                      ),
                      onChanged: (val) {
                        try {
                          print("update metric $val");
                          interfaceConfig.metric = int.parse(val);
                          context.read<MptcpSettingsBloc>().add(
                                MptcpSettingsUpdateNetworkInterfaceEvent(
                                  networkInterfaceConfig: interfaceConfig,
                                ),
                              );
                        } catch (e) {
                          print("error");
                          print(e);
                        }
                      },
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    if (kDebugMode) {
                      print("delete configuration");
                    }
                    context.read<MptcpSettingsBloc>().add(
                          MptcpSettingsDeleteNetworkInterfaceEvent(
                            networkInterfaceConfig: interfaceConfig,
                          ),
                        );
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
            child: Text(
              "Network Interface #${interfaceConfig.id}",
              style: const TextStyle(
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
