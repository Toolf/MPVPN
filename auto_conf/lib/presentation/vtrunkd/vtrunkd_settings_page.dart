import 'dart:io';

import 'package:auto_conf/application/vtrunkd/vtrunkd_settings/vtrunkd_settings_bloc.dart';
import 'package:auto_conf/infrastructure/vtrunkd/config_storage/vtrunkd_config_storage.dart';
import 'package:auto_conf/presentation/mptcp/mptcp_settings_page.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../common/component/sidebar.dart';
import '../theme/default.dart';

class VtrunkdSettingsPage extends StatelessWidget {
  const VtrunkdSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (_) => VtrunkdSettingsBloc(VtrunkdConfigStorage()),
        child: const VtrunkdSettingsView(),
      ),
    );
  }
}

class VtrunkdSettingsView extends StatelessWidget {
  const VtrunkdSettingsView({Key? key}) : super(key: key);

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
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      const MptcpSettingsPage(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.vpn_lock),
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
                child: prepareVtrunkdConfigView(context)),
          ),
        ),
      ),
    );
  }

  Widget prepareVtrunkdConfigView(BuildContext context) {
    return BlocBuilder<VtrunkdSettingsBloc, VtrunkdSettingsState>(
      builder: (context, state) {
        return Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black),
              ),
              margin: const EdgeInsets.only(top: 10),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextFormField(
                          initialValue: state.config.sessions.length.toString(),
                          decoration: const InputDecoration(
                            hintText: 'Sessions count',
                          ),
                          onChanged: (val) {
                            try {
                              print("update session count");
                              state.config.sessions = List.generate(
                                  int.parse(val), (index) => index + 1);
                              context.read<VtrunkdSettingsBloc>().add(
                                    VtrunkdSettingsUpdateEvent(state.config),
                                  );
                            } catch (e) {
                              print("error");
                              print(e);
                            }
                          },
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextFormField(
                          initialValue: state.config.serverIpAddress.address,
                          decoration: const InputDecoration(
                            hintText: 'Server ip address',
                          ),
                          onChanged: (val) {
                            try {
                              print("update server ip address");
                              state.config.serverIpAddress =
                                  InternetAddress(val);
                              context.read<VtrunkdSettingsBloc>().add(
                                    VtrunkdSettingsUpdateEvent(state.config),
                                  );
                            } catch (e) {
                              print("error");
                              print(e);
                            }
                          },
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextFormField(
                          initialValue: state.config.port.toString(),
                          decoration: const InputDecoration(
                            hintText: 'port',
                          ),
                          onChanged: (val) {
                            try {
                              print("update port");
                              state.config.port = int.parse(val);
                              context.read<VtrunkdSettingsBloc>().add(
                                    VtrunkdSettingsUpdateEvent(state.config),
                                  );
                            } catch (e) {
                              print("error");
                              print(e);
                            }
                          },
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextFormField(
                          initialValue: state.config.configPath,
                          decoration: const InputDecoration(
                            hintText: 'configPath',
                          ),
                          onChanged: (val) {
                            try {
                              print("update config path");
                              state.config.configPath = val;
                              context.read<VtrunkdSettingsBloc>().add(
                                    VtrunkdSettingsUpdateEvent(state.config),
                                  );
                            } catch (e) {
                              print("error");
                              print(e);
                            }
                          },
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
                  "Vtrunkd config",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
