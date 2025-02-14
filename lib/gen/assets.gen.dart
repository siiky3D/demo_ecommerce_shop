/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/app_icon.png
  AssetGenImage get appIcon =>
      const AssetGenImage('assets/images/app_icon.png');

  /// File path: assets/images/bg_splash_screen.jpg
  AssetGenImage get bgSplashScreen =>
      const AssetGenImage('assets/images/bg_splash_screen.jpg');

  /// List of all assets
  List<AssetGenImage> get values => [appIcon, bgSplashScreen];
}

class $AssetsLangsGen {
  const $AssetsLangsGen();

  /// File path: assets/langs/en.json
  String get en => 'assets/langs/en.json';

  /// File path: assets/langs/th.json
  String get th => 'assets/langs/th.json';

  /// List of all assets
  List<String> get values => [en, th];
}

class $AssetsLottiesGen {
  const $AssetsLottiesGen();

  /// File path: assets/lotties/welcom_screen_image1.json
  String get welcomScreenImage1 => 'assets/lotties/welcom_screen_image1.json';

  /// File path: assets/lotties/welcom_screen_image2.json
  String get welcomScreenImage2 => 'assets/lotties/welcom_screen_image2.json';

  /// File path: assets/lotties/welcom_screen_image3.json
  String get welcomScreenImage3 => 'assets/lotties/welcom_screen_image3.json';

  /// List of all assets
  List<String> get values =>
      [welcomScreenImage1, welcomScreenImage2, welcomScreenImage3];
}

class $AssetsProductsGen {
  const $AssetsProductsGen();

  /// File path: assets/products/bruschetta-plate.jpg
  AssetGenImage get bruschettaPlate =>
      const AssetGenImage('assets/products/bruschetta-plate.jpg');

  /// File path: assets/products/flowers-plate.jpg
  AssetGenImage get flowersPlate =>
      const AssetGenImage('assets/products/flowers-plate.jpg');

  /// File path: assets/products/honey-pot.jpg
  AssetGenImage get honeyPot =>
      const AssetGenImage('assets/products/honey-pot.jpg');

  /// File path: assets/products/juicer-citrus-fruits.jpg
  AssetGenImage get juicerCitrusFruits =>
      const AssetGenImage('assets/products/juicer-citrus-fruits.jpg');

  /// File path: assets/products/mozzarella-plate.jpg
  AssetGenImage get mozzarellaPlate =>
      const AssetGenImage('assets/products/mozzarella-plate.jpg');

  /// File path: assets/products/pasta-plate.jpg
  AssetGenImage get pastaPlate =>
      const AssetGenImage('assets/products/pasta-plate.jpg');

  /// File path: assets/products/piggy-blue.jpg
  AssetGenImage get piggyBlue =>
      const AssetGenImage('assets/products/piggy-blue.jpg');

  /// File path: assets/products/piggy-green.jpg
  AssetGenImage get piggyGreen =>
      const AssetGenImage('assets/products/piggy-green.jpg');

  /// File path: assets/products/piggy-pink.jpg
  AssetGenImage get piggyPink =>
      const AssetGenImage('assets/products/piggy-pink.jpg');

  /// File path: assets/products/pizza-plate.jpg
  AssetGenImage get pizzaPlate =>
      const AssetGenImage('assets/products/pizza-plate.jpg');

  /// File path: assets/products/plate-and-bowl.jpg
  AssetGenImage get plateAndBowl =>
      const AssetGenImage('assets/products/plate-and-bowl.jpg');

  /// File path: assets/products/salt-pepper-lemon.jpg
  AssetGenImage get saltPepperLemon =>
      const AssetGenImage('assets/products/salt-pepper-lemon.jpg');

  /// File path: assets/products/salt-pepper-olives.jpg
  AssetGenImage get saltPepperOlives =>
      const AssetGenImage('assets/products/salt-pepper-olives.jpg');

  /// File path: assets/products/snacks-plate.jpg
  AssetGenImage get snacksPlate =>
      const AssetGenImage('assets/products/snacks-plate.jpg');

  /// List of all assets
  List<AssetGenImage> get values => [
        bruschettaPlate,
        flowersPlate,
        honeyPot,
        juicerCitrusFruits,
        mozzarellaPlate,
        pastaPlate,
        piggyBlue,
        piggyGreen,
        piggyPink,
        pizzaPlate,
        plateAndBowl,
        saltPepperLemon,
        saltPepperOlives,
        snacksPlate
      ];
}

class Assets {
  const Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsLangsGen langs = $AssetsLangsGen();
  static const $AssetsLottiesGen lotties = $AssetsLottiesGen();
  static const $AssetsProductsGen products = $AssetsProductsGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
