import 'dart:convert';
import 'package:http/http.dart' as http;

class PostData {
  List<String> _res = [];

  List<String> get getRes => _res;

  void setResult() {
    _res = [];
  }

  Future<void> postData1(String value1, String value2) async {
    Map<String, dynamic> data = {
      'title': value1,
      'body': value2,
    };
    try {
      final response = await http.post(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 201) {
        _res.add('Успешно отправлено(Информация об артикуле)');
        //print('Успешно отправлено(Информация об артикуле): ${response.body}');
      } else {
        _res.add('Ошибка(Информация об артикуле): ${response.statusCode}');
        //print('Ошибка(Информация об артикуле): ${response.statusCode}');
      }
    } catch (error) {
      _res.add('Ошибка при выполнении запроса(Информация об артикуле): $error');
      //print('Ошибка при выполнении запроса(Информация об артикуле): $error');
    }
  }

  Future<void> postData2(
      int index, String value1, String value2, var value3) async {
    var url2 = 'https://jsonplaceholder.typicode.com/posts';
    Map<String, dynamic> data2 = {
      'userId': int.parse(value1[index]),
      'title': value2[index],
      'body': value3![index] ?? '0',
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
        _res.add('Успешно отправлено(Материал)');
        //print('Успешно отправлено(Материал): ${response2.body}');
      } else {
        _res.add('Ошибка(Материал): ${response2.statusCode}');
        //print('Ошибка(Материал): ${response2.statusCode}');
      }
    } catch (error) {
      _res.add('Ошибка при выполнении запроса(Материал): $error');
      //print('Ошибка при выполнении запроса(Материал): $error');
    }
  }

  Future<void> postData3(String value1, String value2, String? value3) async {
    var url3 = 'https://jsonplaceholder.typicode.com/posts';

    Map<String, dynamic> data3 = {
      'title': value1,
      'userId': int.parse(value2),
      'body': value3,
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
        _res.add('Успешно отправлено(Фурнитура)');
        //print('Успешно отправлено(Фурнитура): ${response3.body}');
      } else {
        _res.add('Ошибка(Фурнитура): ${response3.statusCode}');
        //print('Ошибка(Фурнитура): ${response3.statusCode}');
      }
    } catch (error) {
      _res.add('Ошибка при выполнении запроса(Фурнитура): $error');
      //print('Ошибка при выполнении запроса(Фурнитура): $error');
    }
  }
}
