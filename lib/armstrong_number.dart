import 'dart:io';

void armstrongNumber(int number) {
  int sum = 0;
  int temp = number;
  int n = number.toString().length;
  while (temp != 0) {
    if (n==1){
      sum += temp;
      break;
    }
    int remainder = temp % 10;
    int plus = 1;
    for (int i = 0; i < n; i++) {
      plus = plus * remainder;
    }
    sum += plus;
    temp ~/= 10; // 除以 10
  }
  if (number == sum) {
    print('$number is an Armstrong number because');
  } else {
    print('$number is not an Armstrong number');
  }
}
void main(){
  while(true) {
    print('Enter a number test if it is an Armstrong number: ');
    var input = stdin.readLineSync();
    if (input == '!') {
      break;
    }
    else {
      int number = int.parse(input!);
      armstrongNumber(number);
    }
  }
}