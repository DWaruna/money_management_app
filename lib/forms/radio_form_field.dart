


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RadioFormField<T> extends FormField<String> {

 RadioFormField({
    super.key,
    required String title,
    required List<String> options,
    required Function(String?) onChanged,
    FormFieldSetter<String>? onSaved,
    FormFieldValidator<String>? validator,

  }) : super(
    onSaved: onSaved,
    validator: validator,
    builder: (FormFieldState<String> state) {
      return Column(
        children: [
            Text(title),
            Row(
              children: options.map((option) {
                return Expanded(
                  child: RadioListTile<String>( 
                    title: Text(option),
                    value: option,
                    groupValue: state.value,
                    onChanged: (value) {
                      state.didChange(value);
                      onChanged(value);
                    },
                  ),
                );
              }).toList(),
            ),
            if (state.hasError)
              Text(
                state.errorText!,
                style: TextStyle(color: Colors.red),
              ),
        ]
      );
    }
  );

  
}

class FormFiledSetter {
}