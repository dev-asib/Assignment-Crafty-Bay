import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/data/models/product_list_model.dart';
import 'package:crafty_bay/data/models/product_model.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utils/urls.dart';
import 'package:get/get.dart';

class ProductListByRemarkController extends GetxController {
  bool _popularInProgress = false;
  bool _newInProgress = false;
  bool _specialInProgress = false;

  bool get popularInProgress => _popularInProgress;

  bool get newInProgress => _newInProgress;

  bool get specialInProgress => _specialInProgress;

  List<ProductModel> _popularProductList = [];
  List<ProductModel> _newProductList = [];
  List<ProductModel> _specialProductList = [];

  List<ProductModel> get popularProductList => _popularProductList;

  List<ProductModel> get newProductList => _newProductList;

  List<ProductModel> get specialProductList => _specialProductList;

  String? _popularErrorMessage;
  String? _newErrorMessage;
  String? _specialErrorMessage;

  String? get popularErrorMessage => _popularErrorMessage;

  String? get newErrorMessage => _newErrorMessage;

  String? get specialErrorMessage => _specialErrorMessage;

  Future<bool> getProductListByRemark(String remark) async {
    bool isSuccess = false;

    if (remark == 'popular') {
      _popularInProgress = true;
    } else if (remark == 'new') {
      _newInProgress = true;
    } else {
      _specialInProgress = true;
    }

    update();

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .getRequest(url: Urls.productListByRemarkUrl(remark));

    if (response.isSuccess) {
      if (remark == 'popular') {
        _popularErrorMessage = null;
        _popularProductList =
            ProductListModel.fromJson(response.responseData).productList ?? [];
      } else if (remark == 'new') {
        _newErrorMessage = null;
        _newProductList =
            ProductListModel.fromJson(response.responseData).productList ?? [];
      } else {
        _specialErrorMessage = null;
        _specialProductList =
            ProductListModel.fromJson(response.responseData).productList ?? [];
      }
      isSuccess = true;
    } else {
      if (remark == 'popular') {
        _popularErrorMessage = response.errorMessage;
      } else if (remark == 'new') {
        _newErrorMessage = response.errorMessage;
      } else {
        _specialErrorMessage = response.errorMessage;
      }
    }

    if (remark == 'popular') {
      _popularInProgress = false;
    } else if (remark == 'new') {
      _newInProgress = false;
    } else {
      _specialInProgress = false;
    }
    update();

    return isSuccess;
  }
}
