//
//  InterfaceController.swift
//  Tippy Watch Extension
//
//  Created by Andy Taylor on 10/12/15.
//  Copyright © 2015 Andy Taylor. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet var valueLabel: WKInterfaceLabel!
    
    var bill = 0.0
    
    @IBAction func tapOne() {
        bill = bill + 1.0
        valueLabel.setText("$\(bill)")
    }
    
    @IBAction func addFive() {
        bill = bill + 5.0
        valueLabel.setText("$\(bill)")
    }
    
    @IBAction func addTen() {
        bill = bill + 10.0
        valueLabel.setText("$\(bill)")
    }
    
    @IBAction func addTwenty() {
        bill = bill + 20.0
        valueLabel.setText("$\(bill)")
    }

    @IBAction func addFifty() {
        bill = bill + 50.0
        valueLabel.setText("$\(bill)")
    }
    
    @IBAction func addOneCent() {
        bill = bill + 0.01
        valueLabel.setText("$\(bill)")
    }
    
    @IBAction func addTenCents() {
        bill = bill + 0.1
        valueLabel.setText("$\(bill)")
    }
    
    @IBAction func addTwentyFiveCents() {
        bill = bill + 0.25
        valueLabel.setText("$\(bill)")
    }
    
    @IBAction func addFiddyCent() {
        bill = bill + 0.5
        valueLabel.setText("$\(bill)")
    }
    
    @IBAction func clear() {
        bill = 0.0
        valueLabel.setText("$\(bill)")
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        
        valueLabel.setText("$\(bill)")
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
