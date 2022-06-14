import 'network_interface_config.dart';

class MptcpConfig {
  bool onlyDefault;
  late Map<String, NetworkInterfaceConfig> networkInterfaceConfigs;

  late NetworkInterfaceConfig defaultConfig;

  MptcpConfig({
    defaultConfig,
    networkInterfaceConfigs,
    this.onlyDefault = false,
  }) {
    this.defaultConfig = defaultConfig ??
        NetworkInterfaceConfig(
          dev: 'default',
          id: 0,
        );
    this.networkInterfaceConfigs = networkInterfaceConfigs ?? {};
  }

  MptcpConfig.fromJson(Map<String, dynamic> json)
      : onlyDefault = json['onlyDefault'],
        networkInterfaceConfigs = json['networkInterfaceConfigs'],
        defaultConfig = json['defaultConfig'];

  Map<String, dynamic> toJson() => {
        'onlyDefault': onlyDefault,
        'networkInterfaceConfigs': networkInterfaceConfigs,
        'defaultConfig': defaultConfig
      };
}
