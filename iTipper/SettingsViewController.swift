//
//  SettingsViewController.swift
//  iTipper
//
//  Created by Shamith Mukundan on 3/8/17.
//  Copyright © 2017 Shamith. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tipPercentageSegControl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let settings = UserDefaults.standard
        let tipPercentageIndex = settings.integer(forKey: "defaultTipPercentage")
        tipPercentageSegControl.selectedSegmentIndex = tipPercentageIndex
    }
    
    @IBAction func tipPercentageChanged(_ sender: UISegmentedControl) {
        let defaults = UserDefaults.standard
        defaults.setValue(sender.selectedSegmentIndex, forKey: "defaultTipPercentage")
        defaults.synchronize()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
