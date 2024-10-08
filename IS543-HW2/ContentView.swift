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
            IntegersSumView()
            CentsToCoinsView()
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



//MARK: - Sum of integers

struct IntegersSumView: View {
    
    @State var firstNumber = ""
    @State var secondNumber = ""
    
    @State var firstNumberInt: Int? = nil  //nil everytime the input is wrong like when someone enters a letter or something invalid.
    @State var secondNumberInt: Int? = nil
    
    @State var sumResult: Int = 0
    
    var body: some View {
        VStack {
            HStack {
                Text("Integers sum between:")
                Spacer()
            }
            HStack(alignment: .center) {
                Spacer()
                TextField("First number", text: $firstNumber)
                    .keyboardType(UIKeyboardType.numberPad)
                    .onChange(of: firstNumber) { oldValue, newValue in
                        if let convertedNumber = Int(newValue), convertedNumber >= 0 {
                            firstNumberInt = convertedNumber
                        } else {
                            firstNumberInt = nil
                        }
                    }
                TextField("Second number", text: $secondNumber)
                    .keyboardType(UIKeyboardType.numberPad)
                    .multilineTextAlignment(TextAlignment.trailing)
                    .onChange(of: secondNumber) { oldValue, newValue in
                        if let convertedNumber = Int(newValue), convertedNumber >= 0 {
                            secondNumberInt = convertedNumber
                        } else {
                            secondNumberInt = nil
                        }
                    }
                Spacer()
            }
            HStack {
                Button("Calculate"){
                    if let first = Int(firstNumber), let second = Int(secondNumber) {
                        sumResult = calculateSum(from: first, to: second)
                    }
                }
                .buttonStyle(BorderedButtonStyle())
                .disabled(shouldButtonBeDisabled()) //TODO: make a function that checks if it is disabled or what?
                Spacer()
                Text(sumResult.description)
            }
        }
        .padding()
    }
    
    func calculateSum(from numberOne: Int, to numberTwo: Int) -> Int {
        var sum = 0
        for i in numberOne...numberTwo {
            sum += i
        }
        return sum
    }
    
    func shouldButtonBeDisabled() -> Bool {
        if let firstNumberInt, let secondNumberInt {
            //disable if the first number is higher than the second number
            return firstNumberInt >= secondNumberInt
        }
        //disable if one any of the numbers is nil
        return firstNumberInt == nil || secondNumberInt == nil
    }
}


//MARK: - Cents to US Coins

struct CentsToCoinsView: View {
    
    @State var centsInput = ""
    @State var coinsResult: String = "Result"
    @State var centsInt: Int? = nil
    
    //Value of coins in cents
    let QUARTER_IN_CENTS: Int = 25
    let DIME_IN_CENTS: Int = 10
    let NICKEL_IN_CENTS: Int = 5
    let PENNY_IN_CENTS: Int = 1
    
    var body: some View {
        VStack {
            HStack {
                Text("Cents:")
                Spacer()
                TextField("Enter cents", text: $centsInput)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(UIKeyboardType.numberPad)
                    .onChange(of: centsInput) { oldValue, newValue in
                        if let centsAsInt = Int(newValue), centsAsInt > 0 {
                            centsInt = centsAsInt
                        } else {
                            centsInt = nil
                        }
                    }
            }
            
            HStack {
                Button("Calculate"){
                    if let centsInt {
                        coinsResult = convertToCoins(cents: centsInt)
                    }
                }
                .buttonStyle(BorderedButtonStyle())
                .disabled(centsInt == nil || centsInt! > 999999)
                Spacer()
                Text(coinsResult)
            }
        }
        .padding()
    }
    
    
    //TEST: Example: for 88, the answer is “3 quarters”, “1 dime”, “3 pennies”.
    
    func convertToCoins(cents: Int) -> String {
        var result = "2 quarters"
        var remainingCents = cents
        
        let quarters = coinsRequired(cents: remainingCents, coin: QUARTER_IN_CENTS)
        remainingCents -= quarters * QUARTER_IN_CENTS
        
        let dimes = coinsRequired(cents: remainingCents, coin: DIME_IN_CENTS)
        remainingCents -= dimes * DIME_IN_CENTS
        
        let nickel = coinsRequired(cents: remainingCents, coin: NICKEL_IN_CENTS)
        remainingCents -= nickel * NICKEL_IN_CENTS
        
        let pennies = coinsRequired(cents: remainingCents, coin: PENNY_IN_CENTS)
        remainingCents -= pennies * PENNY_IN_CENTS
        
        result = generateCoinString(quarters: quarters, dimes: dimes, nickels: nickel, pennies: pennies)
        
        print("\(cents) cents = \(result)") //since instructions say to print to console...
        return result
    }
    
    
   
    /**
     Returns the minimum number of coins needed for the given amount in cents.
     */
    func coinsRequired(cents: Int, coin: Int) -> Int {
        return cents / coin
    }
    
    /**
     Generates the message according to the coins passed through the parameters.
     */
    func generateCoinString(quarters: Int, dimes: Int, nickels: Int, pennies: Int) -> String {
        var message: String = ""
        var texts: [String] = []
        
        if (quarters > 0) {
            let quarterText = quarters == 1 ? "\(quarters) quarter" : "\(quarters) quarters"
            texts.append(quarterText)
        }
        
        if (dimes > 0) {
            let dimeText = dimes == 1 ? "\(dimes) dime" : "\(dimes) dimes"
            texts.append(dimeText)
        }
        
        if (nickels > 0) {
            let nickelsText = nickels == 1 ? "\(nickels) nickel" : "\(nickels) nickels"
            texts.append(nickelsText)
        }
        
        if (pennies > 0) {
            let penniesText = pennies == 1 ? "\(pennies) penny" : "\(pennies) pennies"
            texts.append(penniesText)
        }
        
        for i in texts.indices {
            message += texts[i]
            if (i != texts.count - 1) {
                message += ", "
            }
        }
        
        return message
    }
}
