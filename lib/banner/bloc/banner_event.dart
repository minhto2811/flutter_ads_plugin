part of 'banner_bloc.dart';

sealed class BannerEvent extends Equatable {
  const BannerEvent();
}

final class InitialEvent extends BannerEvent {
  final BuildContext context;
  final String? iosId;
  final String? androidId;

  const InitialEvent({
    required this.context,
    this.androidId,
    this.iosId,
  });

  @override
  List<Object?> get props => [context, iosId, androidId];
}
