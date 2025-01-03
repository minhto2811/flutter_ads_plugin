part of 'native_ad_bloc.dart';

sealed class NativeAdState extends Equatable {
  const NativeAdState();
}

final class NativeAdInitial extends NativeAdState {
  @override
  List<Object> get props => [];
}

final class NativeAdLoadedState extends NativeAdState {
  final NativeAd nativeAd;

  const NativeAdLoadedState({required this.nativeAd});

  @override
  List<Object> get props => [nativeAd];
}
