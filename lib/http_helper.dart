import "dart:io";
import "package:http/http.dart" as http;
import "dart:convert";
import "pizza.dart";

class HttpHelper {
  // dont pšut any // here, or any https:// or such
  final String authority = "4ged1.mocklab.io";
  final String getPath = "pizzalist";
  final String postPath = "pizza";
  final String putPath = "pizza";
  final String deletePath = "pizza";

  static final HttpHelper _httpHelper = HttpHelper._internal();
  HttpHelper._internal();
  factory HttpHelper() {
    return _httpHelper;
  }

  Future<List<Pizza>?> getPizzaList() async {
    Uri url = Uri.https(authority, getPath);
    http.Response result = await http.get(url);

    if (result.statusCode == HttpStatus.ok) {
      // so when converting json response , first this
      final List<dynamic> jsonResponse = json.decode(result.body);
      print("this is json response: $jsonResponse");
      // now we convert to list of pizzas
      List<Pizza> pizzas =
          // we really dont know here if json response is good
          jsonResponse.map<Pizza>((item) => Pizza.fromJson(item)).toList();

      pizzas.forEach((pizza) {
        print("this is actually pizza: $pizza");
      });

      return pizzas;
    } else {
      // return [];
      return null;
    }
  }

  Future<String> postPizza(Pizza pizza) async {
    // testg if dont have to use to json directly, because there is that mehtod there already
    // String post = json.encode(pizza.toJson());
    String post = json.encode(pizza);

    Uri url = Uri.https(authority, postPath);
    http.Response response = await http.post(url, body: post);

    return response.body;
  }

  Future<String> putPizza(Pizza pizza) async {
    String put = json.encode(pizza.toJson());

    Uri url = Uri.https(authority, putPath);

    http.Response r = await http.put(
      url,
      body: put,
    );

// it seems this will alway be a string
    return r.body;
  }

  Future<String> deletePizza(int id) async {
    Uri url = Uri.https(authority, "$deletePath:$id");

// id is missing here
    http.Response r = await http.delete(url);

    return r.body;
  }
}
