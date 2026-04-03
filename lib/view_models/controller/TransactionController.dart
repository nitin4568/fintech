import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddTransactionVM extends GetxController {
  var isIncome = false.obs;
  var selectedCategory = "Food".obs;
  var imagePath = "".obs;

  final picker = ImagePicker();

  void selectCategory(String category) {
    selectedCategory.value = category;
  }

  Future<void> pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.camera);

    if (picked != null) {
      imagePath.value = picked.path;
    }
  }
}