//
//  CalcBrain.swift
//  MyCalc
//
//  Created by lostleaf on 15/2/11.
//  Copyright (c) 2015年 DiaoSi. All rights reserved.
//

import Foundation

extension String {
    
    subscript (i: Int) -> Character {
        return self[advance(self.startIndex, i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        return substringWithRange(Range(start: advance(startIndex, r.startIndex), end: advance(startIndex, r.endIndex)))
    }
}

class CalcBrain {
    private var result: Double?, current: Double?, ope: String?
    private var knownOps = Dictionary<String, (Double, Double) -> Double>()
    func enterOperand(operand: Double){
        current = operand
    }
    
    private func operate(var expr:String, rng: Range<String.Index>, op: (Double, Double) -> Double) -> Double? {
        if let lhs = eval(expr[expr.startIndex..<rng.startIndex]) {
            if let rhs = eval(expr[rng.endIndex..<expr.endIndex]) {
                return op(lhs, rhs)
            }
        }
        return nil
    }
    
    func eval(var expr: String) -> Double? {
        println(expr)
        if expr == ""{
            return nil
        }
        
        if expr[0] == "+" || expr[0] == "−" {
            expr = "0" + expr
        }
        if let plusRng = expr.rangeOfString("+", options: .BackwardsSearch) {
            return operate(expr, rng: plusRng, op: +)
        } else if let minusRng = expr.rangeOfString("−", options: .BackwardsSearch) {
            return operate(expr, rng: minusRng, op: -)
        } else if let mulRng = expr.rangeOfString("×", options: .BackwardsSearch) {
            return operate(expr, rng: mulRng, op: *)
        } else if let divRng = expr.rangeOfString("÷", options: .BackwardsSearch) {
            return operate(expr, rng: divRng, op: /)
        } else if expr[expr.startIndex] == "√" {
            if let evalVal = eval(dropFirst(expr)) {
                return sqrt(evalVal)
            } else {
                return nil
            }
        } else {
            return NSNumberFormatter().numberFromString(expr)?.doubleValue
        }
    }
    
    init (){
        knownOps["+"] = {$0 + $1}
        knownOps["−"] = {$0 - $1}
        knownOps["×"] = {$0 * $1}
        knownOps["÷"] = {$0 / $1}
    }
}