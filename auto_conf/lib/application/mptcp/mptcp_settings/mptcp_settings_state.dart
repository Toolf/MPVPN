part of 'mptcp_settings_bloc.dart';

@immutable
abstract class MptcpSettingsState {
  final MptcpConfig config;

  MptcpSettingsState(this.config);
}

class MptcpSettingsInitial extends MptcpSettingsState {
  MptcpSettingsInitial(super.config);
}

class MptcpSettingsUpdated extends MptcpSettingsState {
  MptcpSettingsUpdated(super.config);
}

class MptcpSettingsAddNetworkInterface extends MptcpSettingsState {
  MptcpSettingsAddNetworkInterface(super.config);
}

class MptcpSettingsLoaded extends MptcpSettingsState {
  MptcpSettingsLoaded(super.config);
}
