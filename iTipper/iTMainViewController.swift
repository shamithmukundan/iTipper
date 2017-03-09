//
//  iTMainViewController.swift
//  iTipper
//
//  Created by Shamith Mukundan on 3/9/17.
//  Copyright © 2017 Shamith. All rights reserved.
//

import UIKit

class iTMainViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var billAmountField: UITextField!
    @IBOutlet weak var tipPercentageSegControl: UISegmentedControl!
    @IBOutlet weak var tipAmount: UILabel!
    @IBOutlet weak var totalBillAmount: UILabel!
    var tipPercentage: Double = 0.10
    var billAmount: Double?
    
    enum tipIndex: Int {
        case ten = 0
        case fifteen
        case twenty
    }
    
    var totalAmount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.billAmountField.text = nil
        self.tipAmount.text = nil
        self.totalBillAmount.text = nil
        
        tipPercentageSegControl.selectedSegmentIndex = 0
        UserDefaults.standard.setValue(0, forKey: "defaultTipPercentage")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let settings = UserDefaults.standard
        let tipPercentageIndex = settings.integer(forKey: "defaultTipPercentage")
        tipPercentageSegControl.selectedSegmentIndex = tipPercentageIndex
        self.updateTipPercentage(tipPercentageIndex)
        self.updateBillInfo()
    }
    
    //On selection of segement controller, the fields needs to be updated.
    @IBAction func tipPercentageChanged(_ sender: UISegmentedControl) {
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = "0123456789."
        if string.trimmed() != "" {
            if (allowedCharacters.contains(string)) {
                self.billAmount = Double(((textField.text! as NSString).replacingCharacters(in: range, with: string)).trimmed())
                self.updateBillInfo()
            }
        } else {
            return true
        }
        return allowedCharacters.contains(string)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func updateTipPercentage(_ index: Int) {
        switch index {
        case tipIndex.ten.rawValue:
            self.tipPercentage = 0.10
        case tipIndex.fifteen.rawValue:
            self.tipPercentage = 0.15
        case tipIndex.twenty.rawValue:
            self.tipPercentage = 0.20
        default:
            self.tipPercentage = 0.10
        }
    }

    func updateBillInfo() {
        
        let bill = self.billAmount ?? 0.0
        
        
        let totalTip = bill * tipPercentage
        let totalBill = bill + totalTip
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        self.tipAmount.text = formatter.string(from: NSNumber(value: totalTip))
        self.totalBillAmount.text = formatter.string(from: NSNumber(value: totalBill))
    }
    
}
