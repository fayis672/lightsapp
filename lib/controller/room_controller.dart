import 'package:get/get.dart';
import 'package:light_app/model/room.dart';

class RoomController extends GetxController {
  final List<Room> rooms = [
    Room("Bed Room", "asset/svg/bed.svg", 4),
    Room("Living Room", "asset/svg/room.svg", 2),
    Room("Kitchen Room", "asset/svg/kitchen.svg", 5),
    Room("Bathroom", "asset/svg/bathtube.svg", 1),
    Room("Outdor", "asset/svg/house.svg", 5),
    Room("Balcony", "asset/svg/balcony.svg", 2),
  ];
}
