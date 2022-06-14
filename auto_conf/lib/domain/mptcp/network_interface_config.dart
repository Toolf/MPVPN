import 'dart:io';

class NetworkInterfaceConfig {
  int? id;
  String dev; // device name
  int? index;
  int? fwmark; // if null it can be any fwmark
  InternetAddress? ipAddress;
  InternetAddress? via;
  int metric;

  NetworkInterfaceConfig({
    required this.id,
    required this.dev,
    this.index,
    this.fwmark,
    this.ipAddress,
    this.via,
    this.metric = 200,
  });

  NetworkInterfaceConfig.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        dev = json['dev'],
        index = json['index'],
        fwmark = json['fwmark'],
        ipAddress =
            json['ipAddress'] ? InternetAddress(json['ipAddress']) : null,
        via = json['via'] ? InternetAddress(json['via']) : null,
        metric = json['metric'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'dev': dev,
        'index': index,
        'fwmark': fwmark,
        'ipAddress': ipAddress,
        'via': via,
        'metric': metric,
      };
}
