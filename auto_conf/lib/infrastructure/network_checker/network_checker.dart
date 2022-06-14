import 'dart:io';

import 'package:auto_conf/domain/mptcp/mptcp_config.dart';
import 'package:auto_conf/domain/vtrunkd/vtrunkd_config.dart';
import 'package:auto_conf/infrastructure/mptcp/mptcp_configurator.dart';
import 'package:auto_conf/infrastructure/vtrunkd/vtrunkd_configurator.dart';

class NetworkChecker {
  final MptcpConfigurator mptcpConfigurator;
  final MptcpConfig mptcpConfig;
  final VtrunkdConfigurator vtrunkdConfigurator;
  final VtrunkdConfig vtrunkdConfig;

  final Map<String, int> _configuredDevices = {};
  static const tablesCount = 10;
  final List<int> tableUnused = List.generate(tablesCount, (i) => i + 101);

  NetworkChecker({
    required this.mptcpConfigurator,
    required this.mptcpConfig,
    required this.vtrunkdConfigurator,
    required this.vtrunkdConfig,
  });

  Future<List<NetworkInterface>> getInrefaces() async {
    final interfaces = await NetworkInterface.list();
    return interfaces;
  }

  Future checkInterfaces() async {
    await mptcpConfigurator.prepare(tablesCount);
    // take current interfaces
    var newInterfaces = await getInrefaces();

    // Remove existed devices
    final removedDevices = Map<String, int>.from(_configuredDevices);
    removedDevices.removeWhere(
      (dev, _) => newInterfaces.any((interface) => interface.name == dev),
    );

    newInterfaces = newInterfaces
        .where(
          (interface) => !_configuredDevices.containsKey(interface.name),
        )
        .toList();

    for (final dev in removedDevices.keys) {
      tableUnused.add(removedDevices[dev]!);
      _configuredDevices.remove(dev);
    }
    // for (final interface in newInterfaces) {
    //   final dev = interface.name;
    //   if (tableUnused.isNotEmpty) {
    //     _configuredDevices[dev] = tableUnused.first;
    //     tableUnused.removeAt(0);
    //     networkInterfaces.add(interface);
    //   }
    // }

    await mptcpConfigurator.configurate(
      mptcpConfig,
      newInterfaces,
      tableUnused,
    );
    await vtrunkdConfigurator.configurate(
      vtrunkdConfig,
      newInterfaces,
    );
  }
}
