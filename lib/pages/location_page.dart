import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp/api_service.dart';
import 'package:myapp/model/cabang.dart';
import 'package:myapp/pages/dashboard_page.dart';
import 'package:myapp/utils.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final api = ApiService();
  final List<Cabang> listData = [];
  String? selectedCabang;
  Cabang? selectedCab;
  final box = Hive.box("app");
  final searchCtrl = TextEditingController();

  void setCabang(String id) {
    setState(() {
      selectedCabang = id;
    });
  }

  Future<void> getData() async {
    try {
      final body = <String, String>{
        "idmemberuser": box.get("id"),
        "keyword": searchCtrl.text,
      };
      final res = await api.postFormData(
        endpoint: 'Master/ApiMember/getDaftarCabang',
        data: body,
      );
      if (res.statusCode == 200) {
        final body = json.decode(res.body);
        final data = body['data'];
        listData.clear();
        data.forEach((element) {
          listData.add(Cabang.fromJson(element));
        });
        setState(() {});
      } else {
        Utils.showSnackBar(context, 'Login Failed');
      }
    } catch (e) {
      Utils.showSnackBar(context, e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          controller: searchCtrl,
          onFieldSubmitted: (value) {
            getData();
          },
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            hintText: 'Search Location',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: getData,
              child: ListView.builder(
                itemCount: listData.length,
                itemBuilder: (context, index) {
                  final data = listData[index];
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedCabang = data.idcabang;
                        selectedCab = data;
                      });
                    },
                    child: Card(
                      color:
                          selectedCabang == data.idcabang
                              ? Colors.lightBlueAccent
                              : Colors.white,
                      child: Column(
                        children: [
                          Text(data.namacabang),
                          Row(
                            children: [
                              Icon(Icons.location_on),
                              Text(data.alamat),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.timer),
                              Text("${data.jambuka} - ${data.jamtutup}"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          ElevatedButton(
            onPressed:
                selectedCabang == null
                    ? null
                    : () {
                      box.put("idcabang", selectedCab!.idcabang);
                      box.put("idperusahaan", selectedCab!.idperusahaan);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => DashboardPage()),
                      );
                    },
            child: Text('Select location'),
          ),
        ],
      ),
    );
  }
}
