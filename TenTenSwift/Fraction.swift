//
//  Fraction.swift
//  TenTenSwift
//
//  Created by Ken Tominaga on 8/24/14.
//  Copyright (c) 2014 Tommy. All rights reserved.
//

import UIKit

class Fraction: NSObject {
    var numerator: Int
    var denominator: Int // Int?
    var isFraction: Bool {
        get {
            return denominator != 1
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init() {
        self.numerator = 1
        self.denominator = 1
    }
    
    init(var numerator: Int, var denominator: Int) {
        
        var newNumerator = numerator
        var newDenominator = denominator
        
        if newDenominator < 0 {
            newDenominator = -newDenominator
            newNumerator = -newNumerator
        }
        
        let gcd = Fraction.calculateGCD(newNumerator, newDenominator)
        
        self.numerator = newNumerator / gcd
        self.denominator = newDenominator / gcd
    }
    
    convenience init(numerator: Int) {
        self.init(numerator: numerator, denominator: 1)
    }
    
    private class func calculateGCD(var a: Int,var _ b: Int) -> Int {
        var number = Int()
        while b != 0 {
            number = a % b
            a = b
            b = number
        }
        
        if a > 0 {
            return a
        } else {
            return -a
        }
    }
    
    func intValue() -> Int {
        return numerator
    }
    
    func fractionString() -> String {
        return "\(numerator) / \(denominator)"
    }
    
    func description() {
        if isFraction {
            println("\(fractionString()), isFraction : \(isFraction.boolValue)")
        } else {
            println("\(fractionString()), isFraction : \(isFraction.boolValue), intValue : \(intValue())")
        }
    }
    
    func descriptionOfCalculation(fraction: Fraction, type: OperatorType, newFraction: Fraction) {
        var operatorString = ""
        switch type {
        case .Add: operatorString = "+"
        case .Subtract: operatorString = "−"
        case .Multiply: operatorString = "*"
        case .Divide: operatorString = "/"
        }
        println("\(fractionString()) \(operatorString) \(fraction.fractionString()) = \(newFraction.fractionString())")
    }
    
    func inverse() -> Fraction {
        var newNumerator = numerator
        var newDenominator = denominator
        
        if newNumerator == 0 {
            return Fraction(numerator: 0)
        } else if newNumerator > 0 {
            return Fraction(numerator: newDenominator, denominator: newNumerator)
        } else {
            return Fraction(numerator: -newDenominator, denominator: -newNumerator)
        }
    }
    
    func calculate(fraction: Fraction, type: OperatorType) -> Fraction {
        var newFraction = Fraction()
        switch type {
        case .Add: newFraction = add(fraction)
        case .Subtract: newFraction = subtract(fraction)
        case .Multiply: newFraction = multiply(fraction)
        case .Divide: newFraction = divide(fraction)
        }
        
        descriptionOfCalculation(fraction, type: type, newFraction: newFraction)
        return newFraction
    }
    
    func add(fraction: Fraction) -> Fraction {
        let newNumerator = numerator * fraction.denominator + denominator * fraction.numerator
        let newDenominator = denominator * fraction.denominator
        return Fraction(numerator: newNumerator, denominator: newDenominator)
    }
    
    func subtract(fraction: Fraction) -> Fraction {
        let newFraction = Fraction(numerator: -fraction.numerator, denominator: fraction.denominator)
        return add(newFraction)
    }
    
    func multiply(fraction: Fraction) -> Fraction {
        let newNumerator = numerator * fraction.numerator
        let newDenominator = denominator * fraction.denominator
        return Fraction(numerator: newNumerator, denominator: newDenominator)
    }
    
    func divide(fraction: Fraction) -> Fraction {
        let newFraction = fraction.inverse()
        return multiply(newFraction)
    }
}
