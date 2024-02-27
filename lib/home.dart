import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

//_numberController _descriptionController _materialAndColorController _quantityPerProductController _unitMeasurementController

class _HomeScreenState extends State<HomeScreen> {
  // TextEditingController -----------------------------------------------------
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  List<TextEditingController>? _materialAndColorController = [
    TextEditingController()
  ];
  List<TextEditingController>? _quantityPerProductController = [
    TextEditingController()
  ];
  List<TextEditingController>? _unitMeasurementController = [
    TextEditingController()
  ];

  /* final TextEditingController _materialAndColorController =
      TextEditingController();
  final TextEditingController _quantityPerProductController =
      TextEditingController();
  final TextEditingController _unitMeasurementController =
      TextEditingController(); */

  final TextEditingController _showMaterialAndColorController =
      TextEditingController();
  // _materialAndColorController _quantityPerProductController _unitMeasurementController

  //
  final TextEditingController _quantityPerProductController2 =
      TextEditingController();
  final TextEditingController _unitMeasurementController2 =
      TextEditingController();

  //furniture
  //_furnitureAndColorController _furnitureQuantityPerProductController _furnitureUnitMeasurementController
  final TextEditingController _furnitureAndColorController =
      TextEditingController();
  final TextEditingController _furnitureQuantityPerProductController =
      TextEditingController();
  final TextEditingController _furnitureUnitMeasurementController =
      TextEditingController();

  // Color ---------------------------------------------------------------------
  Color _colorNumberArticul = Color(0xfff0f0f0);
  Color _colorDescriptionArticul = Color(0xfff0f0f0);
  Color _colorMaterialAndColor = Color(0xfff0f0f0);
  Color _colorQuantityPerProduct = Color(0xfff0f0f0);
  Color _colorUnitMeasurement = Color(0xfff0f0f0);
  Color _colorShowMaterialAndColor = Color(0xfff0f0f0);

  // 2  _colorQuantityPerProduct2  _colorUnitMeasurement2
  Color _colorQuantityPerProduct2 = Color(0xfff0f0f0);
  Color _colorUnitMeasurement2 = Color(0xfff0f0f0);

  // furniture
  Color _colorFurnitureMaterialAndColor = Color(0xfff0f0f0);
  Color _colorFurnitureQuantityPerProduct = Color(0xfff0f0f0);
  Color _colorFurnitureUnitMeasurement = Color(0xfff0f0f0);

  Color _changeColor(TextEditingController controller) {
    return controller.text.isEmpty ? Color(0xfff0f0f0) : Colors.white;
  }

  Color _changeBorderColor(TextEditingController controller) {
    return controller.text.isEmpty ? Colors.transparent : Color(0xffD2D2D2);
  }

  bool _filledAllMaterialControllersAbove(int index) {
    return _materialAndColorController![index].text.isNotEmpty &&
        _quantityPerProductController![index].text.isNotEmpty &&
        _unitMeasurementController![index].text.isNotEmpty;
  }

  bool filledAllFurnitureControllersAbove() {
    return _furnitureAndColorController.text.isNotEmpty &&
        _furnitureQuantityPerProductController.text.isNotEmpty &&
        _furnitureUnitMeasurementController.text.isNotEmpty;
  }

  // Should be always more than 1, because it will build ListView
  var _clickedMaterialButton = 1;
  bool _clickedFurnitureButton = false;

  bool _checkAndSave() {
    return _numberController.text.isNotEmpty &&
        _materialAndColorController![_clickedMaterialButton - 1]
            .text
            .isNotEmpty &&
        _quantityPerProductController![_clickedMaterialButton - 1]
            .text
            .isNotEmpty &&
        _unitMeasurementController![_clickedMaterialButton - 1]
            .text
            .isNotEmpty &&
        _furnitureAndColorController.text.isNotEmpty &&
        _furnitureQuantityPerProductController.text.isNotEmpty &&
        _furnitureUnitMeasurementController.text.isNotEmpty;
  }

  /* Future<void> _postData() async {
    // URL вашего эндпоинта для создания записи
    String url1 = 'https://intern.salamhalal.info/api/article';
    /* String url2 = 'https://intern.salamhalal.info/api/article_item';
    String url3 = 'https://intern.salamhalal.info/api/item'; */

    
    var data1 = {
      'number': _numberController.text,
      'description': _descriptionController.text,
    };

    /* var data2 = {
      'quantity': _materialAndColorController.text,
      'article': _quantityPerProductController.text,
      'item': _unitMeasurementController.text,
    };

    var data3 = {
      'name': _furnitureAndColorController.text,
      'item_type': _furnitureQuantityPerProductController.text,
      'measurement': _furnitureUnitMeasurementController.text,
    }; */

    
    var response1 = await http.post(
      Uri.parse(url1), body: json.encode(data1),
      headers: {"Content-Type": "application/json"},
      //headers: {'Content-Type': 'application/json'},
    );
    /* var response2 = await http.post(
      Uri.parse(url2),
      body: json.encode(data2),
    );
    var response3 = await http.post(
      Uri.parse(url3),
      body: json.encode(data3),
    ); */
    print("${response1.statusCode}");
    print("${response1.body}");
   
    if (response1.statusCode == 201) {
      print('1 Данные успешно добавлены');
    } else {
      print('1 Произошла ошибка: ${response1.reasonPhrase}');
    }
    /*  if (response2.statusCode == 201) {
      print('2 Данные успешно добавлены');
    } else {
      print('2 Произошла ошибка: ${response2.reasonPhrase}');
    }

    if (response3.statusCode == 201) {
      print('3 Данные успешно добавлены');
    } else {
      print('3 Произошла ошибка: ${response3.reasonPhrase}');
    } */
  } */

  //final apiUrl = 'https://intern.salamhalal.info/api/article';

  /* var url1 = 'https://intern.salamhalal.info/api/article';
  var url2 = 'https://intern.salamhalal.info/api/article_item';
  var url3 = 'https://intern.salamhalal.info/api/item'; */

  /* Future<void> postData() async {
    
    // String url = 'https://intern.salamhalal.info/api/article/';

    
    Map<String, dynamic> data1 = {
      'number': 'gfdgdf',
      'description': 'gfdgdfsghdf'
    };

    /* Map<String, dynamic> data2 = {
      'quantity': _materialAndColorController.text,
      'article': _quantityPerProductController.text,
      'item': _unitMeasurementController.text,
    };

    Map<String, dynamic> data3 = {
      'name': _furnitureAndColorController.text,
      'item_type': _furnitureQuantityPerProductController.text,
      'measurement': _furnitureUnitMeasurementController.text,
    }; */

    try {
      final response1 = await http.post(
        Uri.parse(url1),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data1),
      );

      /* final response2 = await http.post(
        Uri.parse(url2),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data2),
      );

      final response3 = await http.post(
        Uri.parse(url3),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data3),
      ); */

      if (response1.statusCode == 201) {
        print('Успешно отправлено (Информация об артикуле): ${response1.body}');
        /* print('Успешно отправлено (Материал): ${response2.body}');
        print('Успешно отправлено (Фурнитура): ${response3.body}'); */
      } else {
        print(
            'Ошибка при отправлении данных (Информация об артикуле): ${response1.statusCode}');
        /*  print(
            'Ошибка при отправлении данных (Материал): ${response2.statusCode}');
        print(
            'Ошибка при отправлении данных (Фурнитура): ${response3.statusCode}'); */
      }
    } catch (error) {
      print('Ошибка при выполнении запроса: $error');
    }
  } */

  Future<void> postData1() async {
    String url = 'https://intern.salamhalal.info/api/article';

    Map<String, dynamic> data = {
      'number': _numberController.text,
      'description': _descriptionController.text,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 400) {
        print('Успешно отправлено: ${response.body}');
      } else {
        print('Ошибка: ${response.statusCode}');
      }
    } catch (error) {
      print('Ошибка при выполнении запроса: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 20),
          child: Text(
            'Booster',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Image(
              image: AssetImage('assets/property1.png'),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              //_dropDownBut(),
              _infoArticul(),
              _numberArticul(),
              SizedBox(height: 216 - 158 - 50),
              _descriptionArticul(),
              _materialText(),
              /* _materialAndColor(),
              SizedBox(height: 506 - 448 - 50),
              Row(children: [
                _quantityPerProduct(),
                SizedBox(width: 7),
                _unitMeasurement(),
              ]), */

              /* // Material Button
              _clickedMaterialButton > 0
                  ? Column(
                      children: [
                        SizedBox(height: 564 - 506 - 50),
                        _showMaterialAndColor(),
                        SizedBox(height: 622 - 564 - 50),
                        Row(children: [
                          _quantityPerProduct2(),
                          SizedBox(width: 7),
                          _unitMeasurement2(),
                        ]),
                      ],
                    )
                  : Container(), */

              _clickedMaterialButton > 0
                  ? _buildMaterialListView()
                  : Container(),

              _materialButton(),
              SizedBox(height: 564 - 506 - 50),
              //MyWidget(),

              // furniture
              _furnitureText(),
              _furnitureMaterialAndColor(),
              SizedBox(height: 854 - 796 - 50),
              Row(children: [
                _furnitureQuantityPerProduct(),
                SizedBox(width: 7),
                _furnitureUnitMeasurement(),
              ]),
              SizedBox(height: 796 - 738 - 50),
              _furnitureButton(),
              SizedBox(height: 912 - 796 - 50),
              _saveButton(),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMaterialListView() {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: _clickedMaterialButton,
      itemBuilder: (context, index) {
        _materialAndColorController?.add(TextEditingController());
        _quantityPerProductController?.add(TextEditingController());
        _unitMeasurementController?.add(TextEditingController());
        return Column(
          children: [
            //SizedBox(height: 564 - 506 - 50),
            _materialAndColor(index),
            SizedBox(height: 506 - 448 - 50),
            Row(children: [
              _quantityPerProduct(index),
              SizedBox(width: 7),
              _unitMeasurement(index),
            ]),
            SizedBox(height: 564 - 506 - 50),
          ],
        );
      },
    );
  }

  Widget _infoArticul() {
    return Container(
      height: 50,
      alignment: Alignment.center,
      child: const Text(
        'ИНФОРМАЦИЯ ОБ АРТИКУЛЕ',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
      ),
    );
  }

  Widget _numberArticul() {
    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: _colorNumberArticul,
        border: Border.all(color: _changeBorderColor(_numberController)),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        cursorHeight: 14,
        style: TextStyle(fontSize: 16),
        decoration: InputDecoration(
          labelStyle: TextStyle(fontSize: 10),
          labelText: 'Номер артикула',
          border: InputBorder.none,
        ),
        controller: _numberController,
        onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
        onChanged: (value) {
          setState(() {
            _colorNumberArticul = _changeColor(_numberController);
          });
        },
      ),
    );
  }

  Widget _descriptionArticul() {
    return Container(
      height: 166,
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: _colorDescriptionArticul,
        border: Border.all(color: _changeBorderColor(_descriptionController)),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        keyboardType: TextInputType.multiline,
        maxLines: null,
        style: TextStyle(fontSize: 16),
        decoration: InputDecoration(
          labelStyle: TextStyle(fontSize: 10),
          labelText: 'Описание артикула',
          border: InputBorder.none,
        ),
        controller: _descriptionController,
        onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
        onChanged: (value) {
          setState(() {
            _colorDescriptionArticul = _changeColor(_descriptionController);
          });
        },
      ),
    );
  }

  Widget _materialText() {
    return Container(
      height: 50,
      alignment: Alignment.center,
      child: const Text(
        'МАТЕРИАЛ',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
      ),
    );
  }

  Widget _materialAndColor(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 50,
          width: 340,
          padding: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: _changeColor(_materialAndColorController![index]),
            border: Border.all(
              color: _changeBorderColor(_materialAndColorController![index]),
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextField(
            cursorHeight: 14,
            style: TextStyle(fontSize: 16),
            decoration: InputDecoration(
              labelStyle: TextStyle(fontSize: 10),
              labelText: 'Материал, цвет',
              border: InputBorder.none,
            ),
            controller: _materialAndColorController![index],
            onTapOutside: (event) =>
                FocusManager.instance.primaryFocus?.unfocus(),
            onChanged: (value) {
              setState(() {});
            },
          ),
        ),
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: _filledAllMaterialControllersAbove(index)
                ? Colors.white
                : Color(0xffCCCCCC),
            border: Border.all(
              color: _filledAllMaterialControllersAbove(index)
                  ? Color(0xff47A6DC)
                  : Color(0xfff0f0f0),
            ),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: () {
              /* _materialAndColorController.text.isEmpty
                  ? null
                  : _materialAndColorController.clear(); */
              setState(() {
                /* _colorMaterialAndColor =
                    _changeColor(_materialAndColorController); */
                _materialAndColorController![index].clear();
                _quantityPerProductController![index].clear();
                _unitMeasurementController![index].clear();
                if (_clickedMaterialButton > 1) {
                  _clickedMaterialButton--;
                  _materialAndColorController!.removeLast();
                  _quantityPerProductController!.removeLast();
                  _unitMeasurementController!.removeLast();
                }
              });
            },
            icon: Icon(
              Icons.clear,
              color: _filledAllMaterialControllersAbove(index)
                  ? Color(0xff47A6DC)
                  : Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _quantityPerProduct(int index) {
    return Expanded(
      child: Container(
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: _changeColor(_quantityPerProductController![index]),
          border: Border.all(
              color: _changeBorderColor(_quantityPerProductController![index])),
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField(
          cursorHeight: 14,
          style: TextStyle(fontSize: 16),
          decoration: InputDecoration(
            labelStyle: TextStyle(fontSize: 10),
            labelText: 'Кол-во на ед. прод. ',
            border: InputBorder.none,
          ),
          controller: _quantityPerProductController![index],
          onTapOutside: (event) =>
              FocusManager.instance.primaryFocus?.unfocus(),
          onChanged: (value) {
            setState(() {});
          },
        ),
      ),
    );
  }

  Widget _unitMeasurement(int index) {
    return Expanded(
      child: Container(
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: _changeColor(_unitMeasurementController![index]),
          border: Border.all(
              color: _changeBorderColor(_unitMeasurementController![index])),
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField(
          cursorHeight: 14,
          style: TextStyle(fontSize: 16),
          decoration: InputDecoration(
            labelStyle: TextStyle(fontSize: 10),
            labelText: 'Ед. измерения',
            border: InputBorder.none,
          ),
          controller: _unitMeasurementController![index],
          onTapOutside: (event) =>
              FocusManager.instance.primaryFocus?.unfocus(),
          onChanged: (value) {
            setState(() {});
          },
        ),
      ),
    );
  }

  Widget _materialButton() {
    return Container(
      alignment: Alignment.center,
      height: 50,
      width: 195,
      decoration: BoxDecoration(
        color: _filledAllMaterialControllersAbove(_clickedMaterialButton - 1)
            ? Color(0xff47A6DC)
            : Color(0xffCCCCCC),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextButton(
        onPressed: () {
          if (_filledAllMaterialControllersAbove(_clickedMaterialButton - 1)) {
            setState(() {
              _clickedMaterialButton++;
            });
          }
        },
        child: Text(
          '+ материал',
          style: TextStyle(color: Color(0xffFFFFFF), fontSize: 16),
        ),
      ),
    );
  }

  //_showMaterialAndColorColor _showMaterialAndColorController

  Widget _showMaterialAndColor() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 50,
          width: 340,
          padding: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: _colorShowMaterialAndColor,
            border: Border.all(
                color: _changeBorderColor(_showMaterialAndColorController)),
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextField(
            cursorHeight: 14,
            style: TextStyle(fontSize: 16),
            decoration: InputDecoration(
              labelStyle: TextStyle(fontSize: 10),
              labelText: 'Материал, цвет',
              border: InputBorder.none,
            ),
            controller: _showMaterialAndColorController,
            onTapOutside: (event) =>
                FocusManager.instance.primaryFocus?.unfocus(),
            onChanged: (value) {
              setState(() {
                _colorShowMaterialAndColor =
                    _changeColor(_showMaterialAndColorController);
              });
            },
          ),
        ),
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Color(0xff47A6DC),
            ),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: () {
              setState(() {
                _clickedMaterialButton--;
              });
            },
            icon: Icon(
              Icons.clear,
              color: Color(0xff47A6DC),
            ),
          ),
        ),
      ],
    );
  }

  Widget _quantityPerProduct2() {
    return Expanded(
      child: Container(
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: _colorQuantityPerProduct2,
          border: Border.all(
              color: _changeBorderColor(_quantityPerProductController2)),
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField(
          cursorHeight: 14,
          style: TextStyle(fontSize: 16),
          decoration: InputDecoration(
            labelStyle: TextStyle(fontSize: 10),
            labelText: 'Кол-во на ед. прод. ',
            border: InputBorder.none,
          ),
          controller: _quantityPerProductController2,
          onTapOutside: (event) =>
              FocusManager.instance.primaryFocus?.unfocus(),
          onChanged: (value) {
            setState(() {
              _colorQuantityPerProduct2 =
                  _changeColor(_quantityPerProductController2);
            });
          },
        ),
      ),
    );
  }

  // _quantityPerProductController2 _unitMeasurement2Controller2
  // _colorQuantityPerProduct2  _colorUnitMeasurement2

  Widget _unitMeasurement2() {
    return Expanded(
      child: Container(
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: _colorUnitMeasurement2,
          border: Border.all(
              color: _changeBorderColor(_unitMeasurementController2)),
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField(
          cursorHeight: 14,
          style: TextStyle(fontSize: 16),
          decoration: InputDecoration(
            labelStyle: TextStyle(fontSize: 10),
            labelText: 'Ед. измерения',
            border: InputBorder.none,
          ),
          controller: _unitMeasurementController2,
          onTapOutside: (event) =>
              FocusManager.instance.primaryFocus?.unfocus(),
          onChanged: (value) {
            setState(() {
              _colorUnitMeasurement2 =
                  _changeColor(_unitMeasurementController2);
            });
          },
        ),
      ),
    );
  }

  Widget _furnitureText() {
    return Container(
      height: 50,
      alignment: Alignment.center,
      child: const Text(
        'ФУРНИТУРА',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
      ),
    );
  }

  Widget _furnitureMaterialAndColor() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 50,
          width: 340,
          padding: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: _colorFurnitureMaterialAndColor,
            border: Border.all(
                color: _changeBorderColor(_furnitureAndColorController)),
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextField(
            cursorHeight: 14,
            style: TextStyle(fontSize: 16),
            decoration: InputDecoration(
              labelStyle: TextStyle(fontSize: 10),
              labelText: 'Материал, цвет',
              border: InputBorder.none,
            ),
            controller: _furnitureAndColorController,
            onTapOutside: (event) =>
                FocusManager.instance.primaryFocus?.unfocus(),
            onChanged: (value) {
              setState(() {
                _colorFurnitureMaterialAndColor =
                    _changeColor(_furnitureAndColorController);
              });
            },
          ),
        ),
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: _furnitureAndColorController.text.isEmpty
                ? Color(0xffCCCCCC)
                : Colors.white,
            border: Border.all(
              color: _furnitureAndColorController.text.isEmpty
                  ? Color(0xfff0f0f0)
                  : Color(0xff47A6DC),
            ),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: () {
              _furnitureAndColorController.text.isEmpty
                  ? null
                  : _furnitureAndColorController.clear();
              setState(() {
                _colorFurnitureMaterialAndColor =
                    _changeColor(_furnitureAndColorController);
              });
            },
            icon: Icon(
              Icons.clear,
              color: _furnitureAndColorController.text.isEmpty
                  ? Colors.white
                  : Color(0xff47A6DC),
            ),
          ),
        ),
      ],
    );
  }

  Widget _furnitureQuantityPerProduct() {
    return Expanded(
      child: Container(
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: _colorFurnitureQuantityPerProduct,
          border: Border.all(
              color:
                  _changeBorderColor(_furnitureQuantityPerProductController)),
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField(
          cursorHeight: 14,
          style: TextStyle(fontSize: 16),
          decoration: InputDecoration(
            labelStyle: TextStyle(fontSize: 10),
            labelText: 'Кол-во на ед. прод. ',
            border: InputBorder.none,
          ),
          controller: _furnitureQuantityPerProductController,
          onTapOutside: (event) =>
              FocusManager.instance.primaryFocus?.unfocus(),
          onChanged: (value) {
            setState(() {
              _colorFurnitureQuantityPerProduct =
                  _changeColor(_furnitureQuantityPerProductController);
            });
          },
        ),
      ),
    );
  }

  Widget _furnitureUnitMeasurement() {
    return Expanded(
      child: Container(
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: _colorFurnitureUnitMeasurement,
          border: Border.all(
              color: _changeBorderColor(_furnitureUnitMeasurementController)),
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField(
          cursorHeight: 14,
          style: TextStyle(fontSize: 16),
          decoration: InputDecoration(
            labelStyle: TextStyle(fontSize: 10),
            labelText: 'Ед. измерения',
            border: InputBorder.none,
          ),
          controller: _furnitureUnitMeasurementController,
          onTapOutside: (event) =>
              FocusManager.instance.primaryFocus?.unfocus(),
          onChanged: (value) {
            setState(() {
              _colorFurnitureUnitMeasurement =
                  _changeColor(_furnitureUnitMeasurementController);
            });
          },
        ),
      ),
    );
  }

  Widget _furnitureButton() {
    return Container(
      alignment: Alignment.center,
      height: 50,
      width: 195,
      decoration: BoxDecoration(
        color: filledAllFurnitureControllersAbove()
            ? Color(0xff47A6DC)
            : Color(0xffCCCCCC),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextButton(
        onPressed: () {
          if (filledAllFurnitureControllersAbove()) {
            setState(() {
              _clickedFurnitureButton = !_clickedFurnitureButton;
            });
          }
        },
        child: Text(
          '+ фурнитура',
          style: TextStyle(color: Color(0xffFFFFFF), fontSize: 16),
        ),
      ),
    );
  }

  Widget _saveButton() {
    return Container(
      alignment: Alignment.center,
      height: 50,
      width: 195,
      decoration: BoxDecoration(
        color: _checkAndSave() ? Color(0xff47A6DC) : Color(0xffCCCCCC),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextButton(
        onPressed: () {
          postData1();
        },
        child: Text(
          'Сохранить',
          style: TextStyle(color: Color(0xffFFFFFF), fontSize: 16),
        ),
      ),
    );
  }
}
