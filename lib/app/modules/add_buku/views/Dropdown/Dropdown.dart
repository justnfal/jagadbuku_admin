import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jagadbuku_admin/app/modules/add_buku/controllers/add_buku_controller.dart';

class DropDown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddBukuController>();
    return Obx(() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(8),
        ),
        child: DropdownButton<int>(
          isExpanded: true,
          items: controller.dataKategori.map((kategori) {
            return DropdownMenuItem<int>(
              value: kategori?.id,
              child: Text(kategori?.nama ?? "Unknown"), // Safe access to nullable
            );
          }).toList(),
          value: controller.selectedCategoryId.value,
          onChanged: (value) {
            if (value != null) {
              controller.selectedCategoryId.value = value;
            }
          },
          underline: Container(),  // Remove underline
        ),
      );
    });
  }
}
