import 'package:get/get.dart';

class PrivateProfileController extends GetxController {
  var counter = 0.obs;

  void increaseCounter() {
    counter.value += 1;
  }
}
