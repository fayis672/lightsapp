import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class AnimationCon extends GetxController with SingleGetTickerProviderMixin {
  late AnimationController animationController;
  late AnimationController fadeAnimCon;

  late Animation<Offset> animation;
  late Animation<double> fadeAnim;

  var paddingRate = 4.5.obs;
  var colorPadding = 0.0.obs;
  var isChaged = false.obs;
  var isLightBtn = false.obs;
  var lightbtnIndex = 0.obs;
  var lightPadding = 0.0.obs;

  @override
  void onInit() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));
    animation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.6, 1.0, curve: Curves.fastOutSlowIn)))
      ..addListener(() => update());

    fadeAnimCon = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    fadeAnim = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: fadeAnimCon, curve: Curves.linear))
      ..addListener(() => update());
    super.onInit();
  }

  void slidedown() {
    isChaged.value = true;
    paddingRate.value = 2.5;
    animationController.forward();
    lightPadding.value = 25;
    colorPadding.value = 10;
  }

  void slideup() {
    isChaged.value = false;
    colorPadding.value = 0;
    paddingRate.value = 4.5;
    lightPadding.value = 0;
    animationController.reverse();
  }

  // void lateAnim() {}

  void btnCliked(index) {
    isLightBtn.value = !isLightBtn.value;
    lightbtnIndex.value = index;
  }
}
