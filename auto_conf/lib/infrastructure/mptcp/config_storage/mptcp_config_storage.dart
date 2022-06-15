import 'package:auto_conf/domain/mptcp/mptcp_config.dart';
import 'package:get_storage/get_storage.dart';

import '../../../domain/mptcp/network_interface_config.dart';
import 'i_mptcp_config_storage.dart';

class MptcpConfigStorage implements IMptcpConfigStorage {
  static final defaultConfig = MptcpConfig();

  @override
  saveConfig(MptcpConfig config) {
    final box = GetStorage();
    box.write("mptcp_config", config);
    return config;
  }

  @override
  MptcpConfig loadOrDefaultConfig() {
    final box = GetStorage();
    final config =
        box.hasData("mptcp_config") ? box.read("mptcp_config") : defaultConfig;
    return config;
  }
}
