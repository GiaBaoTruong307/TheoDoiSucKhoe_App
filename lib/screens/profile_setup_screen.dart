import 'package:flutter/material.dart';
import 'package:health_app/screens/main_wrapper.dart';
import '../models/user_model.dart';


class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();

  String? _selectedGender;
  DateTime? _selectedDate;

  @override
  void dispose() {
    _nameController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 20),

                // Illustration
                Image.asset(
                  'assets/images/profile_illustration.png',
                  height: 200,
                ),
                const SizedBox(height: 32),

                // Title
                const Text(
                  'Thiết lập hồ sơ của bạn',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),

                // Subtitle
                Text(
                  'Cập nhật hồ sơ của bạn để bắt đầu\nhành trình theo dõi sức khỏe',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 32),

                // Name Field
                _buildTextField(
                  controller: _nameController,
                  hintText: 'Tên của bạn',
                  icon: Icons.person_outline,
                ),
                const SizedBox(height: 16),

                // Gender Dropdown
                _buildDropdownField(
                  value: _selectedGender,
                  hintText: 'Giới tính',
                  icon: Icons.people_outline,
                  items: ['Nam', 'Nữ', 'Khác'],
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value;
                    });
                  },
                ),
                const SizedBox(height: 16),

                // Date of Birth
                _buildDateField(
                  hintText: 'Ngày sinh',
                  icon: Icons.calendar_today_outlined,
                  selectedDate: _selectedDate,
                  onTap: () => _selectDate(context),
                ),
                const SizedBox(height: 16),

                // Weight Field
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        controller: _weightController,
                        hintText: 'Cân nặng',
                        icon: Icons.monitor_weight_outlined,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 12),
                    _buildUnitButton('KG', Colors.cyan),
                  ],
                ),
                const SizedBox(height: 16),

                // Height Field
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        controller: _heightController,
                        hintText: 'Chiều cao',
                        icon: Icons.height_outlined,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 12),
                    _buildUnitButton('CM', Colors.purple),
                  ],
                ),
                const SizedBox(height: 32),

                // Continue Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Tạo UserModel từ dữ liệu form
                        final user = UserModel(
                          name: _nameController.text,
                          age: _selectedDate != null
                              ? DateTime.now().year - _selectedDate!.year
                              : 0,
                          height: double.tryParse(_heightController.text) ?? 0,
                          weight: double.tryParse(_weightController.text) ?? 0,
                          gender: _selectedGender ?? '',
                        );

                        // Chuyển sang Home Screen
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainWrapper(user: user),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyan,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Tiếp tục',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    TextInputType? keyboardType,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[400]),
          prefixIcon: Icon(icon, color: Colors.grey[400]),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Vui lòng nhập $hintText';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDropdownField({
    required String? value,
    required String hintText,
    required IconData icon,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[400]),
          prefixIcon: Icon(icon, color: Colors.grey[400]),
          border: InputBorder.none,
        ),
        dropdownColor: Colors.white,
        items: items.map((String item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
        validator: (value) {
          if (value == null) {
            return 'Vui lòng chọn $hintText';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDateField({
    required String hintText,
    required IconData icon,
    required DateTime? selectedDate,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Icon(icon, color: Colors.grey[400]),
            const SizedBox(width: 12),
            Text(
              selectedDate == null
                  ? hintText
                  : '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
              style: TextStyle(
                fontSize: 16,
                color: selectedDate == null ? Colors.grey[400] : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUnitButton(String unit, Color color) {
    return Container(
      width: 60,
      height: 56,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Center(
        child: Text(
          unit,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}