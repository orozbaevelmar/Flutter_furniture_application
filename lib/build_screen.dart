import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:furniture_application/methods/method.dart';
import 'package:furniture_application/methods/post_data.dart';
import 'package:collection/collection.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class BuildScreen extends StatefulWidget {
  BuildScreen({super.key});

  @override
  State<BuildScreen> createState() => _BuildScreenState();
}

class _BuildScreenState extends State<BuildScreen> {
  // TextEditingController -----------------------------------------------------
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  // Material
  List<TextEditingController>? _materialAndColorController = [
    TextEditingController()
  ];
  List<TextEditingController>? _quantityPerProductController = [
    TextEditingController()
  ];
  List<String?>? _unitMeasurementController = [null];

  //furniture
  final TextEditingController _furnitureAndColorController =
      TextEditingController();
  final TextEditingController _furnitureQuantityPerProductController =
      TextEditingController();
  String? _strFurnitureUnitMeasurement;

  bool _filledAllMaterialControllersAbove(int index) {
    return _materialAndColorController![index].text.isNotEmpty &&
        _quantityPerProductController![index].text.isNotEmpty &&
        _method.notEmptyString(_unitMeasurementController![index]);
  }

  bool _filledAllFurnitureControllersAbove() {
    return _furnitureAndColorController.text.isNotEmpty &&
        _furnitureQuantityPerProductController.text.isNotEmpty &&
        _method.notEmptyString(_strFurnitureUnitMeasurement);
  }

  // Should be always more than 1, because it will build ListView
  int _clickedMaterialButton = 1;

  bool _checkAndSave() {
    return _numberController.text.isNotEmpty &&
        _materialAndColorController![_clickedMaterialButton - 1]
            .text
            .isNotEmpty &&
        _quantityPerProductController![_clickedMaterialButton - 1]
            .text
            .isNotEmpty &&
        _method.notEmptyString(
            _unitMeasurementController?[_clickedMaterialButton - 1]) &&
        _furnitureAndColorController.text.isNotEmpty &&
        _furnitureQuantityPerProductController.text.isNotEmpty &&
        _method.notEmptyString(_strFurnitureUnitMeasurement);
  }

  Method _method = Method();
  PostData _postData = PostData();

  String readRepositories = r"""
query ($name: String!) {
  __type(name: $name) {
   name 
  }
  company {
    __typename
    summary
    employees
    test_sites
    vehicles
    ceo
    launch_sites
    coo
  }
}
""";

  List<String> direction = ['company'];

  List<String> list = [
    '__typename',
    'summary',
    'employees',
    'test_sites',
    'vehicles',
    'ceo',
    'launch_sites',
    'coo'
  ];

  List<String> _resultList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _buildGraph(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 20),
        child: const Text(
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
    );
  }

  Widget _buildGraph() {
    return Query(
      options: QueryOptions(
        document: gql(readRepositories),
        variables: {'name': 'users'},
        pollInterval: const Duration(seconds: 10),
      ),
      builder: (QueryResult result,
          {VoidCallback? refetch, FetchMore? fetchMore}) {
        /* if (result.hasException) {
          return Text('Error: ${result.exception.toString()}');
        }

        if (result.isLoading) {
          return const Text('Is Loading...');
        }

        Map<String, dynamic>? repositories = result.data?['company'];

        if (repositories == null) {
          return const Text('No repositories');
        } */

        return _buildBody(result);
        /* Container(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: repositories.length,
              itemBuilder: (context, index) {
                final repository = repositories[list[index]];

                return Text('$repository' ?? '');
              }),
        ); */
      },
    );
  }

  Widget _buildBody(QueryResult result) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            // Info About Articul
            _infoArticul(),
            _numberArticul(),
            SizedBox(height: 216 - 158 - 50),
            _descriptionArticul(),

            // Material
            _materialText(),
            _buildMaterialListView(),
            _materialButton(),
            SizedBox(height: 564 - 506 - 50),

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

            _resultList.isEmpty ? SizedBox(height: 120) : _result(),

            // Save
            Row(
              children: [
                _postDataButton(),
                SizedBox(width: 10),
                _fetchDataButton(result),
              ],
            ),

            /* SizedBox(height: 50),
              characters.isNotEmpty
                  ? _buildContainer()
                  : Container(
                      child:
                          _loading ? CircularProgressIndicator() : Container(),
                    ), */
            SizedBox(height: 50),
          ],
        ),
      ),
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
        color: _method.changeColor(_numberController),
        border: Border.all(color: _method.changeBorderColor(_numberController)),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        //cursorHeight: 14,
        style: TextStyle(fontSize: 16),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 7, bottom: 7),
          labelStyle: TextStyle(fontSize: 10),
          labelText: 'Номер артикула (type: String)',
          border: InputBorder.none,
        ),
        controller: _numberController,
        onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
        onChanged: (value) {
          setState(() {});
        },
      ),
    );
  }

  Widget _descriptionArticul() {
    return Container(
      height: 166,
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: _method.changeColor(_descriptionController),
        border: Border.all(
            color: _method.changeBorderColor(_descriptionController)),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        keyboardType: TextInputType.multiline,
        maxLines: null,
        style: TextStyle(fontSize: 16),
        decoration: InputDecoration(
          labelStyle: TextStyle(fontSize: 10),
          labelText: 'Описание артикула (type:String)',
          border: InputBorder.none,
        ),
        controller: _descriptionController,
        onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
        onChanged: (value) {
          setState(() {});
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

  Widget _buildMaterialListView() {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: _clickedMaterialButton,
      itemBuilder: (context, index) {
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

  Widget _materialAndColor(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(right: 10),
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: _method.changeColor(_materialAndColorController![index]),
              border: Border.all(
                color: _method
                    .changeBorderColor(_materialAndColorController![index]),
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: TextField(
              style: const TextStyle(fontSize: 16),
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.only(top: 7, bottom: 7),
                labelStyle: TextStyle(fontSize: 10),
                labelText: 'Материал, цвет (type: int)',
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
        ),
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: _filledAllMaterialControllersAbove(0)
                ? Colors.white
                : Color(0xffCCCCCC),
            border: Border.all(
              color: _filledAllMaterialControllersAbove(0)
                  ? Color(0xff47A6DC)
                  : Color(0xfff0f0f0),
            ),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: () {
              setState(() {
                if (_clickedMaterialButton > 1) {
                  _clickedMaterialButton--;
                  _materialAndColorController!.removeLast();
                  _quantityPerProductController!.removeLast();
                  _unitMeasurementController!.removeLast();
                } else {
                  _materialAndColorController![index].clear();
                  _quantityPerProductController![index].clear();
                  _unitMeasurementController![index] = null;
                }
              });
            },
            icon: Icon(
              Icons.clear,
              color: _filledAllMaterialControllersAbove(0)
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
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: _method.changeColor(_quantityPerProductController![index]),
          border: Border.all(
              color: _method
                  .changeBorderColor(_quantityPerProductController![index])),
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField(
          style: const TextStyle(fontSize: 16),
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.only(top: 7, bottom: 7),
            labelStyle: TextStyle(fontSize: 10),
            labelText: 'Кол-во на ед. прод. (type: int)',
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

  Widget _unitMeasurement(int idx) {
    // str, _unitMeasurementController0
    final List<String> places = ['1', '2', '3'];
    final List<String> placesRu = ['метр', 'рулон', 'штук'];

    return Expanded(
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
            color:
                _method.changeColorForString(_unitMeasurementController![idx]),
            border: Border.all(
                color: _method.changeBorderColorForString(
                    _unitMeasurementController![idx])),
            borderRadius: BorderRadius.circular(15)),
        child: DropdownButtonFormField<String>(
          isExpanded: true,
          dropdownColor: Colors.black,
          borderRadius: BorderRadius.circular(15),
          decoration: const InputDecoration(
            contentPadding:
                EdgeInsets.only(left: 0, right: 0, top: 9, bottom: 9),
            labelText: 'Ед. измерения (type: int)',
            labelStyle: TextStyle(fontSize: 10),
            border: InputBorder.none,
          ),
          selectedItemBuilder: (_) {
            return placesRu
                .map(
                  (e) => /* SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: */
                      Text(
                    e,
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                      fontSize: 16,
                      height: 0,
                    ),
                  ),
                )
                //)
                .toList();
          },
          value: _unitMeasurementController![idx],
          icon: Icon(Icons.arrow_drop_down),
          items: places.mapIndexed((int index, String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                placesRu[index],
                style: TextStyle(
                  color: Colors.white,
                  height: 0,
                  fontSize: 16,
                ),
              ),
            );
          }).toList(),
          onChanged: (_newValue) {
            setState(() {
              _unitMeasurementController![idx] = _newValue;
            });
          },
        ),
      ),
    );
    /* IconButton(
          icon: Image.asset('assets/Dropdown_arrow.png'),
          color: Color(0xffFFFFFF),
          onPressed: () {
            //Navigator.pop(dropdownKey.currentContext!);
          },
       ), */
  }

  Widget _materialButton() {
    return Center(
      child: Container(
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
            if (_filledAllMaterialControllersAbove(
                _clickedMaterialButton - 1)) {
              setState(() {
                _clickedMaterialButton++;
                _materialAndColorController?.add(TextEditingController());
                _quantityPerProductController?.add(TextEditingController());
                _unitMeasurementController?.add(null);
              });
            }
          },
          child: const Text(
            '+ материал',
            style: TextStyle(color: Color(0xffFFFFFF), fontSize: 16),
          ),
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
        Expanded(
          child: Container(
            height: 50,
            margin: EdgeInsets.only(right: 10),
            padding: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: _method.changeColor(_furnitureAndColorController),
              border: Border.all(
                  color:
                      _method.changeBorderColor(_furnitureAndColorController)),
              borderRadius: BorderRadius.circular(15),
            ),
            child: TextField(
              style: TextStyle(fontSize: 16),
              decoration: InputDecoration(
                labelStyle: TextStyle(fontSize: 10),
                labelText: 'Материал, цвет (type: String)',
                border: InputBorder.none,
              ),
              controller: _furnitureAndColorController,
              onTapOutside: (event) =>
                  FocusManager.instance.primaryFocus?.unfocus(),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
        ),
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: _filledAllFurnitureControllersAbove()
                ? Colors.white
                : Color(0xffCCCCCC),
            border: Border.all(
              color: _filledAllFurnitureControllersAbove()
                  ? Color(0xff47A6DC)
                  : Color(0xfff0f0f0),
            ),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: () {
              setState(() {
                if (_filledAllFurnitureControllersAbove()) {
                  _furnitureAndColorController.clear();
                  _furnitureQuantityPerProductController.clear();
                  _strFurnitureUnitMeasurement = null;
                }
              });
            },
            icon: Icon(
              Icons.clear,
              color: _filledAllFurnitureControllersAbove()
                  ? Color(0xff47A6DC)
                  : Colors.white,
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
          color: _method.changeColor(_furnitureQuantityPerProductController),
          border: Border.all(
              color: _method
                  .changeBorderColor(_furnitureQuantityPerProductController)),
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField(
          style: TextStyle(fontSize: 16),
          decoration: InputDecoration(
            labelStyle: TextStyle(fontSize: 10),
            labelText: 'Кол-во на ед. прод. (type: int)',
            border: InputBorder.none,
          ),
          controller: _furnitureQuantityPerProductController,
          onTapOutside: (event) =>
              FocusManager.instance.primaryFocus?.unfocus(),
          onChanged: (value) {
            setState(() {});
          },
        ),
      ),
    );
  }

  Widget _furnitureUnitMeasurement() {
    final List<String> places = ['material', 'accessories'];
    final List<String> placesRu = ['Материал', 'Аксессуары'];
    return Expanded(
      child: Container(
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
            color: _method.changeColorForString(
                _strFurnitureUnitMeasurement), //_emptyString(_strFurnitureUnitMeasurement) ? Color(0xfff0f0f0) : Colors.white,
            border: Border.all(
                color: _method
                    .changeBorderColorForString(_strFurnitureUnitMeasurement)
                //_emptyString(_strFurnitureUnitMeasurement) ? Colors.transparent : Color(0xffD2D2D2)
                ),
            borderRadius: BorderRadius.circular(15)),
        child: DropdownButtonFormField<String>(
          isExpanded: true,
          dropdownColor: Colors.black,
          borderRadius: BorderRadius.circular(15),
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.only(left: 0, right: 0, top: 9, bottom: 9),
            labelText: 'Ед. измерения (type: String)',
            labelStyle: TextStyle(fontSize: 10),
            border: InputBorder.none,
          ),
          selectedItemBuilder: (_) {
            return placesRu
                .map((e) => Text(
                      e,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                        fontSize: 16,
                        height: 0,
                      ),
                    ))
                .toList();
          },
          value: _strFurnitureUnitMeasurement,
          icon: Icon(Icons.arrow_drop_down),
          items: places.mapIndexed((int index, String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                placesRu[index],
                style: TextStyle(
                  color: Colors.white,
                  height: 0,
                  fontSize: 16,
                ),
              ),
            );
          }).toList(),
          onChanged: (_newValue) {
            setState(() {
              _strFurnitureUnitMeasurement = _newValue;
            });
          },
        ),
      ),
    );
  }

  Widget _furnitureButton() {
    return Center(
      child: Container(
        alignment: Alignment.center,
        height: 50,
        width: 195,
        decoration: BoxDecoration(
          color: _filledAllFurnitureControllersAbove()
              ? Color(0xff47A6DC)
              : Color(0xffCCCCCC),
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextButton(
          onPressed: () {},
          child: Text(
            '+ фурнитура',
            style: TextStyle(color: Color(0xffFFFFFF), fontSize: 16),
          ),
        ),
      ),
    );
  }

  Widget _postDataButton() {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        height: 50,
        decoration: BoxDecoration(
          color: _checkAndSave() ? Color(0xff47A6DC) : Color(0xffCCCCCC),
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextButton(
          onPressed: () async {
            if (_checkAndSave()) {
              _postData.setResult();
              await _postData.postData1(
                  _numberController.text, _descriptionController.text);

              await _postData.postData2(
                  _clickedMaterialButton - 1,
                  _materialAndColorController![_clickedMaterialButton - 1].text,
                  _quantityPerProductController![_clickedMaterialButton - 1]
                      .text,
                  _unitMeasurementController![_clickedMaterialButton - 1]);
              await _postData.postData3(
                _furnitureAndColorController.text,
                _furnitureQuantityPerProductController.text,
                _strFurnitureUnitMeasurement,
              );

              setState(() {
                _resultList = [];
                _resultList = _postData.getRes;
              });
            }
          },
          child: const Text(
            'Post Data',
            style: TextStyle(color: Color(0xffFFFFFF), fontSize: 16),
          ),
        ),
      ),
    );
  }

  Widget _fetchDataButton(QueryResult result) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        height: 50,
        decoration: BoxDecoration(
          color: Color(0xff47A6DC),
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextButton(
          onPressed: () {
            setState(() {
              if (result.hasException) {
                _resultList.add('Error: ${result.exception.toString()}');
              } else if (result.isLoading) {
                _resultList.add('Is Loading...');
              } else if (result.data?[direction[0]] == null) {
                _resultList.add('No repositories');
              } else {
                Map<String, dynamic> repositories = result.data?[direction[0]];

                _numberController.text = repositories[list[0]];
                _descriptionController.text = repositories[list[1]];
                _materialAndColorController![0].text =
                    repositories[list[2]].toString();
                _quantityPerProductController![0].text =
                    repositories[list[3]].toString();
                _unitMeasurementController![0] = '1';
                _furnitureAndColorController.text = repositories[list[5]];
                _furnitureQuantityPerProductController.text =
                    repositories[list[6]].toString();
                _strFurnitureUnitMeasurement = 'material';
                _resultList = [];
                _resultList.add('Succesfully fetched data');
              }
            });
          },
          child: const Text(
            'Fetch Data',
            style: TextStyle(color: Color(0xffFFFFFF), fontSize: 16),
          ),
        ),
      ),
    );
  }

  Widget _result() {
    return Column(
      children: [
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.red)),
          height: 100,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
              itemCount: _resultList.length,
              itemBuilder: (context, index) {
                return Text(
                  _resultList[index],
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                );
              }),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
