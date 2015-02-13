//
//  ViewController.swift
//  MyCalc
//
//  Created by lostleaf on 15/1/26.
//  Copyright (c) 2015年 DiaoSi. All rights reserved.
//

import UIKit
class ViewController: UIViewController {

    @IBOutlet weak var input: UILabel!
    
    @IBOutlet weak var result: UILabel!
    var isTyping = false
    var brain = CalcBrain()

    @IBAction func back(sender: UIButton) {
        if (input.text != nil) && !input.text!.isEmpty {
            input.text = dropLast(input.text!)
        }
    }
    @IBAction func enter(sender: UIButton) {
        isTyping = false
        if let evalVal = brain.eval(input.text!) {
            result.text = "\(evalVal)"
        } else {
            result.text = "Error"
        }
    }
    
    @IBAction func appendSymbol(sender: UIButton) {
        let symbol = sender.currentTitle!
        if isTyping {
            input.text = input.text! + symbol
        } else {
            input.text = symbol
            isTyping = true
        }
    }
}

