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
    var tipPercentage: Double = 0.10 {
        didSet {
            let billAmount = Double(self.billAmountField.text ?? "") ?? 0.0
            self.updateBillInfo(billAmount)
        }
    }
    
    fileprivate let permittedCharacterSet = CharacterSet(charactersIn:"0123456789.%")

    
    enum TipIndex: Int {
        case ten = 0
        case fifteen
        case twenty
    }
    
//    var totalAmount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.billAmountField.text = nil
        self.billAmountField.becomeFirstResponder()
        //self.tipAmount.text = nil
        //self.totalBillAmount.text = nil
        
        tipPercentageSegControl.selectedSegmentIndex = 0
        UserDefaults.standard.setValue(TipIndex.ten.rawValue, forKey: "defaultTipPercentage")
        
        self.billAmountField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let settings = UserDefaults.standard
        let tipPercentageIndex = settings.integer(forKey: "defaultTipPercentage")
        tipPercentageSegControl.selectedSegmentIndex = tipPercentageIndex
        self.updateTipPercentage(tipPercentageIndex)
        let billAmount = Double(self.billAmountField.text ?? "") ?? 0.0
        self.updateBillInfo(billAmount)
    }

    
    //On selection of segement controller, the fields needs to be updated.
    @IBAction func tipPercentageChanged(_ sender: UISegmentedControl) {
        self.updateTipPercentage(sender.selectedSegmentIndex)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let rangeOfNonPhoneCharacters = string.rangeOfCharacter(from: self.permittedCharacterSet.inverted) {
            guard rangeOfNonPhoneCharacters.lowerBound == rangeOfNonPhoneCharacters.upperBound else {
                return false
            }
        }
        
        if string == "%" && (range.location == textField.text!.characters.count - 1 || textField.text!.characters.last == "%") {
            return false
        }
        
        return true
    }
    
    func textFieldDidChange(_ textField: UITextField) {
        self.updateBillInfo(Double(textField.text!) ?? 0.0)
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
        case TipIndex.ten.rawValue:
            self.tipPercentage = 0.10
        case TipIndex.fifteen.rawValue:
            self.tipPercentage = 0.15
        case TipIndex.twenty.rawValue:
            self.tipPercentage = 0.20
        default:
            self.tipPercentage = 0.10
        }
    }

    func updateBillInfo(_ billAmount: Double ) {
        
        let totalTip = billAmount * tipPercentage
        let totalBill = billAmount + totalTip
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        self.tipAmount.text = formatter.string(from: NSNumber(value: totalTip))
        self.totalBillAmount.text = formatter.string(from: NSNumber(value: totalBill))
    }
    
}
