import 'package:flutter/animation.dart';
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

  @override
  void onInit() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    animation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeIn))
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
    colorPadding.value = 10;
    paddingRate.value = 2.5;
    isChaged.value = true;
    animationController.forward();
  }

  void slideup() {
    colorPadding.value = 0;
    paddingRate.value = 4.5;
    isChaged.value = false;
    animationController.reverse();
  }

  void btnCliked(index) {
    isLightBtn.value = !isLightBtn.value;
    lightbtnIndex.value = index;
  }
}
