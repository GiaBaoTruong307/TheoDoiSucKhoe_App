import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UpdateWeightHeightDialog extends StatefulWidget {
  final double currentWeight;
  final double currentHeight;
  final Function(double weight, double height) onUpdate;

  const UpdateWeightHeightDialog({
    Key? key,
    required this.currentWeight,
    required this.currentHeight,
    required this.onUpdate,
  }) : super(key: key);

  @override
  State<UpdateWeightHeightDialog> createState() => _UpdateWeightHeightDialogState();
}

class _UpdateWeightHeightDialogState extends State<UpdateWeightHeightDialog> {
  late TextEditingController _weightController;
  late TextEditingController _heightController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _weightController = TextEditingController(text: widget.currentWeight.toInt().toString());
    _heightController = TextEditingController(text: widget.currentHeight.toInt().toString());
  }

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Nhập cân nặng và chiều cao của bạn',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2196F3),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  // Weight input
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300, width: 1.5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Row(
                        children: [
                          const Icon(Icons.monitor_weight_outlined, color: Colors.grey, size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextFormField(
                              controller: _weightController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: '_____',
                                hintStyle: TextStyle(color: Colors.grey),
                                isDense: true,
                              ),
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Nhập cân nặng';
                                }
                                final weight = int.tryParse(value);
                                if (weight == null || weight < 20 || weight > 300) {
                                  return 'Không hợp lệ';
                                }
                                return null;
                              },
                            ),
                          ),
                          const Text(
                            'kg',
                            style: TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    '&',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                  const SizedBox(width: 16),
                  // Height input
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300, width: 1.5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Row(
                        children: [
                          const Icon(Icons.height, color: Colors.grey, size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextFormField(
                              controller: _heightController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: '_____',
                                hintStyle: TextStyle(color: Colors.grey),
                                isDense: true,
                              ),
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Nhập chiều cao';
                                }
                                final height = int.tryParse(value);
                                if (height == null || height < 100 || height > 250) {
                                  return 'Không hợp lệ';
                                }
                                return null;
                              },
                            ),
                          ),
                          const Text(
                            'cm',
                            style: TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Confirm button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final weight = double.parse(_weightController.text);
                      final height = double.parse(_heightController.text);
                      widget.onUpdate(weight, height);
                      Navigator.of(context).pop();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00BCD4),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Xác nhận',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}