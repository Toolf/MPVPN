import 'dart:io';

import 'package:auto_conf/infrastructure/vtrunkd/config_storage/vtrunkd_config_storage.dart';
import 'package:cron/cron.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'domain/mptcp/mptcp_config.dart';
import 'domain/vtrunkd/vtrunkd_config.dart';
import 'infrastructure/mptcp/config_storage/mptcp_config_storage.dart';
import 'infrastructure/mptcp/mptcp_configurator.dart';
import 'infrastructure/network_checker/network_checker.dart';
import 'infrastructure/vtrunkd/vtrunkd_configurator.dart';
import 'presentation/home/home_page.dart';
import 'presentation/mptcp/mptcp_settings_page.dart';

void main() async {
  final cron = Cron();
  cron.schedule(Schedule.parse('*/10 * * * * *'), () async {
    final mptcpConfigurator = MptcpConfigurator();
    final mptcpConfig = MptcpConfigStorage().loadOrDefaultConfig();
    final vtrunkdConfigurator = VtrunkdConfigurator();
    final vtrunkdConfig = VtrunkdConfigStorage().loadOrDefaultConfig();
    final NetworkChecker networkChecker = NetworkChecker(
      mptcpConfigurator: mptcpConfigurator,
      mptcpConfig: mptcpConfig,
      vtrunkdConfigurator: vtrunkdConfigurator,
      vtrunkdConfig: vtrunkdConfig,
    );
    await networkChecker.checkInterfaces().catchError(
          (e) => print(e),
        );
  });

  await GetStorage.init();
  await GetStorage().erase();
  runApp(const MptcpSettingsPage());
}
