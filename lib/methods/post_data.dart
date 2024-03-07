import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostData {
  Future<void> postData1(var value1, var value2) async {
    Map<String, dynamic> data = {
      'number': value1.text,
      'description': value2.text,
    };
    try {
      final response = await http.post(
        Uri.parse('https://intern.salamhalal.info/api/article/'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 201) {
        print('Успешно отправлено(Информация об артикуле): ${response.body}');
      } else {
        print('Ошибка(Информация об артикуле): ${response.statusCode}');
      }
    } catch (error) {
      print('Ошибка при выполнении запроса(Информация об артикуле): $error');
    }
  }

  Future<void> postData2(int index, var value1, var value2, var value3) async {
    var url2 = 'https://intern.salamhalal.info/api/article_item/';
    Map<String, dynamic> data2 = {
      'quantity': int.parse(value1![index].text),
      'article': int.parse(value2![index].text),
      'item': int.parse(value3![index] ?? '0'),
    };

    try {
      final response2 = await http.post(
        Uri.parse(url2),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data2),
      );

      if (response2.statusCode == 201) {
        print('Успешно отправлено(Материал): ${response2.body}');
      } else {
        print('Ошибка(Материал): ${response2.statusCode}');
      }
    } catch (error) {
      print('Ошибка при выполнении запроса(Материал): $error');
    }
  }

  Future<void> postData3(TextEditingController value1, String? value2,
      TextEditingController value3) async {
    var url3 = 'https://intern.salamhalal.info/api/item/';
// _furnitureAndColorController _strFurnitureUnitMeasurement _furnitureQuantityPerProductController
    Map<String, dynamic> data3 = {
      'name': value1.text,
      'item_type': value2,
      'measurement': int.parse(value3.text),
    };
    try {
      final response3 = await http.post(
        Uri.parse(url3),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data3),
      );

      if (response3.statusCode == 201) {
        print('Успешно отправлено(Фурнитура): ${response3.body}');
      } else {
        print('Ошибка(Фурнитура): ${response3.statusCode}');
      }
    } catch (error) {
      print('Ошибка при выполнении запроса(Фурнитура): $error');
    }
  }
}
