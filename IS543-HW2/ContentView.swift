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

struct ContentView: View {
    @State var fibonacciIthNumber = ""
    @State var fibonacciResult = ""
    
    var body: some View {
        VStack {
            // fibonacci number
            VStack {
                HStack {
                    Text("Fibonacci ith number")
                    TextField("Enter number", text: $fibonacciIthNumber)
                }
                HStack {
                    Text("    Result:")
                    Text("")
                    Spacer()
                }
            }
            

            
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
