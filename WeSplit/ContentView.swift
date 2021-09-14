//
//  ContentView.swift
//  WeSplit
//
//  Created by DavidR on 13/09/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var checkoutAmount = ""
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 2
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalAmount: Double{
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkoutAmount) ?? 0
                
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        return grandTotal
    }
    var totalPerPerson: Double{
        let peopleCount = Double(numberOfPeople + 2)
        let amountPerPerson = totalAmount/peopleCount
        
        return amountPerPerson
    }
    var body: some View {
        NavigationView{
        Form{
            Section{
                TextField("Amount", text: $checkoutAmount)
                    .keyboardType(.decimalPad)
                
                Picker("Number of people",
                       selection: $numberOfPeople){
                    ForEach(2 ..< 100){
                        Text("\($0) people")
                    }
                }
            }
            Section(header: Text("How much tip do you want to leave?")){
                Picker("Tip percentage", selection:
                        $tipPercentage){
                    ForEach(0 ..< tipPercentages.count){
                        Text("\(tipPercentages[$0])%")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }.textCase(nil)
            Section(header: Text("Total amount")){
                Text("$\(totalAmount, specifier: "%.2f")")
            }.textCase(nil)
            Section(header: Text("Amount per person")){
                Text("$\(totalPerPerson, specifier: "%.2f")")
            }.textCase(nil)
        }
        .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
