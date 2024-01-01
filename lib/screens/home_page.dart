import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wscube_quotes/models/quotes_model.dart';
import 'package:http/http.dart' as httpClient;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DataModel? dataModel;

  @override
  void initState() {
    super.initState();
    getQuotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Quotes",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.blue.shade200,
      body: dataModel != null && dataModel!.quotes.isNotEmpty
          ? ListView.builder(
              itemCount: dataModel!.quotes.length,
              itemBuilder: (_, index) {
                var quote = dataModel!.quotes[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 5,
                    child: ListTile(
                      title: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.blue,
                            child: Text(
                              "${quote.id}",
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(width: 11),
                          SizedBox(
                            width: 285,
                            child: Text(
                              quote.quote,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "- ${quote.author}",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.orange,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          : const Center(
              child: Text("No Quotes"),
            ),
    );
  }

  void getQuotes() async {
    var uri = Uri.parse("https://dummyjson.com/quotes");
    var response = await httpClient.get(uri);

    if (response.statusCode == 200) {
      var mData = jsonDecode(response.body);
      dataModel = DataModel.fromJson(mData);
      setState(() {});
    }
  }
}
