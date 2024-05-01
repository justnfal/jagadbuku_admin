import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart' as p;
import '../../../data/constant/endpoint.dart';
import '../../../data/model/response_kategori.dart';
import '../../../data/provider/api_provider.dart';
import '../../../data/provider/storage_provider.dart';
import '../../../routes/app_pages.dart';

class AddBukuController extends GetxController {
  final formkey1 = GlobalKey<FormState>();
  final TextEditingController judulController = TextEditingController();
  final TextEditingController penulisController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();
  final TextEditingController penerbitController = TextEditingController();
  final TextEditingController tahun_terbitController = TextEditingController();

  final loading = false.obs;
  final Rx<XFile?> selectedImage = Rx<XFile?>(null);
  final RxInt selectedCategoryId = 1.obs;
  final RxList<DataKategori> dataKategori = <DataKategori>[].obs;

  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    getData(); // Mengambil data kategori saat controller diinisialisasi
  }

  Future<void> getData() async {
    try {
      final token = await StorageProvider.read(StorageKey.token);
      final response = await ApiProvider.instance().get(
        Endpoint.kategori,
        options: dio.Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200) {
        final ResponseKategori responseKategori = ResponseKategori.fromJson(response.data);
        dataKategori.assignAll(responseKategori.data ?? []);
        if (dataKategori.isNotEmpty) {
          final firstCategoryId = dataKategori.first.id ?? 1;  // Atur nilai default jika null
          selectedCategoryId.value = firstCategoryId;
        }
      } else {
        Get.snackbar("Error", "Failed to fetch categories", backgroundColor: Colors.red);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch data: $e", backgroundColor: Colors.red);
    }
  }

  Future<void> pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage.value = pickedFile;
    }
  }

  Future<void> addBook() async {
    if (formkey1.currentState?.validate() ?? false) {
      loading(true);
      try {
        final imageFile = selectedImage.value;
        final userData = {
          'kategori_id': selectedCategoryId.value.toString(),
          'judul': judulController.text,
          'penulis': penulisController.text,
          'deskripsi': deskripsiController.text,
          'penerbit': penerbitController.text,
          'tahun_terbit': int.parse(tahun_terbitController.text),
          if (imageFile != null)
            'image': await dio.MultipartFile.fromFile(imageFile.path, filename: p.basename(imageFile.path)),
        };

        final response = await ApiProvider.instance().post(
          Endpoint.buku,
          data: dio.FormData.fromMap(userData),
        );

        if (response.statusCode == 201) {
          Get.offAllNamed(Routes.BUKU);
          Get.snackbar("Success", "Book added successfully", backgroundColor: Colors.green);
        } else {
          Get.snackbar("Error", "Failed to add book", backgroundColor: Colors.red);
        }
      } catch (e) {
        Get.snackbar("Error", "Error adding book: $e", backgroundColor: Colors.red);
      } finally {
        loading(false);
      }
    }
  }
}
