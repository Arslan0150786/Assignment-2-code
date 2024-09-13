import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MultiUtilityApp());
}

class MultiUtilityApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: UtilityHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class UtilityHomePage extends StatefulWidget {
  @override
  _UtilityHomePageState createState() => _UtilityHomePageState();
}

class _UtilityHomePageState extends State<UtilityHomePage> {
  int _selectedUtility = 0; // 0: BMI, 1: Tip, 2: Age, 3: Currency, 4: To-Do, 5: Quadratic, 6: Temperature, 7: SDT, 8: Discount, 9: Fuel

  // BMI Variables
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  String _bmiResult = '';

  // Tip Variables
  final TextEditingController _billController = TextEditingController();
  final TextEditingController _tipController = TextEditingController();
  String _tipResult = '';

  // Age Variables
  final TextEditingController _dobController = TextEditingController();
  String _ageResult = '';

  // Currency Converter Variables
  final TextEditingController _amountController = TextEditingController();
  String _currencyResult = '';
  String _selectedCurrencyFrom = 'USD';
  String _selectedCurrencyTo = 'EUR';
  final Map<String, double> _exchangeRates = {
    'USD': 1.0,
    'EUR': 0.85,
    'GBP': 0.75,
    'INR': 74.0,
  };

  // To-Do List Variables
  final List<String> _tasks = [];
  final TextEditingController _taskController = TextEditingController();

  // Quadratic Equation Variables
  final TextEditingController _aController = TextEditingController();
  final TextEditingController _bController = TextEditingController();
  final TextEditingController _cController = TextEditingController();
  String _quadraticResult = '';

  // Temperature Converter Variables
  final TextEditingController _temperatureController = TextEditingController();
  String _temperatureResult = '';
  String _selectedTempUnitFrom = 'Celsius';
  String _selectedTempUnitTo = 'Fahrenheit';

  // Speed Distance Time Calculator Variables
  final TextEditingController _speedController = TextEditingController();
  final TextEditingController _distanceController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  String _sdtResult = '';

  // Discount Calculator Variables
  final TextEditingController _originalPriceController = TextEditingController();
  final TextEditingController _discountPercentageController = TextEditingController();
  String _discountResult = '';

  // Fuel Efficiency Calculator Variables
  final TextEditingController _milesController = TextEditingController();
  final TextEditingController _gallonsController = TextEditingController();
  String _fuelEfficiencyResult = '';

  // Function to calculate BMI
  void _calculateBMI() {
    double weight = double.tryParse(_weightController.text) ?? 0;
    double height = double.tryParse(_heightController.text) ?? 0;
    if (weight > 0 && height > 0) {
      double bmi = weight / pow(height / 100, 2);
      setState(() {
        _bmiResult = 'Your BMI: ${bmi.toStringAsFixed(2)}';
      });
    }
  }

  // Function to calculate Tip
  void _calculateTip() {
    double bill = double.tryParse(_billController.text) ?? 0;
    double tipPercentage = double.tryParse(_tipController.text) ?? 0;
    double tip = bill * (tipPercentage / 100);
    double total = bill + tip;
    setState(() {
      _tipResult = 'Total Amount: \$${total.toStringAsFixed(2)} (Tip: \$${tip.toStringAsFixed(2)})';
    });
  }

  // Function to calculate Age
  void _calculateAge() {
    DateTime dob = DateTime.tryParse(_dobController.text) ?? DateTime.now();
    DateTime today = DateTime.now();
    int years = today.year - dob.year;
    int months = today.month - dob.month;
    int days = today.day - dob.day;
    if (days < 0) {
      months--;
      days += DateTime(today.year, today.month, 0).day;
    }
    if (months < 0) {
      years--;
      months += 12;
    }
    setState(() {
      _ageResult = 'Age: $years years, $months months, $days days';
    });
  }

  // Function to convert Currency
  void _convertCurrency() {
    double amount = double.tryParse(_amountController.text) ?? 0;
    double fromRate = _exchangeRates[_selectedCurrencyFrom] ?? 1.0;
    double toRate = _exchangeRates[_selectedCurrencyTo] ?? 1.0;
    double convertedAmount = (amount / fromRate) * toRate;
    setState(() {
      _currencyResult = 'Converted Amount: ${convertedAmount.toStringAsFixed(2)} $_selectedCurrencyTo';
    });
  }

  // Function to add Task
  void _addTask() {
    if (_taskController.text.isNotEmpty) {
      setState(() {
        _tasks.add(_taskController.text);
        _taskController.clear();
      });
    }
  }

  // Function to remove Task
  void _removeTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  // Function to solve Quadratic Equation
  void _solveQuadratic() {
    double a = double.tryParse(_aController.text) ?? 0;
    double b = double.tryParse(_bController.text) ?? 0;
    double c = double.tryParse(_cController.text) ?? 0;
    double discriminant = b * b - 4 * a * c;
    if (discriminant < 0) {
      setState(() {
        _quadraticResult = 'No Real Roots';
      });
    } else {
      double root1 = (-b + sqrt(discriminant)) / (2 * a);
      double root2 = (-b - sqrt(discriminant)) / (2 * a);
      setState(() {
        _quadraticResult = 'Roots: $root1, $root2';
      });
    }
  }

  // Function to convert Temperature
  void _convertTemperature() {
    double temperature = double.tryParse(_temperatureController.text) ?? 0;
    double convertedTemperature;
    if (_selectedTempUnitFrom == 'Celsius' && _selectedTempUnitTo == 'Fahrenheit') {
      convertedTemperature = (temperature * 9 / 5) + 32;
    } else if (_selectedTempUnitFrom == 'Fahrenheit' && _selectedTempUnitTo == 'Celsius') {
      convertedTemperature = (temperature - 32) * 5 / 9;
    } else if (_selectedTempUnitFrom == 'Celsius' && _selectedTempUnitTo == 'Kelvin') {
      convertedTemperature = temperature + 273.15;
    } else if (_selectedTempUnitFrom == 'Kelvin' && _selectedTempUnitTo == 'Celsius') {
      convertedTemperature = temperature - 273.15;
    } else if (_selectedTempUnitFrom == 'Fahrenheit' && _selectedTempUnitTo == 'Kelvin') {
      convertedTemperature = (temperature - 32) * 5 / 9 + 273.15;
    } else if (_selectedTempUnitFrom == 'Kelvin' && _selectedTempUnitTo == 'Fahrenheit') {
      convertedTemperature = (temperature - 273.15) * 9 / 5 + 32;
    } else {
      convertedTemperature = temperature; // Same unit conversion
    }
    setState(() {
      _temperatureResult = 'Converted Temperature: ${convertedTemperature.toStringAsFixed(2)} $_selectedTempUnitTo';
    });
  }

  // Function to calculate Speed, Distance, Time
  void _calculateSDT() {
    double speed = double.tryParse(_speedController.text) ?? 0;
    double distance = double.tryParse(_distanceController.text) ?? 0;
    double time = double.tryParse(_timeController.text) ?? 0;
    if (speed > 0 && distance > 0) {
      time = distance / speed;
      setState(() {
        _sdtResult = 'Time: ${time.toStringAsFixed(2)} hours';
      });
    } else if (time > 0 && distance > 0) {
      speed = distance / time;
      setState(() {
        _sdtResult = 'Speed: ${speed.toStringAsFixed(2)} units/hour';
      });
    } else if (speed > 0 && time > 0) {
      distance = speed * time;
      setState(() {
        _sdtResult = 'Distance: ${distance.toStringAsFixed(2)} units';
      });
    }
  }

  // Function to calculate Discount
  void _calculateDiscount() {
    double originalPrice = double.tryParse(_originalPriceController.text) ?? 0;
    double discountPercentage = double.tryParse(_discountPercentageController.text) ?? 0;
    double discountAmount = (originalPrice * discountPercentage) / 100;
    double finalPrice = originalPrice - discountAmount;
    setState(() {
      _discountResult = 'Final Price: \$${finalPrice.toStringAsFixed(2)} (Discount: \$${discountAmount.toStringAsFixed(2)})';
    });
  }

  // Function to calculate Fuel Efficiency
  void _calculateFuelEfficiency() {
    double miles = double.tryParse(_milesController.text) ?? 0;
    double gallons = double.tryParse(_gallonsController.text) ?? 0;
    if (gallons > 0) {
      double mpg = miles / gallons;
      setState(() {
        _fuelEfficiencyResult = 'Fuel Efficiency: ${mpg.toStringAsFixed(2)} miles per gallon';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculators'),
        backgroundColor: Colors.brown,
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(

              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedUtility = 0; // BMI
                    });
                  },
                  child: Text('BMI Calculator'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedUtility = 1; // Tip
                    });
                  },
                  child: Text('Tip Calculator'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedUtility = 2; // Age
                    });
                  },
                  child: Text('Age Calculator'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedUtility = 3; // Currency
                    });
                  },
                  child: Text('Currency Converter'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedUtility = 4; // To-Do
                    });
                  },
                  child: Text('To-Do List'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedUtility = 5; // Quadratic
                    });
                  },
                  child: Text('Quadratic Solver'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedUtility = 6; // Temperature
                    });
                  },
                  child: Text('Temperature Converter'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedUtility = 7; // SDT
                    });
                  },
                  child: Text('SDT Calculator'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedUtility = 8; // Discount
                    });
                  },
                  child: Text('Discount Calculator'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedUtility = 9; // Fuel
                    });
                  },
                  child: Text('Fuel Efficiency'),
                ),
              ],
                        ),
            ),
          SizedBox(height: 20),
          // BMI Calculator
          if (_selectedUtility == 0) ...[
      TextField(
      controller: _weightController,
      decoration: InputDecoration(labelText: 'Weight (kg)'),
      keyboardType: TextInputType.number,
    ),
    TextField(
    controller: _heightController,
    decoration: InputDecoration(labelText: 'Height (cm)'),
    keyboardType: TextInputType.number,
    ),
    ElevatedButton(
    onPressed: _calculateBMI,
    child: Text('Calculate BMI'),
    ),
    Text(_bmiResult),
    ]
    // Tip Calculator
    else if (_selectedUtility == 1) ...[
    TextField(
    controller: _billController,
    decoration: InputDecoration(labelText: 'Bill Amount (\$)'),
    keyboardType: TextInputType.number,
    ),
    TextField(
    controller: _tipController,
    decoration: InputDecoration(labelText: 'Tip Percentage (%)'),
    keyboardType: TextInputType.number,
    ),
    ElevatedButton(
    onPressed: _calculateTip,
    child: Text('Calculate Tip'),
    ),
    Text(_tipResult),
    ]
    // Age Calculator
    else if (_selectedUtility == 2) ...[
    TextField(
    controller: _dobController,
    decoration: InputDecoration(labelText: 'Date of Birth (YYYY-MM-DD)'),
    keyboardType: TextInputType.datetime,
    ),
    ElevatedButton(
    onPressed: _calculateAge,
    child: Text('Calculate Age'),
    ),
    Text(_ageResult),
    ]
    // Currency Converter
    else if (_selectedUtility == 3) ...[
    TextField(
    controller: _amountController,
    decoration: InputDecoration(labelText: 'Amount'),
    keyboardType: TextInputType.number,
    ),
    DropdownButton<String>(
    value: _selectedCurrencyFrom,
    items: _exchangeRates.keys.map((String currency) {
    return DropdownMenuItem(
    value: currency,
    child: Text(currency),
    );
    }).toList(),
    onChanged: (value) {
    setState(() {
    _selectedCurrencyFrom = value!;
    });
    },
    ),
    DropdownButton<String>(
    value: _selectedCurrencyTo,
    items: _exchangeRates.keys.map((String currency) {
    return DropdownMenuItem(
    value: currency,
    child: Text(currency),
    );
    }).toList(),
    onChanged: (value) {
    setState(() {
    _selectedCurrencyTo = value!;
    });
    },
    ),
    ElevatedButton(
    onPressed: _convertCurrency,
    child: Text('Convert Currency'),
    ),
    Text(_currencyResult),
    ]
    // To-Do List
    else if (_selectedUtility == 4) ...[
    TextField(
    controller: _taskController,
    decoration: InputDecoration(labelText: 'New Task'),
    ),
    ElevatedButton(
    onPressed: _addTask,
    child: Text('Add Task'),
    ),
    Expanded(
    child: ListView.builder(
    itemCount: _tasks.length,
    itemBuilder: (context, index) {
    return ListTile(
    title: Text(_tasks[index]),
    trailing: IconButton(
    icon: Icon(Icons.delete),
    onPressed: () => _removeTask(index),
    ),
    );
    },
    ),
    ),
    ]
    // Quadratic Equation Solver
    else if (_selectedUtility == 5) ...[
    TextField(
    controller: _aController,
    decoration: InputDecoration(labelText: 'Coefficient a'),
    keyboardType: TextInputType.number,
    ),
    TextField(
    controller: _bController,
    decoration: InputDecoration(labelText: 'Coefficient b'),
    keyboardType: TextInputType.number,
    ),
    TextField(
    controller: _cController,
    decoration: InputDecoration(labelText: 'Coefficient c'),
    keyboardType: TextInputType.number,
    ),
    ElevatedButton(
    onPressed: _solveQuadratic,
    child: Text('Solve Quadratic'),
    ),
    Text(_quadraticResult),
    ]
    // Temperature Converter
    else if (_selectedUtility == 6) ...[
    TextField(
    controller: _temperatureController,
    decoration: InputDecoration(labelText: 'Temperature'),
    keyboardType: TextInputType.number,
    ),
    DropdownButton<String>(
    value: _selectedTempUnitFrom,
    items: ['Celsius', 'Fahrenheit', 'Kelvin'].map((String unit) {
    return DropdownMenuItem(
    value: unit,
    child: Text(unit),
    );
    }).toList(),
    onChanged: (value) {
    setState(() {
    _selectedTempUnitFrom = value!;
    });
    },
    ),
    DropdownButton<String>(
    value: _selectedTempUnitTo,
    items: ['Celsius', 'Fahrenheit', 'Kelvin'].map((String unit) {
    return DropdownMenuItem(
    value: unit,
    child: Text(unit),
    );
    }).toList(),
    onChanged: (value) {
    setState(() {
    _selectedTempUnitTo = value!;
    });
    },
    ),
    ElevatedButton(
    onPressed: _convertTemperature,
    child: Text('Convert Temperature'),
    ),
    Text(_temperatureResult),
    ]
    // Speed Distance Time Calculator
    else if (_selectedUtility == 7) ...[
    TextField(
    controller: _speedController,
    decoration: InputDecoration(labelText: 'Speed'),
    keyboardType: TextInputType.number,
    ),
    TextField(
    controller: _distanceController,
    decoration: InputDecoration(labelText: 'Distance'),
    keyboardType: TextInputType.number,
    ),
    TextField(
    controller: _timeController,
    decoration: InputDecoration(labelText: 'Time'),
    keyboardType: TextInputType.number,
    ),
    ElevatedButton(
    onPressed: _calculateSDT,
    child: Text('Calculate'),
    )
     ]
    else if (_selectedUtility == 8) ...[
    TextField(
    controller: _originalPriceController,
    decoration: InputDecoration(labelText: 'Original Price'),
    keyboardType: TextInputType.number,
    ),
    TextField(
    controller: _discountPercentageController,
    decoration: InputDecoration(labelText: 'Discount Price'),
    keyboardType: TextInputType.number,
    ),

    ElevatedButton(
    onPressed: _calculateDiscount,
    child: Text('Calculate'),
    ),
                          Text(_discountResult),
    ]
    else if (_selectedUtility == 9) ...[
    TextField(
    controller: _milesController,
    decoration: InputDecoration(labelText: 'Enter Miles'),
    keyboardType: TextInputType.number,
    ),
    TextField(
    controller: _gallonsController,
    decoration: InputDecoration(labelText: 'Enter Gallon'),
    keyboardType: TextInputType.number,
    ),
    ElevatedButton(
    onPressed: _calculateFuelEfficiency,
    child: Text('Calculate'),
    ),
    Text(_fuelEfficiencyResult),
    ]
    ]
    )
    )
    );
  }
}