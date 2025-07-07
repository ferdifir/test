import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp/api_service.dart';
import 'package:myapp/utils.dart';
import 'dart:convert';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final box = Hive.box("app");
  final listEvent = [];
  final listGambar = [];
  final api = ApiService();

  Future<void> getGambar() async {
    try {
      final body = <String, String>{
        "idperusahaan": box.get("idperusahaan"),
        "idcabang": box.get("idcabang"),
      };
      final res = await api.postFormData(
        endpoint: "Master/ApiCabang/getDaftarGambar",
        data: body,
      );
      if (res.statusCode == 200) {
        final response = json.decode(res.body);
        final data = response["data"];
        listGambar.clear();
        data.forEach((element) {
          listGambar.add(element["gambar"]);
        });
        setState(() {});
      }
    } catch (e) {
      Utils.showSnackBar(context, e.toString());
    }
  }

  Future<void> getEvent() async {
    try {
      final body = <String, String>{
        "idperusahaan": box.get("idperusahaan"),
        "idcabang": box.get("idcabang"),
        "idmemberuser": box.get("id"),
      };
      final res = await api.postFormData(
        endpoint: "Master/ApiCabang/getDaftarGambar",
        data: body,
      );
      if (res.statusCode == 200) {
        final response = json.decode(res.body);
        final data = response["data"];
        
        setState(() {});
      }
    } catch (e) {
      Utils.showSnackBar(context, e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    Future.wait([getGambar(),getEvent()]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 180,
            child: Image.network(
              "https://test.atena.id/assets/gambar-cabang/1/CB0014I99K.JPG",
            ),
          ),
          SizedBox(height: 20),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                "https://test.atena.id/assets/gambar-cabang/1//CB0014I99K.JPG",
              ),
              radius: 50,
            ),
            title: Text("Happy Workout,\n${box.get('nama')}"),
            subtitle: Row(
              children: [Icon(Icons.location_on), Text("Fithub Graha Pena")],
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text("Incoming Event"), Text("Show All")],
          ),
          SizedBox(height: 10),
          ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: listEvent.length,
            itemBuilder: (context, index) {
              return Container(
                
              );
            },
          ),
        ],
      ),
    );
  }
}
