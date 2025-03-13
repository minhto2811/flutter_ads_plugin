import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'bloc/native_ad_bloc.dart';

///Native ad
class FlutterAdsNative extends StatefulWidget {
  const FlutterAdsNative(
      {super.key,
      this.iosId,
      this.androidId,
      this.factoryId,
      this.templateStyle,
      this.constraints,
      this.templateType});

  ///[Product] The parameters [iosId] or [androidId] are required in the production
  ///environment, depending on the target platform.
  ///[Debug] In the debug environment, you can choose to provide or omit the
  ///parameters, as they are already set with test IDs
  ///[Staging] In the staging environment, you need to manually set test IDs for each
  ///target platform. I have provided the IDs below; simply copy and set the appropriate one.
  ///[androidId] 'ca-app-pub-3940256099942544/2247696110'
  /// [iosId] 'ca-app-pub-3940256099942544/3986624511'
  final String? iosId;

  ///[Product] The parameters [iosId] or [androidId] are required in the production
  ///environment, depending on the target platform.
  ///[Debug] In the debug environment, you can choose to provide or omit the
  ///parameters, as they are already set with test IDs
  ///[Staging] In the staging environment, you need to manually set test IDs for each
  ///target platform. I have provided the IDs below; simply copy and set the appropriate one.
  ///[androidId] 'ca-app-pub-3940256099942544/2247696110'
  /// [iosId] 'ca-app-pub-3940256099942544/3986624511'
  final String? androidId;

  ///[factoryId] Factory ID for creating the Native Ad view
  final String? factoryId;

  ///[templateStyle] Template style for the ad (if any)
  final NativeTemplateStyle? templateStyle;

  ///[constraints] Size constraints for the ad
  final BoxConstraints? constraints;

  ///[templateType] Template type for the ad (e.g., small, medium)
  final TemplateType? templateType;

  @override
  State<FlutterAdsNative> createState() => _FlutterAdsNativeState();
}

class _FlutterAdsNativeState extends State<FlutterAdsNative>
    with AutomaticKeepAliveClientMixin {
  final _bloc = NativeAdBloc();

  @override
  void initState() {
    super.initState();
    _bloc.add(InitialEvent(
        templateStyle: widget.templateStyle,
        iosId: widget.iosId,
        androidId: widget.androidId,
        factoryId: widget.factoryId,
        templateType: widget.templateType));
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<NativeAdBloc, NativeAdState>(
        bloc: _bloc,
        buildWhen: (previous, current) => current is NativeAdLoadedState,
        builder: (context, state) {
          if (state is NativeAdLoadedState) {
            final constraints = widget.constraints ??
                (widget.templateType == TemplateType.small
                    ? const BoxConstraints(
                        maxHeight: 100,
                        maxWidth: 1000,
                      )
                    : const BoxConstraints(
                        maxHeight: 200,
                        maxWidth: 1000,
                      ));
            return ConstrainedBox(
              constraints: constraints,
              child: AdWidget(ad: state.nativeAd),
            );
          }
          return const SizedBox.shrink();
        });
  }

  @override
  bool get wantKeepAlive => true;
}
