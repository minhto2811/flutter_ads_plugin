part of 'native_ad_bloc.dart';

sealed class NativeAdEvent extends Equatable {
  const NativeAdEvent();
}

final class InitialEvent extends NativeAdEvent {
  final String? iosId;
  final String? androidId;
  final String? factoryId;
  final NativeTemplateStyle? templateStyle;
  final TemplateType? templateType;

  const InitialEvent({
    this.iosId,
    this.androidId,
    this.factoryId,
    this.templateStyle,
    this.templateType,
  });

  @override
  List<Object?> get props => [iosId, androidId, factoryId, templateStyle];
}
