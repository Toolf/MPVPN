import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/vtrunkd/vtrunkd_config.dart';
import '../../../infrastructure/vtrunkd/config_storage/i_vtrunkd_config_storage.dart';

part 'vtrunkd_settings_event.dart';
part 'vtrunkd_settings_state.dart';

class VtrunkdSettingsBloc
    extends Bloc<VtrunkdSettingsEvent, VtrunkdSettingsState> {
  final IVtrunkdConfigStorage vtrunkdConfigStorage;

  int uid = 0;

  VtrunkdSettingsBloc(this.vtrunkdConfigStorage)
      : super(VtrunkdSettingsInitial(VtrunkdConfig(
          configPath: '/etc/vtrunkd.conf',
          port: 6000,
          serverIpAddress: InternetAddress("172.16.5.1"),
          sessions: [1, 2],
        ))) {
    on<VtrunkdSettingsUpdateEvent>((event, emit) {
      final newState = VtrunkdSettingsUpdated(
        event.config,
      );
      emit(newState);
    });
  }
}
