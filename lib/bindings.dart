import 'package:get/get.dart';
import 'package:lexi_learn/controller/main_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MainController(), permanent: true);
  }

}