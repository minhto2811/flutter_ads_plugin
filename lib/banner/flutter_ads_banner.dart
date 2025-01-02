import 'package:flutter/material.dart';
import 'package:flutter_ads_plugin/banner/bloc/banner_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class FlutterAdsBanner extends StatefulWidget {
  const FlutterAdsBanner({super.key, this.iosId, this.androidId});

  final String? iosId;
  final String? androidId;

  @override
  State<FlutterAdsBanner> createState() => _FlutterAdsBannerState();
}

class _FlutterAdsBannerState extends State<FlutterAdsBanner> {
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
}
