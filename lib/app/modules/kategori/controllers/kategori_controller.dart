import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:jagadbuku_admin/app/data/model/response_kategori.dart';

import '../../../data/constant/endpoint.dart';
import '../../../data/provider/api_provider.dart';
import '../../../data/provider/storage_provider.dart';

class KategoriController extends GetxController with StateMixin<List<DataKategori>>{
  //TODO: Implement KategoriController

  final dio = Dio();
  final _kategoriList = <DataKategori>[].obs;

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

  getData() async {
    change(null, status: RxStatus.loading());
    try {
      final response = await ApiProvider.instance().get(Endpoint.kategori);
      if (response.statusCode == 200) {
        final ResponseKategori responseKategori = ResponseKategori.fromJson(response.data);
        if (responseKategori.data == null) {
          change(null, status: RxStatus.empty());
        } else {
          change(responseKategori.data?.cast<DataKategori>(), status: RxStatus.success());
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
  Future<void> addKategori(String nama) async {
    try {
      final response = await dio.post(
        Endpoint.kategori,
        data: {'nama': nama},
      );
      if (response.statusCode == 201) {
        final data = response.data;
        final kategori = DataKategori.fromJson(data);
        _kategoriList.add(kategori);
        Get.back();
      } else {
        Get.snackbar(
          'Error',
          'Gagal menambahkan kategori',
        );
      }
    } on DioError catch (e) {
      Get.snackbar(
        'Error',
        e.message ?? '',
      );
    }
  }
}