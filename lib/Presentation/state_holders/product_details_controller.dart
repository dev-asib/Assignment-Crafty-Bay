import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/data/models/product_details_model.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utils/urls.dart';
import 'package:get/get.dart';

class ProductDetialsController extends GetxController {
  bool _inProgress = false;
  ProductDetailsModel? _productDetailsModel;
  String? _errorMessage;

  bool get inProgress => _inProgress;

  ProductDetailsModel? get productDetailsModel => _productDetailsModel;

  String? get errorMessage => _errorMessage;

  Future<bool> getProductDetails(int id) async {
    bool isSuccess = false;

    _inProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .getRequest(url: Urls.productDetailsById(id));

    if (response.isSuccess) {
      _productDetailsModel =
          ProductDetailsModel.fromJson(response.responseData['data'][0]);
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();

    return isSuccess;
  }
}
