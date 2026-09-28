1. Display Name, Course, College and Semester
void main() {
  String name = "Ritiksha Chauhan";
  String course = "BCA";
  String college = "COER University";
  int semester = 5;

  print("Name: $name");
  print("Course: $course");
  print("College: $college");
  print("Semester: $semester");
}
2. Different Data Types

void main() {
  int age = 20;
  double percentage = 83.5;
  String name = "Ritiksha";
  bool isStudent = true;

  print("Integer: $age");
  print("Double: $percentage");
  print("String: $name");
  print("Boolean: $isStudent");
}
3. var, final and const

void main() {
  var name = "Ritiksha";
  final course = "BCA";
  const college = "COER University";

  print("Name: $name");
  print("Course: $course");
  print("College: $college");
}
4. Sum, Difference, Product and Quotient

import 'dart:io';

void main() {
  print("Enter first number:");
  double num1 = double.parse(stdin.readLineSync()!);

  print("Enter second number:");
  double num2 = double.parse(stdin.readLineSync()!);

  print("Sum = ${num1 + num2}");
  print("Difference = ${num1 - num2}");
  print("Product = ${num1 * num2}");

  if (num2 != 0) {
    print("Quotient = ${num1 / num2}");
  } else {
    print("Cannot divide by zero");
  }
}
5. Area and Perimeter of Rectangle

import 'dart:io';

void main() {
  print("Enter length:");
  double length = double.parse(stdin.readLineSync()!);

  print("Enter width:");
  double width = double.parse(stdin.readLineSync()!);

  double area = length * width;
  double perimeter = 2 * (length + width);

  print("Area = $area");
  print("Perimeter = $perimeter");
}
6. Area of a Circle

import 'dart:io';

void main() {
  print("Enter radius:");
  double radius = double.parse(stdin.readLineSync()!);

  double area = 3.14 * radius * radius;

  print("Area of Circle = $area");
}
7. Celsius to Fahrenheit

import 'dart:io';

void main() {
  print("Enter temperature in Celsius:");
  double celsius = double.parse(stdin.readLineSync()!);

  double fahrenheit = (celsius * 9 / 5) + 32;

  print("Temperature in Fahrenheit = $fahrenheit °F");
}
8. Swap Two Variables

import 'dart:io';

void main() {
  print("Enter first number:");
  int a = int.parse(stdin.readLineSync()!);

  print("Enter second number:");
  int b = int.parse(stdin.readLineSync()!);

  print("Before swapping: a = $a, b = $b");

  int temp = a;
  a = b;
  b = temp;

  print("After swapping: a = $a, b = $b");
}
9. Positive, Negative or Zero

import 'dart:io';

void main() {
  print("Enter a number:");
  double number = double.parse(stdin.readLineSync()!);

  if (number > 0) {
    print("Positive number");
  } else if (number < 0) {
    print("Negative number");
  } else {
    print("Zero");
  }
}
10. Even or Odd

import 'dart:io';

void main() {
  print("Enter a number:");
  int number = int.parse(stdin.readLineSync()!);

  if (number % 2 == 0) {
    print("Even number");
  } else {
    print("Odd number");
  }
}
11. Largest of Two Numbers

import 'dart:io';

void main() {
  print("Enter first number:");
  int a = int.parse(stdin.readLineSync()!);

  print("Enter second number:");
  int b = int.parse(stdin.readLineSync()!);

  if (a > b) {
    print("$a is the largest");
  } else if (b > a) {
    print("$b is the largest");
  } else {
    print("Both numbers are equal");
  }
}
12. Largest of Three Numbers

import 'dart:io';

void main() {
  print("Enter first number:");
  int a = int.parse(stdin.readLineSync()!);

  print("Enter second number:");
  int b = int.parse(stdin.readLineSync()!);

  print("Enter third number:");
  int c = int.parse(stdin.readLineSync()!);

  if (a >= b && a >= c) {
    print("$a is the largest");
  } else if (b >= a && b >= c) {
    print("$b is the largest");
  } else {
    print("$c is the largest");
  }
}
13. Leap Year

import 'dart:io';

void main() {
  print("Enter a year:");
  int year = int.parse(stdin.readLineSync()!);

  if ((year % 400 == 0) || (year % 4 == 0 && year % 100 != 0)) {
    print("$year is a leap year");
  } else {
    print("$year is not a leap year");
  }
}
14. Calculate Grades

import 'dart:io';

void main() {
  print("Enter percentage:");
  double percentage = double.parse(stdin.readLineSync()!);

  if (percentage >= 90) {
    print("Grade: A+");
  } else if (percentage >= 80) {
    print("Grade: A");
  } else if (percentage >= 70) {
    print("Grade: B");
  } else if (percentage >= 60) {
    print("Grade: C");
  } else if (percentage >= 50) {
    print("Grade: D");
  } else {
    print("Grade: F");
  }
}
15. Print Numbers 1 to 10

void main() {
  for (int i = 1; i <= 10; i++) {
    print(i);
  }
}
16. Even Numbers Between 1 and 50

void main() {
  for (int i = 1; i <= 50; i++) {
    if (i % 2 == 0) {
      print(i);
    }
  }
}
17. Sum of First 10 Natural Numbers

void main() {
  int sum = 0;

  for (int i = 1; i <= 10; i++) {
    sum = sum + i;
  }

  print("Sum = $sum");
}
18. Multiplication Table

import 'dart:io';

void main() {
  print("Enter a number:");
  int number = int.parse(stdin.readLineSync()!);

  for (int i = 1; i <= 10; i++) {
    print("$number x $i = ${number * i}");
  }
}
19. Factorial of a Number

import 'dart:io';

void main() {
  print("Enter a number:");
  int number = int.parse(stdin.readLineSync()!);

  int factorial = 1;

  for (int i = 1; i <= number; i++) {
    factorial = factorial * i;
  }

  print("Factorial = $factorial");
}
20. Reverse a Number Using Loop

import 'dart:io';

void main() {
  print("Enter a number:");
  int number = int.parse(stdin.readLineSync()!);

  int reverse = 0;

  while (number != 0) {
    int digit = number % 10;
    reverse = reverse * 10 + digit;
    number = number ~/ 10;
  }

  print("Reverse = $reverse");
}
21. Function to Return Sum of Two Numbers

import 'dart:io';

int addNumbers(int a, int b) {
  return a + b;
}

void main() {
  print("Enter first number:");
  int a = int.parse(stdin.readLineSync()!);

  print("Enter second number:");
  int b = int.parse(stdin.readLineSync()!);

  int result = addNumbers(a, b);

  print("Sum = $result");
}
22. Function to Check Prime Number

import 'dart:io';

bool isPrime(int number) {
  if (number < 2) {
    return false;
  }

  for (int i = 2; i < number; i++) {
    if (number % i == 0) {
      return false;
    }
  }

  return true;
}

void main() {
  print("Enter a number:");
  int number = int.parse(stdin.readLineSync()!);

  if (isPrime(number)) {
    print("$number is a prime number");
  } else {
    print("$number is not a prime number");
  }
}
23. List of Five Student Names

void main() {
  List<String> students = [
    "Ritiksha",
    "Shreya",
    "Ananya",
    "Priya",
    "Neha"
  ];

  for (String student in students) {
    print(student);
  }
}
24. Largest and Smallest Number from List

void main() {
  List<int> numbers = [25, 10, 45, 5, 30, 60];

  int largest = numbers[0];
  int smallest = numbers[0];

  for (int number in numbers) {
    if (number > largest) {
      largest = number;
    }

    if (number < smallest) {
      smallest = number;
    }
  }

  print("Largest number = $largest");
  print("Smallest number = $smallest");
}
25. Student Result Program

import 'dart:io';

void main() {
  print("Enter student name:");
  String name = stdin.readLineSync()!;

  print("Enter marks in Subject 1:");
  double marks1 = double.parse(stdin.readLineSync()!);

  print("Enter marks in Subject 2:");
  double marks2 = double.parse(stdin.readLineSync()!);

  print("Enter marks in Subject 3:");
  double marks3 = double.parse(stdin.readLineSync()!);

  double total = marks1 + marks2 + marks3;
  double percentage = total / 3;

  print("\n----- Student Result -----");
  print("Name: $name");
  print("Total Marks: $total");
  print("Percentage: ${percentage.toStringAsFixed(2)}%");

  if (marks1 >= 33 && marks2 >= 33 && marks3 >= 33) {
    print("Result: Pass");
  } else {
    print("Result: Fail");
  }
}