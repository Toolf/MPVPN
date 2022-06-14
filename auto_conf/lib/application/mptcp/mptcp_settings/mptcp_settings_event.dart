part of 'mptcp_settings_bloc.dart';

@immutable
abstract class MptcpSettingsEvent {}

class MptcpSettingsAddNetworkInterfaceEvent extends MptcpSettingsEvent {}

class MptcpSettingsUpdateNetworkInterfaceEvent extends MptcpSettingsEvent {
  final NetworkInterfaceConfig networkInterfaceConfig;

  MptcpSettingsUpdateNetworkInterfaceEvent({
    required this.networkInterfaceConfig,
  });
}

class MptcpSettingsDeleteNetworkInterfaceEvent extends MptcpSettingsEvent {
  final NetworkInterfaceConfig networkInterfaceConfig;

  MptcpSettingsDeleteNetworkInterfaceEvent({
    required this.networkInterfaceConfig,
  });
}

class MptcpSettingsLoadingEvent extends MptcpSettingsEvent {}
