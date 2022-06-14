part of 'vtrunkd_settings_bloc.dart';

@immutable
abstract class VtrunkdSettingsState {
  final VtrunkdConfig config;

  VtrunkdSettingsState(this.config);
}

class VtrunkdSettingsInitial extends VtrunkdSettingsState {
  VtrunkdSettingsInitial(super.config);
}

class VtrunkdSettingsUpdated extends VtrunkdSettingsState {
  VtrunkdSettingsUpdated(super.config);
}
