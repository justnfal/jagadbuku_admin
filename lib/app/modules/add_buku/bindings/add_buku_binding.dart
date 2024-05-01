import 'package:get/get.dart';

import '../controllers/add_buku_controller.dart';

class AddBukuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddBukuController>(
      () => AddBukuController(),
    );
  }
}
