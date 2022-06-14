import 'dart:io';

import 'package:auto_conf/domain/vtrunkd/vtrunkd_config.dart';
import 'package:get_storage/get_storage.dart';

import 'i_vtrunkd_config_storage.dart';

class VtrunkdConfigStorage implements IVtrunkdConfigStorage {
  static final defaultConfig = VtrunkdConfig(
    configPath: "/etc/vtunkd.conf",
    port: 6000,
    serverIpAddress: InternetAddress("172.16.5.1"),
    sessions: [1, 2],
  );

  @override
  saveConfig(VtrunkdConfig config) {
    print("saved");
    final box = GetStorage();
    box.write("vtrunkd_config", config);
    return config;
    ;
  }

  @override
  VtrunkdConfig loadOrDefaultConfig() {
    final box = GetStorage();
    print(box.hasData("vtrunkd_config"));
    final config = box.hasData("vtrunkd_config")
        ? box.read("vtrunkd_config")
        : defaultConfig;
    return config;
  }
}
