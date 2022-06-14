import 'dart:io';

class VtrunkdConfig {
  List<int> sessions;
  InternetAddress serverIpAddress;
  int port;
  String configPath;

  VtrunkdConfig({
    required this.sessions,
    required this.serverIpAddress,
    required this.port,
    required this.configPath,
  });
}
