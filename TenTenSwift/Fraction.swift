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
    var denominator: Int
    var isFraction: Bool {
        get {
            return denominator != 1
        }
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
    
    func description() {
        if isFraction {
            println("\(numerator) / \(denominator), isFraction : \(isFraction.boolValue)")
        } else {
            println("\(numerator) / \(denominator), isFraction : \(isFraction.boolValue), intValue : \(intValue())")
        }
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
    
    func addFraction(fraction: Fraction) -> Fraction {
        let newNumerator = numerator * fraction.denominator + denominator * fraction.numerator
        let newDenominator = denominator * fraction.denominator
        return Fraction(numerator: newNumerator, denominator: newDenominator)
    }
    
    func subtractFraction(fraction: Fraction) -> Fraction {
        let newFraction = Fraction(numerator: -fraction.numerator, denominator: fraction.denominator)
        return self.addFraction(newFraction)
    }
    
    func mulplicateFraction(fraction: Fraction) -> Fraction {
        let newNumerator = numerator * fraction.numerator
        let newDenominator = denominator * fraction.denominator
        return Fraction(numerator: newNumerator, denominator: newDenominator)
    }
    
    func divideFraction(fraction: Fraction) -> Fraction {
        let newFraction = fraction.inverse()
        return self.mulplicateFraction(newFraction)
    }
}
