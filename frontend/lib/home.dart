import 'package:flutter/material.dart';
import 'package:word_count/backend.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _urlController =
      TextEditingController(text: 'https://www.expertrec.com/');
  final TextEditingController _topNController =
      TextEditingController(text: '10');
  final ApiService _apiService = ApiService();
  List<Map<String, dynamic>> _results = [];
  bool _loading = false;

  Future<void> _fetchData() async {
    setState(() => _loading = true);
    try {
      final url = _urlController.text.trim();
      final topN = int.tryParse(_topNController.text) ?? 10;
      final data = await _apiService.fetchWordFrequency(url, topN);
      setState(() => _results = data);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error: $e")));
    }
    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    
    double baseScreenWidth = 411.0;
    double baseScreenHeight = 890.0;

    double widthRatio = screenWidth / baseScreenWidth;
    double heightRatio = screenHeight / baseScreenHeight;

    return Scaffold(
      appBar: AppBar(title: const Text('Word Frequency Analyzer')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16 * widthRatio),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _urlController,
              decoration:  InputDecoration(
                labelText: 'URL',
                border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8), // Rounded corners
                borderSide:const BorderSide(color: Colors.blue, width: 2), // Blue color and thickness
    )
                ),
              keyboardType: TextInputType.url,
              style: TextStyle(fontSize: 16 * widthRatio),
            ),
            SizedBox(height: 25 * heightRatio),
            TextField(
              controller: _topNController,
              decoration:
                   InputDecoration(labelText: 'Top N Words (Default 10)',border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8), // Rounded corners
      borderSide:const BorderSide(color: Colors.blue, width: 2), // Blue color and thickness
    )),

              keyboardType: TextInputType.number,
              style: TextStyle(fontSize: 16 * widthRatio),
            ),
            SizedBox(height: 16 * heightRatio),
            ElevatedButton(
              onPressed: _loading ? null : _fetchData,
              
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                      vertical: 12 * heightRatio,
                      horizontal: 24 * widthRatio))),
                      child: _loading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Submit'),
            ),
            SizedBox(height: 16 * heightRatio),
            _results.isNotEmpty
                ? _buildResultsTable(widthRatio, heightRatio)
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  Widget _buildResultsTable(double widthRatio, double heightRatio) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1 * widthRatio),
        ),
        child: DataTable(
          border: TableBorder(
            horizontalInside:
                BorderSide(color: Colors.grey, width: 1 * widthRatio),
            verticalInside:
                BorderSide(color: Colors.grey, width: 1 * widthRatio),
          ),
          columns: const [
            DataColumn(
                label: Text('Word',
                    style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text('Frequency',
                    style: TextStyle(fontWeight: FontWeight.bold))),
          ],
          rows: _results
              .map((result) => DataRow(cells: [
                    DataCell(Container(
                      padding: EdgeInsets.symmetric(vertical: 4 * heightRatio),
                      child: Text(result['word']),
                    )),
                    DataCell(Container(
                      padding: EdgeInsets.symmetric(vertical: 4 * heightRatio),
                      child: Text(result['frequency'].toString()),
                    )),
                  ]))
              .toList(),
        ),
      ),
    );
  }
}
