import 'package:flutter/material.dart';

// Figma Design dimensions for responsive design
const num figmaDesignWidth = 412;
const num figmaDesignHeight = 917;
const num figmaDesignStatusBar = 0;

extension ResponsiveExtension on num {
  double get _width => SizeUtils.width;
  double get _height => SizeUtils.height;

  // Backward-compatible width-based scaling (used widely as `.h` before)
  double get h => ((this * _width) / figmaDesignWidth);

  // Width-based scaling (explicit)
  double get w => ((this * _width) / figmaDesignWidth);

  // Proper vertical scaling based on screen height
  double get v => ((this * _height) / figmaDesignHeight);

  // Uniform scale using the smaller axis (keeps layout pleasant across devices)
  double get r => (this * SizeUtils.scale);

  // Font size scaling using uniform scale (reduces oversized text on tall screens)
  double get fSize => (this * SizeUtils.textScale);
}

extension FormatExtension on double {
  double toDoubleValue({int fractionDigits = 2}) {
    return double.parse(toStringAsFixed(fractionDigits));
  }

  double isNonZero({num defaultValue = 0.0}) {
    return this > 0 ? this : defaultValue.toDouble();
  }
}

enum DeviceType { mobile, tablet, desktop }

typedef ResponsiveBuild =
    Widget Function(
      BuildContext context,
      Orientation orientation,
      DeviceType deviceType,
    );

class Sizer extends StatelessWidget {
  const Sizer({super.key, required this.builder});

  final ResponsiveBuild builder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeUtils.setScreenSize(constraints, orientation);
            return builder(context, orientation, SizeUtils.deviceType);
          },
        );
      },
    );
  }
}

class SizeUtils {
  static late BoxConstraints boxConstraints;
  static late Orientation orientation;
  static late DeviceType deviceType;
  static late double height;
  static late double width;

  // Uniform scale and text scale
  static late double scale;
  static late double textScale;

  static void setScreenSize(
    BoxConstraints constraints,
    Orientation currentOrientation,
  ) {
    boxConstraints = constraints;
    orientation = currentOrientation;
    if (orientation == Orientation.portrait) {
      width = boxConstraints.maxWidth.isNonZero(defaultValue: figmaDesignWidth);
      height = boxConstraints.maxHeight.isNonZero();
    } else {
      width = boxConstraints.maxHeight.isNonZero(
        defaultValue: figmaDesignWidth,
      );
      height = boxConstraints.maxWidth.isNonZero();
    }
    deviceType = DeviceType.mobile;

    final widthScale = width / figmaDesignWidth;
    final heightScale = height / figmaDesignHeight;

    // Use the smaller scale to keep UI balanced across devices
    scale = widthScale < heightScale ? widthScale : heightScale;

    // Text scale follows uniform scale with sane clamp to avoid extremes
    textScale = scale.clamp(0.9, 1.15);
  }
}