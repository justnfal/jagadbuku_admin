import 'package:dio/dio.dart';
import 'package:get/get.dart';
// import 'package:jagadUser_admin/app/data/model/response_user.dart';
// import 'package:jagadUser_admin/app/data/services/api_service.dart';

import '../../../data/constant/endpoint.dart';
// import '../../../data/model/response_user.dart';
import '../../../data/provider/api_provider.dart';



class HomeController extends GetxController 
    // with StateMixin<DataUser> 
{
//TODO: Implement HomeController
//   final String loggedInUserId; // Add identifier for the logged-in user
//
//   HomeController(this.loggedInUserId); // Initialize with the user ID


  @override
  void onInit() {
    super.onInit();
    // getData();

  }

  @override
  void onReady() {
    super.onReady();
    // getData();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // getData() async {
  //   change(null, status: RxStatus.loading());
  //   try {
  //     final response = await ApiProvider.instance().get(Endpoint.user);
  //     if (response.statusCode == 200) {
  //       final ResponseUser responseUser = ResponseUser.fromJson(response.data);
  //       if (responseUser.data == null) {
  //         change(null, status: RxStatus.empty());
  //       } else {
  //         change(responseUser.data, status: RxStatus.success());
  //       }
  //     } else {
  //       change(null, status: RxStatus.error("Gagal Mngambil data"));
  //     }
  //   } on DioException catch (e) {
  //     if (e.response != null) {
  //       if (e.response?.data != null) {
  //         change(null, status: RxStatus.error("${e.response?.data['message']}"));
  //       }
  //     } else {
  //       change(null, status: RxStatus.error(e.message ?? ""));
  //     }
  //   } catch (e) {
  //     change(null, status: RxStatus.error(e.toString()));
  //   }
  // }
}
