
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../database.dart';
import '../utility/common_widgets.dart';
import '../utility/validations_controller.dart';
import 'form.dart';

class DisplayPage extends StatefulWidget {
  @override
  _DisplayPageState createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  final dbHelper = DatabaseHelper();
  List<Map<String, dynamic>> _data = [];

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  Future<void> _refreshData() async {
    final data = await dbHelper.queryAllData();
    setState(() {
      _data = data;
    });
  }


    void _editData(int id) async {
      final item = _data.firstWhere((element) => element['id'] == id);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FormView(
            id: item['id'],
            name: item['name'],
            mobileNo: item['mobileNo'],
            pan: item['pan'],
            email: item['email'],
            address1: item['address1'],
            address2: item['address2'],
            city: item['city'],
            state: item['state'],
            postcode: item['postcode'],
          ),
        ),
      ).then((_) {
        // Refresh data when returning from FormView
        _refreshData();
      });
    }



  void _deleteData(int id) async {
    await dbHelper.deleteData(id);
    _refreshData();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Data deleted successfully!')),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text("Data Manager",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width/22,fontWeight: FontWeight.bold)),
        backgroundColor: Colors.teal,
        leading: BackButton(
          onPressed: (){
            Get.back();
        },
          color: Colors.white,
        ),
      ),
      body: Scrollbar(
        thickness: 6,
        child: ListView.builder(
          itemCount: _data.length,
          itemBuilder: (context, index) {
            final item = _data[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: const Color(0xffFFFFFF),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xff000017).withOpacity(0.1),
                        offset: const Offset(0,3),
                        blurRadius: 6,
                      )
                    ],
                    borderRadius: BorderRadius.circular(10)),
                child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              color: const Color(0xffFFFFFF),
              shadowColor: Colors.grey,
              elevation: 0,
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/80),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          wordDifference("Name : ",item['name'],context),
                          Text(item['pan'],style: const TextStyle(fontWeight: FontWeight.bold))
                        ],
                      ),
                      wordDifference("Mobile No : ",item['mobileNo'],context),
                      wordDifference("Email Id : ",item['email'],context),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text("Address : ", style: TextStyle(fontWeight: FontWeight.w500)),
                      Expanded(child: Text("${item['address1']} ${item['address2']} ${item['city']} ${item['state']},\n${item['postcode']}.", style: const TextStyle(fontWeight: FontWeight.bold),softWrap: true)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _editData(item['id']),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete,color: Colors.red),
                        onPressed: () => _deleteData(item['id']),
                      ),
                    ],
                  )
                    ],
                  ))
              )),
            );
          },
        ),
      ),
    );
  }
}
