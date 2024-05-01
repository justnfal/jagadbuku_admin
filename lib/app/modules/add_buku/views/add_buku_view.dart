import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jagadbuku_admin/app/modules/add_buku/views/Dropdown/Dropdown.dart';

import '../../../data/model/response_buku.dart';
import '../../../data/model/response_kategori.dart';
import '../../../routes/app_pages.dart';
import '../../buku/controllers/buku_controller.dart';
import '../../kategori/controllers/kategori_controller.dart';
import '../controllers/add_buku_controller.dart';
import 'Image_Picker/ImagePicker.dart';

class AddBukuView extends GetView<AddBukuController> {
  const AddBukuView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int selected = controller.selectedCategoryId.value;

    return Scaffold(
      backgroundColor: Color(0xFFD0E2E5),
      appBar: AppBar(
        backgroundColor: Color(0xFF0098DA),
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'ADD BOOK',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        // final int selectedCategoryId = controller.selectedCategoryId.value;
        if (controller.dataKategori.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Form(
              key: controller.formkey1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Obx(() {
                      return Column(
                        children: [
                          controller.selectedImage.value != null
                              ? Image.file(
                            File(controller.selectedImage.value!.path),
                            height: 200,
                            fit: BoxFit.cover,
                          )
                              : const Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Text("No image selected"),
                          ),
                          ElevatedButton(
                            onPressed: controller.pickImageFromGallery,
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.blue,
                              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 24),
                              textStyle: TextStyle(fontSize: 14),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            child: const Text("Pick Image from Gallery"),
                          ),
                        ],
                      );
                    }),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: DropDown(),  // Adjusted
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: controller.judulController,
                    decoration: InputDecoration(
                      labelText: 'Judul',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Masukkan Judul';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: controller.penulisController,
                    decoration: InputDecoration(
                      labelText: 'Penulis',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Masukkan Penulis';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: controller.penerbitController,
                    decoration: InputDecoration(
                      labelText: 'Penerbit',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Masukkan Penerbit';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: controller.deskripsiController,
                    maxLines: null,
                    decoration:
                    InputDecoration(
                      labelText: 'Deskripsi',
                      hintText: 'Deskripsi Buku...',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: controller.tahun_terbitController,
                    decoration: InputDecoration(
                      labelText: 'Tahun Terbit',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Masukkan tahun terbit';
                      }
                      return null;
                    },
                  ),
                  // Datepicker(controller: controller.tahun_terbitController),
                  SizedBox(height: 10),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // XFile? selectedimage = controller.selectedImage.value;
                        // controller.addBook(selectedimage, selected.toString());
                        controller.addBook();
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 65),
                        textStyle: TextStyle(fontSize: 18),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Text("Tambah"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class Datepicker extends StatefulWidget {
  final TextEditingController controller;
  const Datepicker({super.key, required this.controller});

  @override
  State<Datepicker> createState() => _DatepickerState();
}

class _DatepickerState extends State<Datepicker> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      readOnly: true,
      decoration:
      InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        labelText: 'Tahun Terbit',
        hintText: 'Tahun Terbit',
        prefixIcon: const Icon(Icons.date_range_rounded),
        labelStyle: TextStyle(color: Colors.blue),
      ),
      // AppDecorations.textFormFieldDecoration.copyWith(
      //   labelText: 'Tahun Terbit',
      //   hintText: 'Tahun Terbit',
      //   prefixIcon: const Icon(Icons.date_range_rounded),
      // ),
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1000),
          lastDate: DateTime(2040),
        );
        if (picked != null) {
          setState(() {
            widget.controller.text = picked.year.toString();
          });
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Masukan Tahun Terbit';
        }
        return null;
      },
    );
  }
}