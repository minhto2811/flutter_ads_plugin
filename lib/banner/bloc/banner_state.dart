part of '../bloc/banner_bloc.dart';

sealed class BannerState extends Equatable {
  const BannerState();
}

final class BannerInitial extends BannerState {
  @override
  List<Object> get props => [];
}


final class LoadBannerState extends BannerState {
  final BannerAd? ad;

  const LoadBannerState({required this.ad});

  @override
  List<Object?> get props => [ad];
}

