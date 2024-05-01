// import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:jagadbuku_admin/app/data/model/response_buku.dart';

import '../../../data/constant/endpoint.dart';
import 'package:jagadbuku_admin/app/data/provider/api_provider.dart';
import 'package:jagadbuku_admin/app/data/provider/storage_provider.dart';


import '../../../routes/app_pages.dart';


class DetailBukuController extends GetxController with StateMixin<List<DataBuku>> {
  //TODO: Implement DetailBukuController
  final Map<String, dynamic>? args = Get.arguments as Map<String, dynamic>?;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final userId = int.tryParse(StorageProvider.read(StorageKey.idUser) ?? '');
  final bookId = int.tryParse(Get.parameters['id'].toString() ?? '');

  final loading = false.obs;
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // void addToCollection(Map<String, dynamic> args) async {
  //   final id = args['id'];
  //   // if (bookId == null) {
  //   //   // Lakukan penanganan jika bookId bernilai null atau tidak valid
  //   //   Get.snackbar("Error", "ID buku tidak valid", backgroundColor: Colors.red);
  //   //   return;
  //   // }
  //   loading(true);
  //   try {
  //     FocusScope.of(Get.context!).unfocus();
  //     final response = await ApiProvider.instance().post(
  //       Endpoint.koleksi,
  //       data: {
  //         "user_id": userId,
  //         "book_id": id
  //         // int.parse(Get.parameters['id'].toString())
  //         // bookId
  //         ,
  //       },
  //     );
  //     if (response.statusCode == 201) {
  //       Get.offNamed(Routes.DETAIL_BUKU);
  //       Get.snackbar(
  //         "Success",
  //         "Buku berhasil ditambahkan ke koleksi",
  //         backgroundColor: Colors.green,
  //       );
  //     } else {
  //       Get.snackbar(
  //         "Sorry",
  //         "Gagal Menambahkan Buku ke koleksi",
  //         backgroundColor: Colors.orange,
  //       );
  //     }
  //   } on dio.DioException catch (e) {
  //     if (e.response != null && e.response!.data != null) {
  //       Get.snackbar("Sorry", "${e.response!.data['message']}", backgroundColor: Colors.orange);
  //     } else {
  //       Get.snackbar("Sorry", e.message ?? "", backgroundColor: Colors.red);
  //     }
  //   } catch (e) {
  //     Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
  //   } finally {
  //     loading(false);
  //   }
  // }

  void getData() async {
    change(null, status: RxStatus.loading());
    try {
      final response = await ApiProvider.instance().get(Endpoint.buku);
      if (response.statusCode == 200) {
        final ResponseBuku responseBuku = ResponseBuku.fromJson(response.data);
        if (responseBuku.data == null) {
          change(null, status: RxStatus.empty());
        } else {
          change(responseBuku.data as List<DataBuku>?, status: RxStatus.success());
        }
      } else {
        change(null, status: RxStatus.error("Gagal Mngambil data"));
      }
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response?.data != null) {
          change(null, status: RxStatus.error("${e.response?.data['message']}"));
        }
      } else {
        change(null, status: RxStatus.error(e.message ?? ""));
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  Future<void> deleteData(int? id) async {
    try {
      final token = await StorageProvider.read(StorageKey.token);
      final response = await ApiProvider.instance().delete(
        '${Endpoint.buku}/$id', // Endpoint untuk menghapus data dengan ID tertentu
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        // Jika penghapusan berhasil, tampilkan snackbar sukses
        Get.snackbar(
          'Success',
          'Buku berhasil dihapus',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
        Get.offAllNamed(Routes.BUKU);
      } else {
        // Jika penghapusan gagal, tampilkan snackbar error
        Get.snackbar(
          'Error',
          'Failed to delete data',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      // Jika terjadi kesalahan selama proses penghapusan, tampilkan snackbar error dengan pesan kesalahan
      Get.snackbar(
        'Error',
        'An error occurred: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

}

//