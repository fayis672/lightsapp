import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:light_app/controller/index_controller.dart';
import 'package:light_app/pages/bulb_page.dart';
import 'package:light_app/pages/home_page.dart';

import 'setting_page.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final IndexController _indexController = Get.put(IndexController());
  final List<Widget> _pages = [
    BulbPage(),
    HomePage(),
    SettingsPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: _pages[_indexController.bottomNavIndex.value],
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                  icon: SvgPicture.asset('asset/svg/bulb.svg'), label: ""),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset('asset/svg/Icon feather-home.svg'),
                  label: ""),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset('asset/svg/Icon feather-settings.svg'),
                  label: ""),
            ],
            onTap: (index) {
              _indexController.bottomNavIndex.value = index;
            },
          ),
        ));
  }
}
