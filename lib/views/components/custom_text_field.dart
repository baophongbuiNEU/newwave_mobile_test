import 'package:flutter/material.dart';
import 'dart:async';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onSearchChanged;
  final bool isLoading;
  const CustomTextField({
    required this.onSearchChanged,
    required this.controller,
    required this.isLoading,
    super.key,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {});
    // Apply debounce to avoid excessive API calls
    if (_debounce?.isActive ?? false) {
      _debounce!.cancel();
    }
    // Set a new debounce timer for 1 second
    _debounce = Timer(const Duration(milliseconds: 1000), () {
      // Only call onSearchChanged after the debounce period
      widget.onSearchChanged(widget.controller.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(200),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 0,
            child:
                widget.isLoading
                    ? SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: Colors.blue,
                      ),
                    )
                    : Icon(Icons.search),
          ),
          Expanded(
            flex: 1,
            child: TextField(
              controller: widget.controller,
              decoration: const InputDecoration(
                hintText: 'Enter keyword',
                hintStyle: TextStyle(color: Colors.black38),
                border: OutlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
          ),
          if (widget.controller.text.isNotEmpty)
            Expanded(
              flex: 0,
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  widget.controller.clear();
                  if (_debounce?.isActive ?? false) {
                    _debounce!.cancel();
                  }
                  widget.onSearchChanged('');
                },
              ),
            ),
        ],
      ),
    );
  }
}
