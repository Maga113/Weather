// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, library_private_types_in_public_api, use_build_context_synchronously
import 'package:flutter/cupertino.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';
import 'package:flutter/material.dart';
import 'package:weather/screens/weather_detail.dart';
import '../services/api_client.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldGradientBackground(
      gradient: backgroundGradient(),
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Color.fromARGB(255, 11, 116, 202),
        title: AppBarName(),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          _InputAndButton(),
        ],
      ),
    );
  }

  LinearGradient backgroundGradient() {
    return LinearGradient(
        colors: [
          Color.fromARGB(255, 55, 255, 238),
          Color.fromARGB(160, 12, 255, 215),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0.0, 0.8],
        tileMode: TileMode.clamp);
  }
}

class _InputAndButton extends StatefulWidget {
  const _InputAndButton({
    Key? key,
  }) : super(key: key);

  @override
  State<_InputAndButton> createState() => _InputAndButtonState();
}

class _InputAndButtonState extends State<_InputAndButton> {
  final ApiClient _apiClient = ApiClient();
  final controller = TextEditingController();
  String? errorText = null;

  void _onTap() async {
    try {
      final response = await _apiClient.getCurrentWeather(controller.text);
      final city = controller.text;

      Navigator.push(context,
          CupertinoPageRoute(builder: (_) => WeatherDetail(city: city)));
    } catch (error) {
      errorText = 'Укажите верный город!';
      print("Возникло исключение: $error");
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            if (errorText != null)
              Padding(
                padding: const EdgeInsets.only(top: 220, left: 30, right: 30),
                child: Center(
                  child: Text(
                    errorText!,
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(top: 250, left: 30, right: 30),
              child: Center(
                child: TextField(
                  onSubmitted: (value) {
                    _onTap();
                  },
                  textInputAction: TextInputAction.search,
                  maxLines: 1,
                  cursorHeight: 19,
                  cursorColor: Colors.black,
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Colors.black,
                    fontSize: 19,
                  ),
                  controller: controller,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.black,
                      size: 25,
                    ),
                    hintText: 'Введите название города',
                    hintStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 19,
                    ),
                    contentPadding: EdgeInsets.symmetric(),
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 14, 69, 113), width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 14, 69, 113), width: 4),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 100),
          child: TextButton(
            style: ButtonStyle(
              overlayColor:
                  MaterialStateProperty.all(Color.fromARGB(75, 25, 25, 25)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              backgroundColor:
                  MaterialStateProperty.all(Color.fromARGB(255, 14, 69, 113)),
              foregroundColor: MaterialStateProperty.all(Colors.white),
            ),
            onPressed: _onTap,
            child: Text(
              'Подтвердить',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AppBarName extends StatelessWidget {
  const AppBarName({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: RichText(
      text: TextSpan(
        text: 'WEATHER',
        style: TextStyle(
          decoration: TextDecoration.underline,
          fontStyle: FontStyle.italic,
          fontSize: 33,
          color: Colors.white,
          fontWeight: FontWeight.w900,
        ),
      ),
    ));
  }
}
