//
//  HelpMortgageViewController.swift
//  FinanceCalculator
//
//  Created by Subin Chitrakar on 29/02/2020.
//  Copyright © 2020 Subin Chitrakar. All rights reserved.
//

import UIKit

class HelpMortgageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //the action function to close the help view when X button is pressed
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
