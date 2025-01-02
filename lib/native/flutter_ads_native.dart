import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'bloc/native_ad_bloc.dart';

class FlutterAdsNative extends StatefulWidget {
  const FlutterAdsNative(
      {super.key,
      this.iosId,
      this.androidId,
      this.factoryId,
      this.templateStyle,
      this.constraints});

  final String? iosId;
  final String? androidId;
  final String? factoryId;
  final NativeTemplateStyle? templateStyle;
  final BoxConstraints? constraints;

  @override
  State<FlutterAdsNative> createState() => _FlutterAdsNativeState();
}

class _FlutterAdsNativeState extends State<FlutterAdsNative> {
  final _bloc = NativeAdBloc();

  @override
  void initState() {
    super.initState();
    _bloc.add(InitialEvent(
        templateStyle: widget.templateStyle,
        iosId: widget.iosId,
        androidId: widget.androidId,
        factoryId: widget.factoryId));
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NativeAdBloc, NativeAdState>(
        bloc: _bloc,
        buildWhen: (previous, current) => current is NativeAdLoadedState,
        builder: (context, state) {
          if (state is NativeAdLoadedState) {
            return ConstrainedBox(
              constraints: widget.constraints ??
                  const BoxConstraints(
                    minWidth: 320, // minimum recommended width
                    minHeight: 320, // minimum recommended height
                    maxWidth: 400,
                    maxHeight: 400,
                  ),
              child: AdWidget(ad: state.nativeAd),
            );
          }
          return const SizedBox.shrink();
        });
  }
}
