//
//  SimpleCalcViewController.swift
//  simple-calc
//
//  Created by Derek Han on 4/16/17.
//  Copyright © 2017 Derek Han. All rights reserved.
//

import UIKit
import Foundation

class SimpleCalcViewController: UIViewController {
    
    private var CurrentCalculation: Int!
    
    private var FirstNumber: Int!
    
    private var SecondNumber: Int!
    
    private var Operator: String? = nil
    
    private var Entered: Bool!
    
    private var Count: [Int]!
    
    private var Average: [Int]!
    
    private var CountOrAveraged: Bool?
    
    @IBOutlet weak var ResultsField: UITextField!
    
    @IBOutlet weak var Button0: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reset()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func AC(_ sender: UIButton) {
        reset()
    }
    
    private func updateResult() {
        ResultsField.text = String(CurrentCalculation)
    }
    
    private func reset() {
        Operator = nil
        CurrentCalculation = 0
        FirstNumber = 0
        SecondNumber = 0
        Count = [Int]()
        Average = [Int]()
        CountOrAveraged = false
        Entered = false
        updateResult()
    }
    
    @IBAction func OperatorClick(_ sender: UIButton) {
        Operator = sender.titleLabel!.text
    }
    
    @IBAction func NumberClick(_ sender: UIButton) {
        if numberOfDigits(in: CurrentCalculation) < 13 {
            if Operator == nil {
                FirstNumber = (FirstNumber * 10) + Int(sender.titleLabel!.text!)!
                CurrentCalculation = FirstNumber
            } else if Operator != nil && !Entered {
                SecondNumber = (SecondNumber * 10) + Int(sender.titleLabel!.text!)!
                CurrentCalculation = SecondNumber
            } else if Operator != nil && Entered {
                SecondNumber = (SecondNumber * 10) + Int(sender.titleLabel!.text!)!
                CurrentCalculation = SecondNumber
            }
        }
        updateResult()
    }
    
    @IBAction func Enter(_ sender: UIButton) {
        if (Operator != nil && Count.count == 0 && Average.count == 0) {
            if (Operator == "+") { // add
                CurrentCalculation = add(FirstNumber, SecondNumber)
            } else if (Operator == "-") { // subtract
                CurrentCalculation = subtract(FirstNumber, SecondNumber)
            } else if (Operator == "*") { // multiply
                CurrentCalculation = multiply(FirstNumber, SecondNumber)
            } else if (Operator == "/") { // divide
                CurrentCalculation = divide(FirstNumber, SecondNumber)
            } else if (Operator == "%"){ // modulo
                CurrentCalculation = mod(FirstNumber, SecondNumber)
            }
            FirstNumber = CurrentCalculation
            SecondNumber = 0
        } else if (Count.count > 0) {
            Count.append(CurrentCalculation)
            CurrentCalculation = Count.count
            FirstNumber = CurrentCalculation
            Count = [Int]()
        } else if (Average.count > 0) {
            Average.append(CurrentCalculation)
            let avg = Average.flatMap{ Double($0) }.reduce(0, +) / Double(Average.count)
            CurrentCalculation = Int(avg)
            FirstNumber = CurrentCalculation
            Average = [Int]()
        }
        Entered = true
        updateResult()
    }
    
    @IBAction func CountButton(_ sender: UIButton) {
        CountOrAveraged = true
        Count.append(CurrentCalculation)
        if (!Entered) {
            FirstNumber = 0
        } else {
            SecondNumber = 0
        }
    }
    
    @IBAction func AverageButton(_ sender: UIButton) {
        CountOrAveraged = true
        Average.append(CurrentCalculation)
        if (!Entered) {
            FirstNumber = 0
        } else {
            SecondNumber = 0
        }
    }
    
    @IBAction func FactorialButton(_ sender: UIButton) {
        CurrentCalculation = factorial(FirstNumber)
        FirstNumber = CurrentCalculation
        SecondNumber = 0
        Entered = true
        updateResult()
    }
    
    
    private func numberOfDigits(in number: Int) -> Int {
        if abs(number) < 10 {
            return 1
        } else {
            return 1 + numberOfDigits(in: number/10)
        }
    }
    
    func add(_ firstNum: Int, _ secondNum: Int) -> Int {
        return firstNum + secondNum
    }
    
    func subtract(_ firstNum: Int, _ secondNum: Int) -> Int {
        return firstNum - secondNum
    }
    
    func multiply(_ firstNum: Int, _ secondNum: Int) -> Int {
        return firstNum * secondNum
    }
    
    func divide(_ firstNum: Int, _ secondNum: Int) -> Int {
        return firstNum / secondNum
    }
    
    func mod(_ firstNum: Int, _ secondNum: Int) -> Int {
        return firstNum % secondNum
    }
    
    func factorial(_ number: Int) -> Int {
        if number < 21 {
            var result = 1
            for i in 1..<number+1 {
                result = result * i;
            }
            return result
        } else {
            return 1234567890987654321
        }
    }
    
    
}
