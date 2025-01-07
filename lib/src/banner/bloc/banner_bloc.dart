import 'package:flutter_ads_plugin/src/admod_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

part 'banner_event.dart';
part 'banner_state.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  BannerBloc() : super(BannerInitial()) {
    on<InitialEvent>(_initialEvent);
  }

  BannerAd? _ad;

  void _initialEvent(InitialEvent event, Emitter<BannerState> emit) async {
    if (_ad != null) return;
    try {
      _ad = await AdModService().getBannerAd(
        context: event.context,
        androidId: event.androidId,
        iosId: event.iosId,
      );
      emit(LoadBannerState(ad: _ad));
    } catch (e) {
      debugPrint('Banner ad error: $e');
    }
  }

  @override
  Future<void> close() {
    _ad?.dispose();
    return super.close();
  }
}
