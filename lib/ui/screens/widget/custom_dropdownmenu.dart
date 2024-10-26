import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropDownMenu extends StatefulWidget {
  const CustomDropDownMenu({
    super.key,
    required this.textController,
    required this.width,
    required this.height,
    required this.label,
    required this.uk,
  });

  final TextEditingController textController;
  final double width;
  final double height;
  final String label;
  final Key uk;

  @override
  State<CustomDropDownMenu> createState() => _CustomDropDownMenuState();
}

class _CustomDropDownMenuState extends State<CustomDropDownMenu> {
  final List<String> list = <String>['One', 'Two', 'Three', 'Four'];
  late String dropdownValue = list.first;
  late final Key dropdownKey;
  @override
  void initState() {
    dropdownKey = UniqueKey();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: DropdownButtonFormField<String>(
        key: dropdownKey,
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: Theme.of(context).textTheme.bodyMedium,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.sp),
            borderSide: const BorderSide(
              color: Colors.black,
              style: BorderStyle.solid,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.sp),
            borderSide: const BorderSide(
              color: Colors.orange,
              style: BorderStyle.solid,
            ),
          ),
        ),
        style: Theme.of(context).textTheme.bodyMedium,
        icon: const Icon(Icons.arrow_drop_down),
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
            print(newValue);
          });
        },
        items: list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
