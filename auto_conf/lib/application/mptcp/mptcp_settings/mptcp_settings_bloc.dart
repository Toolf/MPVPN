// ignore_for_file: depend_on_referenced_packages

import 'package:auto_conf/domain/mptcp/mptcp_config.dart';
import 'package:auto_conf/domain/mptcp/network_interface_config.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../infrastructure/mptcp/config_storage/i_mptcp_config_storage.dart';

part 'mptcp_settings_event.dart';
part 'mptcp_settings_state.dart';

class MptcpSettingsBloc extends Bloc<MptcpSettingsEvent, MptcpSettingsState> {
  final IMptcpConfigStorage mptcpConfigStorage;

  int uid = 0;

  MptcpSettingsBloc(this.mptcpConfigStorage)
      : super(MptcpSettingsInitial(MptcpConfig())) {
    on<MptcpSettingsLoadingEvent>((event, emit) {
      print("loading");
      final newState = MptcpSettingsLoaded(
        mptcpConfigStorage.loadOrDefaultConfig(),
      );
      emit(newState);
    });
    on<MptcpSettingsAddNetworkInterfaceEvent>((event, emit) {
      final id = uid + 1;
      uid++;
      final name = (id).toString();
      final newState = MptcpSettingsUpdated(
        state.config,
      );
      newState.config.networkInterfaceConfigs.putIfAbsent(
        name,
        () => NetworkInterfaceConfig(id: id, dev: ""),
      );
      mptcpConfigStorage.saveConfig(newState.config);
      emit(newState);
    });
    on<MptcpSettingsDeleteNetworkInterfaceEvent>((event, emit) {
      final newState = MptcpSettingsUpdated(
        state.config,
      );
      newState.config.networkInterfaceConfigs.removeWhere(
        ((key, interface) => interface.id == event.networkInterfaceConfig.id),
      );
      mptcpConfigStorage.saveConfig(newState.config);
      emit(newState);
    });
    on<MptcpSettingsUpdateNetworkInterfaceEvent>((event, emit) {
      final newState = MptcpSettingsUpdated(
        state.config,
      );
      final name = (event.networkInterfaceConfig.id).toString();
      newState.config.networkInterfaceConfigs.update(
        name,
        (value) => event.networkInterfaceConfig,
      );
      mptcpConfigStorage.saveConfig(newState.config);
      emit(newState);
    });
  }
}
