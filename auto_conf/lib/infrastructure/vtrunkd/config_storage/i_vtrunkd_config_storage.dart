import 'package:auto_conf/domain/vtrunkd/vtrunkd_config.dart';

abstract class IVtrunkdConfigStorage {
  // Save config to storage
  saveConfig(VtrunkdConfig config);
  // Load config of return default configuration
  VtrunkdConfig loadOrDefaultConfig();
}
