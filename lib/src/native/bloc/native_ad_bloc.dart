import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_ads_plugin/src/admod_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

part 'native_ad_event.dart';
part 'native_ad_state.dart';

class NativeAdBloc extends Bloc<NativeAdEvent, NativeAdState> {
  NativeAdBloc() : super(NativeAdInitial()) {
    on<InitialEvent>(_init);
  }

  NativeAd? _nativeAd;

  void _init(InitialEvent event, Emitter<NativeAdState> emit) async {
    if (_nativeAd != null) return;
    try {
      _nativeAd = await AdModService().getNativeAd(
          androidId: event.androidId,
          iosId: event.iosId,
          factoryId: event.factoryId,
          templateStyle: event.templateStyle,
          templateType: event.templateType);
      if (_nativeAd == null) return;
      emit(NativeAdLoadedState(nativeAd: _nativeAd!));
    } catch (e) {
      debugPrint('Native ad error: $e');
    }
  }

  @override
  Future<void> close() {
    _nativeAd?.dispose();
    return super.close();
  }
}
