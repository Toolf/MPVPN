import 'dart:io';

import 'package:auto_conf/domain/mptcp/network_interface_config.dart';
import 'package:flutter/foundation.dart';

import '../../domain/mptcp/mptcp_config.dart';

class MptcpConfigurator {
  _getGatewayAddress(String address) {
    final addressData = address.split(".");
    addressData[3] = "1";
    final routerAddress = addressData.join(".");
    return routerAddress;
  }

  NetworkInterfaceConfig _getInterfaceConfig(
    MptcpConfig config,
    NetworkInterface networkInterface,
  ) {
    for (final networkInterfaceConfig
        in config.networkInterfaceConfigs.values) {
      if (networkInterfaceConfig.ipAddress != null &&
          networkInterfaceConfig.ipAddress != networkInterface.addresses[0]) {
        continue;
      }
      if (networkInterfaceConfig.dev != networkInterface.name) {
        continue;
      }
      if (networkInterfaceConfig.index != null &&
          networkInterfaceConfig.index != networkInterface.index) {
        continue;
      }
      return networkInterfaceConfig;
    }
    return config.defaultConfig;
  }

  prepare(int tableCount) async {
    for (int i = 101; i <= 100 + tableCount; i++) {
      print("ip rule add fwmark 0x$i lookup $i");
      await Process.run("ip", [
        "rule",
        "add",
        "fwmark",
        "0x$i",
        "lookup",
        "$i",
      ]).then((ProcessResult res) {
        if (kDebugMode) {
          print("RESULT:");
          print(res.exitCode);
          print(res.stdout);
          print(res.stderr);
        }
      });
    }
  }

  configurate(
    MptcpConfig config,
    List<NetworkInterface> networkInterfaces,
    List<int> tableUnused,
  ) async {
    for (final networkInterface in networkInterfaces) {
      final networkInterfaceConfig =
          _getInterfaceConfig(config, networkInterface);
      if (networkInterfaceConfig.dev == "") continue;

      final gateway = networkInterfaceConfig.via ??
          _getGatewayAddress(
            networkInterface.addresses[0].address,
          );

      if (tableUnused.isEmpty) {
        if (kDebugMode) {
          print("All tables in used");
        }
        return;
      }

      final tableNumber = tableUnused.first;
      tableUnused.removeAt(0);

      print(
        "ip route add default via $gateway dev ${networkInterfaceConfig.dev} "
        "table $tableNumber metric ${networkInterfaceConfig.metric}",
      );
      await Process.run("ip", [
        "route",
        "add",
        "default",
        "via",
        gateway,
        "dev",
        networkInterfaceConfig.dev,
        "table",
        "$tableNumber",
        "metric",
        "${networkInterfaceConfig.metric}",
      ]).then((ProcessResult res) {
        if (kDebugMode) {
          print(res.exitCode);
          print(res.stdout);
          print(res.stderr);
        }
      });
    }
  }
}
