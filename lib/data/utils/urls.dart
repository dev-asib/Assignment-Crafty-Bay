class Urls {
  static const String _baseUrl = "https://ecommerce-api.codesilicon.com/api";

  static const String sliderListUrl = "$_baseUrl/ListProductSlider";
  static const String categoryListUrl = "$_baseUrl/CategoryList";

  static String productListByRemarkUrl(String remark) =>
      "$_baseUrl/ListProductByRemark/$remark";

  static String productListByCategoryUrl(int id) =>
      "$_baseUrl/ListProductByCategory/$id";

  static String productDetailsById(int id) =>
      "$_baseUrl/ProductDetailsById/$id";

  static String verifyEmailUrl(String email) =>
      "$_baseUrl/UserLogin/$email";

  static String verifyOtpUrl(String email, String otp) =>
      "$_baseUrl/VerifyLogin/$email/$otp";
}
