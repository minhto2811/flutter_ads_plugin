import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'bloc/banner_bloc.dart';

///Banner ad:
class FlutterAdsBanner extends StatefulWidget {
  const FlutterAdsBanner({super.key, this.iosId, this.androidId});

  ///[Product] The parameters [iosId] or [androidId] are required in the production
  ///environment, depending on the target platform.
  ///[Debug] In the debug environment, you can choose to provide or omit the
  ///parameters, as they are already set with test IDs
  ///[Staging] In the staging environment, you need to manually set test IDs for each
  ///target platform. I have provided the IDs below; simply copy and set the appropriate one.
  ///[androidId] 'ca-app-pub-3940256099942544/6300978111'
  /// [iosId] 'ca-app-pub-3940256099942544/2934735716'
  final String? iosId;

  ///[Product] The parameters [iosId] or [androidId] are required in the production
  ///environment, depending on the target platform.
  ///[Debug] In the debug environment, you can choose to provide or omit the
  ///parameters, as they are already set with test IDs
  ///[Staging] In the staging environment, you need to manually set test IDs for each
  ///target platform. I have provided the IDs below; simply copy and set the appropriate one.
  ///[androidId] 'ca-app-pub-3940256099942544/6300978111'
  /// [iosId] 'ca-app-pub-3940256099942544/2934735716'
  final String? androidId;

  @override
  State<FlutterAdsBanner> createState() => _FlutterAdsBannerState();
}

class _FlutterAdsBannerState extends State<FlutterAdsBanner>
    with AutomaticKeepAliveClientMixin {
  final _bloc = BannerBloc();

  @override
  void initState() {
    super.initState();
    _bloc.add(InitialEvent(
      context: context,
      iosId: widget.iosId,
      androidId: widget.androidId,
    ));
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<BannerBloc, BannerState>(
      bloc: _bloc,
      buildWhen: (previous, current) => current is LoadBannerState,
      builder: (context, state) {
        if (state is LoadBannerState && state.ad != null) {
          return SizedBox(
            width: state.ad!.size.width.toDouble(),
            height: state.ad!.size.height.toDouble(),
            child: AdWidget(ad: state.ad!),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
