import 'package:flutter/material.dart';

class LoadingButton extends StatefulWidget {
  const LoadingButton({required this.title, required this.onPressed, Key? key})
      : super(key: key);
  final String title;
  final Future<void> Function() onPressed;

  @override
  State<LoadingButton> createState() => _LoadingButtonState();
}

class _LoadingButtonState extends State<LoadingButton> {
  bool isLoading = false;

  void changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
          onPressed: () async {
            changeLoading();
            await widget.onPressed.call();
            changeLoading();
          },
          child: isLoading
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : Text(widget.title)),
    );
  }
}
