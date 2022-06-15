import 'dart:io';

import 'package:auto_conf/domain/vtrunkd/vtrunkd_config.dart';
import 'package:flutter/foundation.dart';

class VtrunkdConfigurator {
  configurate(
      VtrunkdConfig config, List<NetworkInterface> networkInterfaces) async {
    for (final sessionNumber in config.sessions) {
      await Process.run("vtrunkd", [
        "-P",
        "${config.port}",
        "-f",
        config.configPath,
        "000000_$sessionNumber",
        "${config.serverIpAddress}",
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
