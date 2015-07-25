//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by appacmp on 25/07/15.
//  Copyright (c) 2015 appcamp. All rights reserved.
//

import UIKit

class CalculatorBrain: NSObject {
    var operation: String = "="
    var operand1: Double = 0.0
    var operand2: Double = 0.0
    
    func calculate() -> Double{
        switch operation{
        case "+": return operand2 + operand1
        case "-": return operand1 - operand2;
        case "*": return operand1 * operand2;
        case "/": return operand2 == 0 ? 0: operand1 / operand2;
        default: return 0;
            
        }
    }
}
