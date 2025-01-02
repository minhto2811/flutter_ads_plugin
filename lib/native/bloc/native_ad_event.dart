part of 'native_ad_bloc.dart';

sealed class NativeAdEvent extends Equatable {
  const NativeAdEvent();
}

final class InitialEvent extends NativeAdEvent {
  final String? iosId;
  final String? androidId;
  final String? factoryId;
  final NativeTemplateStyle? templateStyle;

  const InitialEvent({
    this.iosId,
    this.androidId,
    this.factoryId,
    this.templateStyle,
  });

  @override
  List<Object?> get props => [iosId, androidId, factoryId, templateStyle];
}
