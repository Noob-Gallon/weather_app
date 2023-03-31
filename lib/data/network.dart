import 'package:http/http.dart' as http;
import 'dart:convert';

class Network {
  final String url;
  Network({required this.url});

  Future<dynamic> getJsonData() async {
    // 명시적으로 http package로부터 불러와졌다는 것을 나타내기 위해
    // http의 import에서 as를 사용해 http라고 지정해 준다.
    http.Response response = await http.get(
      Uri.parse(
        url,
      ),
    );
    if (response.statusCode == 200) {
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData);
      return parsingData;
    }
  }
}
