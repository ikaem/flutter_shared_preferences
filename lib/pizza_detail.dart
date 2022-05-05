import 'package:flutter/material.dart';
import 'package:flutter_shared_preferences/http_helper.dart';
import 'package:flutter_shared_preferences/pizza.dart';

class PizzaDetail extends StatefulWidget {
  final Pizza pizza;
  final bool isNew;

  const PizzaDetail({Key? key, required this.pizza, required this.isNew})
      : super(key: key);

  @override
  State<PizzaDetail> createState() => _PizzaDetailState();
}

class _PizzaDetailState extends State<PizzaDetail> {
  final TextEditingController txtId = TextEditingController();
  final TextEditingController txtName = TextEditingController();
  final TextEditingController txtDescription = TextEditingController();
  final TextEditingController txtPrice = TextEditingController();
  final TextEditingController txtImageUrl = TextEditingController();

  String postResult = "";

  @override
  void initState() {
    if (!widget.isNew) {
      txtId.text = widget.pizza.id.toString();
      txtName.text = widget.pizza.pizzaName;
      txtDescription.text = widget.pizza.description;
      txtPrice.text = widget.pizza.price.toString();
      txtImageUrl.text = widget.pizza.imageUrl.toString();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pizza Detail")),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text(postResult,
                  style: TextStyle(
                      backgroundColor: Colors.green.shade200,
                      color: Colors.black)),
              SizedBox(
                height: 24,
              ),
              TextField(
                controller: txtId,
                decoration: InputDecoration(hintText: "Insert ID"),
              ),
              SizedBox(
                height: 24,
              ),
              TextField(
                controller: txtName,
                decoration: InputDecoration(hintText: "Insert Name"),
              ),
              SizedBox(
                height: 24,
              ),
              TextField(
                controller: txtDescription,
                decoration: InputDecoration(hintText: "Insert Description"),
              ),
              SizedBox(
                height: 24,
              ),
              TextField(
                controller: txtPrice,
                decoration: InputDecoration(hintText: "Insert Price"),
              ),
              SizedBox(
                height: 24,
              ),
              TextField(
                controller: txtImageUrl,
                decoration: InputDecoration(hintText: "Insert Image URL"),
              ),
              SizedBox(
                height: 48,
              ),
              ElevatedButton(onPressed: postPizza, child: Text("Submit Pizza"))
            ],
          ),
        ),
      ),
    );
  }

// NOT using this
  Future<String> postPizza() async {
    HttpHelper helper = HttpHelper();

    Pizza pizza = Pizza();
    // this returns null if fails
    pizza.id = int.tryParse(txtId.text) ?? 0;
    // this will throw if parsing fails
    // pizza.id = int.parse(txtId.text);
    pizza.pizzaName = txtName.text;
    pizza.description = txtDescription.text;
    pizza.price = double.tryParse(txtPrice.text) ?? 0;
    pizza.imageUrl = txtImageUrl.text;

    String result = await helper.postPizza(pizza);

    setState(() {
      postResult = result;
    });

    return result;
  }

  Future savePizza() async {
    HttpHelper helper = HttpHelper();
    String result = "";

    if (widget.isNew) {
      result = await helper.postPizza(widget.pizza);
    } else {
      result = await helper.putPizza(widget.pizza);
    }

    setState(() {
      result = result;
    });

    return result;
  }
}
