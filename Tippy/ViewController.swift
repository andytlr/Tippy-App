//
//  ViewController.swift
//  Tippy
//
//  Created by Andy Taylor on 10/8/15.
//  Copyright © 2015 Andy Taylor. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var billAmountInput: UITextField!
    
    @IBOutlet weak var tipPercentageSegmentedController: UISegmentedControl!
    
    @IBOutlet weak var tipAmountLabel: UILabel!
    
    @IBOutlet weak var billTotalLabel: UILabel!
    
    func formatMoney(cash: Double) -> String {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        return formatter.stringFromNumber(cash)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tipAmountLabel.text = "$0.00"
        billTotalLabel.text = "$0.00"
        
        billAmountInput.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func billAmountInputChanged(sender: AnyObject) {
        
        var tipAmounts = [15.0, 18.0, 20.0]
        
        let tipPercentage = tipAmounts[tipPercentageSegmentedController.selectedSegmentIndex]
        
        let bill = NSString(string: billAmountInput.text!).doubleValue
        let tip = (bill / 100) * tipPercentage
        let billTotal = bill + tip
        
        tipAmountLabel.text = "\(formatMoney(tip))"
        billTotalLabel.text = "\(formatMoney(billTotal))"
    
    }

    @IBAction func tapBackground(sender: AnyObject) {
        view.endEditing(true)
    }
    
}

