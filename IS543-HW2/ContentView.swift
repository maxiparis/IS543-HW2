//
//  ContentView.swift
//  IS543-HW2
//
//  Created by Maximiliano París Gaete on 9/10/24.
//
//
// Task: Write Swift functions to do the following:
//
// - Compute the ith Fibonacci number (1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, …)
// - Compute n! (factorial) for integer n ≥ 0
// - Compute the sum of all integers between two given integers (inclusive)
// - Given a number of cents, print to the console the corresponding U.S. coins that total to the given number.  Print the solution that needs the fewest coins.  Only use pennies, nickels, dimes, and quarters.  Example: for 88, the answer is “3 quarters”, “1 dime”, “3 pennies”.  Do not print the case where the solution calls for 0 of the coin (e.g. don’t print “0 nickels”).  Use the singular word if the value is 1, or the plural if the coin count is greater than 1.
//
//
//
// - Create a simple SwiftUI interface to test your four functions.  I don't care what the interface looks like, just that your program calls your four functions.

import SwiftUI

//MARK: - ContentView

struct ContentView: View {
    var body: some View {
        VStack {
            FibonacciView()
            FactorialView()
        }
    }
}

#Preview {
    ContentView()
}

//MARK: - Fibonacci

struct FibonacciView: View {
    @State var fibonacciIthNumber = ""
    @State var fibonacciResult: Int = 0
    @State var intFib: Int = 0
    
    var body: some View {
        VStack {
            // fibonacci number
            VStack {
                HStack {
                    Text("Fibonacci ith number:")
                    Spacer()
                    TextField("Enter ith number", text: $fibonacciIthNumber)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(UIKeyboardType.numberPad)
                        .onChange(of: fibonacciIthNumber) { oldValue, newValue in
                            if let intFibValue = Int(newValue) {
                                intFib = intFibValue
                            }
                        }
                }
                HStack {
                    Button("Calculate"){
                        fibonacciResult = calculateIthFibonacci(intFib)
                    }
                    .buttonStyle(BorderedButtonStyle())
                    .disabled(fibonacciIthNumber == "" || intFib > 30) //limit to computations to avoid crashing due to overload
                    
                    Spacer()
                    Text(fibonacciResult.description)
                }
            }
        }
        .padding()
    }
    
    func calculateIthFibonacci(_ ith: Int) -> Int {
        if (ith == 0 || ith == 1 || ith == 2) {
            return 1
        }
        return calculateIthFibonacci(ith-1) + calculateIthFibonacci(ith-2)
    }
}

//MARK: - Factorial
//calculates the factorial of a number: ex: factorial(4) = 4 * 3 * 2 * 1 = 24

struct FactorialView: View {
    
    @State var factorialNumber = ""
    @State var factorialResult: Int = 0
    @State var intFac: Int = 0
    
    var body: some View {
        VStack {
            HStack {
                Text("Factorial of:")
                Spacer()
                TextField("Enter number", text: $factorialNumber)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(UIKeyboardType.numberPad)
                    .onChange(of: factorialNumber) { oldValue, newValue in
                        if let intFibValue = Int(newValue) {
                            intFac = intFibValue
                        }
                    }
            }
            HStack {
                Button("Calculate"){
                    factorialResult = calculateFactorial(intFac)
                }
                .buttonStyle(BorderedButtonStyle())
                .disabled(factorialNumber == "" || intFac > 30) //limit to computations to avoid crashing due to overload
                
                Spacer()
                Text(factorialResult.description)
            }
        }
        .padding()
    }
    
    func calculateFactorial(_ ith: Int) -> Int {
        if (ith == 1) {
            return 1
        }
        return ith * calculateFactorial(ith-1)
    }
}
