import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:light_app/controller/animation_controller.dart';
import 'package:light_app/controller/index_controller.dart';
import 'package:light_app/controller/room_controller.dart';
import 'package:light_app/utils/my_colors.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final AnimationCon _animationCon = Get.put(AnimationCon());
  final IndexController _indexController = Get.put(IndexController());
  final List<Color> _lightColor = [
    Colors.pink.withOpacity(0.5),
    Colors.green.withOpacity(0.5),
    Colors.blue.withOpacity(0.5),
    Colors.purple.withOpacity(0.5),
    Colors.cyan.withOpacity(0.5),
    Colors.yellow.withOpacity(0.5),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
          decoration: const BoxDecoration(color: MyColors.blue),
          width: double.infinity,
          height: double.infinity,
          child: Align(
            alignment: Alignment.topLeft,
            child: Obx(() => AnimatedSwitcher(
                reverseDuration: const Duration(milliseconds: 200),
                switchInCurve: Curves.easeIn,
                switchOutCurve: Curves.easeIn,
                duration: const Duration(milliseconds: 200),
                child: _animationCon.isChaged.value
                    ? headSec()
                    : headFirst(context))),
          ),
        ),
        Obx(
          () => AnimatedPadding(
            curve: Curves.easeIn,
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height) /
                _animationCon.paddingRate.value,
            duration: const Duration(milliseconds: 100),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              width: double.infinity,
              height: double.infinity,
              child: GestureDetector(
                onTap: () {
                  _animationCon.slidedown();
                },
                child: Obx(() => AnimatedSwitcher(
                    reverseDuration: const Duration(milliseconds: 200),
                    switchInCurve: Curves.easeIn,
                    switchOutCurve: Curves.easeIn,
                    duration: const Duration(milliseconds: 200),
                    child: _animationCon.isChaged.value
                        ? bottomSec()
                        : bottomFirst())),
              ),
            ),
          ),
        ),
        Obx(() => AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeIn,
              opacity: _animationCon.isChaged.value ? 1 : 0,
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 20,
                ),
                child: Align(
                  child: SvgPicture.asset(
                    'asset/svg/light bulb.svg',
                  ),
                  alignment: Alignment.topRight,
                ),
              ),
            ))
      ],
    );
  }

  Row headFirst(BuildContext context) {
    return Row(
      key: UniqueKey(),
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Control\nPanel",
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        GestureDetector(
          child: SvgPicture.asset('asset/svg/user.svg'),
          onTap: () {
            showModalBottomSheet(
                context: context,
                builder: (contex) {
                  return Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20))),
                    height: 200,
                    child: const Center(
                        child: Text(
                      "Devloped by Fayis Muhammed T.K\nEmail: fayistkm36@gmail.com",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
                  );
                });
          },
        )
      ],
    );
  }

  Column headSec() {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: IconButton(
              onPressed: () {
                _animationCon.slideup();
              },
              icon: SvgPicture.asset(
                  'asset/svg/Icon ionic-md-arrow-round-back.svg')),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            RoomController().rooms[0].name!,
            style: const TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            RoomController().rooms[0].lightsCount.toString() + " Lights",
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.amber),
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        SlideTransition(
          position: _animationCon.animation,
          child: SizedBox(
            height: 50,
            child: ListView.builder(
              itemBuilder: (context, index) {
                // var isCliked = _animationCon.isLightBtn.value == true &&
                //     _animationCon.lightbtnIndex.value == index;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: GestureDetector(
                    onTap: () {
                      _animationCon.btnCliked(index);
                    },
                    child: Obx(() => Container(
                          width: MediaQuery.of(context).size.width / 3,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: _animationCon.isLightBtn.value == true &&
                                      _animationCon.lightbtnIndex.value == index
                                  ? MyColors.deepBlue
                                  : Colors.white),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SvgPicture.asset(_animationCon.isLightBtn.value ==
                                          true &&
                                      _animationCon.lightbtnIndex.value == index
                                  ? 'asset/svg/surface2.svg'
                                  : 'asset/svg/surface1.svg'),
                              Text(
                                "Main Light",
                                style: TextStyle(
                                    color: _animationCon.isLightBtn.value ==
                                                true &&
                                            _animationCon.lightbtnIndex.value ==
                                                index
                                        ? Colors.white
                                        : MyColors.deepBlue,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        )),
                  ),
                );
              },
              itemCount: 4,
              scrollDirection: Axis.horizontal,
            ),
          ),
        ),
      ],
    );
  }

  Column bottomFirst() {
    return Column(
      key: UniqueKey(),
      children: [
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            "All Rooms",
            style: TextStyle(
                color: MyColors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                letterSpacing: 1),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: GridView.count(
            childAspectRatio: 1.2,
            crossAxisCount: 2,
            children: List.generate(6, (index) {
              return Column(
                children: [
                  SvgPicture.asset(RoomController().rooms[index].asset!),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    RoomController().rooms[index].name!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, letterSpacing: 1),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    RoomController().rooms[index].lightsCount.toString() +
                        " Lights",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.amber,
                        fontSize: 12),
                    textAlign: TextAlign.start,
                  ),
                ],
              );
            }),
          ),
        )
      ],
    );
  }

  Column bottomSec() {
    return Column(
      key: UniqueKey(),
      children: [
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Intensity",
            style: TextStyle(
                color: MyColors.blue,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset('asset/svg/solution2.svg'),
            Expanded(
              child: Obx(() => Slider(
                    value: _indexController.sliderValue.value,
                    onChanged: (value) {
                      _indexController.sliderValue.value = value;
                    },
                    min: 1,
                    max: 5,
                    activeColor: Colors.amber,
                    thumbColor: Colors.white,
                  )),
            ),
            SvgPicture.asset('asset/svg/solution.svg'),
          ],
        ),
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Colors",
            style: TextStyle(
                color: MyColors.blue,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 30,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Obx(() => AnimatedPadding(
                    padding: EdgeInsets.symmetric(
                        horizontal: _animationCon.colorPadding.value),
                    duration: const Duration(milliseconds: 100),
                    child: Container(
                      width: 30,
                      decoration: BoxDecoration(
                          color: _lightColor[index],
                          borderRadius: BorderRadius.circular(50)),
                    ),
                  ));
            },
            scrollDirection: Axis.horizontal,
            itemCount: 6,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Scenes",
            style: TextStyle(
                color: MyColors.blue,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 2.5,
            children: List.generate(4, (index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: _lightColor[index],
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset('asset/svg/surface2.svg'),
                      const Text(
                        "Party",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      )
                    ],
                  ),
                ),
              );
            }),
          ),
        )
      ],
    );
  }
}
