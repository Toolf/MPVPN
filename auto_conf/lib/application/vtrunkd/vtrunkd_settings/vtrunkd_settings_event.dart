part of 'vtrunkd_settings_bloc.dart';

@immutable
abstract class VtrunkdSettingsEvent {}

class VtrunkdSettingsUpdateEvent extends VtrunkdSettingsEvent {
  final VtrunkdConfig config;

  VtrunkdSettingsUpdateEvent(this.config);
}
