import '../../../domain/mptcp/mptcp_config.dart';

abstract class IMptcpConfigStorage {
  // Save config to storage
  saveConfig(MptcpConfig config);
  // Load config of return default configuration
  MptcpConfig loadOrDefaultConfig();
}
