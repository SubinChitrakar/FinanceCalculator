//
//  FirstViewController.swift
//  FinanceCalculator
//
//  Created by Subin Chitrakar on 22/02/2020.
//  Copyright © 2020 Subin Chitrakar. All rights reserved.
//

import UIKit


class SimpleSavingsViewController: UIViewController{

    @IBOutlet weak var txtPrincipleAmount: UITextField!
    @IBOutlet weak var txtInterestRate: UITextField!
    @IBOutlet weak var txtTimePeriod: UITextField!
    @IBOutlet weak var txtCompoundAmount: UITextField!
    
    var emptyField = CalculationCases.empty
    
    var keyboardHeight : CGFloat = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let sel = #selector(self.closeKeyboard)
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: sel)
//        view.addGestureRecognizer(tap)
    }
    
//    @objc func closeKeyboard() {
//        view.endEditing(true)
//    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
//
//        var tabBarFrame: CGRect = CGRect(x: self.view.frame.minX, y: self.view.frame.maxY, width: self.view.frame.width, height: 30.0)
//        tabBarFrame.origin.y = self.view.frame.maxY
//        self.tabBarController?.tabBar.frame = tabBarFrame
//    }
//
//    @objc func keyboardWillShow(notification: NSNotification) {
//        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue{
//            self.keyboardHeight = keyboardSize.origin.y - keyboardSize.height - (self.tabBarController?.tabBar.frame.height)!
//        }
//
//        var tabBarFrame: CGRect = (self.tabBarController?.tabBar.frame)!
//        tabBarFrame.origin.y = self.keyboardHeight
//        UIView.animate(withDuration: 0.25, animations: { ()-> Void
//            in self.tabBarController?.tabBar.frame = tabBarFrame
//        })
//    }

    @IBAction func calculateValues(_ sender: UIButton) {
        var emptyFieldCounter = 0
        let result : Double
        
        let principleAmount: Double! = Double(txtPrincipleAmount.text!)
        if principleAmount == nil {
            emptyField = CalculationCases.principleAmount
            emptyFieldCounter += 1
        }
        
        let interestRate: Double! = Double(txtInterestRate.text!)
        if interestRate == nil {
            emptyField = CalculationCases.interestRate
            emptyFieldCounter += 1
        }
        
        let timePeriod: Double! = Double(txtTimePeriod.text!)
        if timePeriod == nil {
            emptyField = CalculationCases.timePeriod
            emptyFieldCounter += 1
        }
        
        let compoundSaving: Double! = Double(txtCompoundAmount.text!)
        if compoundSaving == nil {
            emptyField = CalculationCases.futureAmount
            emptyFieldCounter += 1
        }
        
        if (emptyFieldCounter == 0 && emptyField == CalculationCases.empty) || emptyFieldCounter > 1  {
            emptyField = CalculationCases.empty
            return
        }
        
        switch emptyField {
        case .futureAmount:
            result = SimpleSaving.getCompoundSavingsAmount(principleAmount: principleAmount, interestRate: interestRate, timePeriod: timePeriod)
            txtCompoundAmount.text = String(format: "%.2f", result)
        
        case .principleAmount:
            result = SimpleSaving.getPrincipleAmount(compoundSaving: compoundSaving, interestRate: interestRate, timePeriod: timePeriod)
            txtPrincipleAmount.text = String(format: "%.2f", result)
        
        case .interestRate:
            result = SimpleSaving.getInterestRate(compoundSaving: compoundSaving, principleAmount: principleAmount, timePeriod: timePeriod)
            txtInterestRate.text = String(format: "%.2f", result * 100)
        
        case .timePeriod:
            result = SimpleSaving.getTimePeriod(compoundInterest: compoundSaving, principleAmount: principleAmount, interestRate: interestRate)
            txtTimePeriod.text = String(format: "%.2f", result)
        
        default:
            return
        }
    }
}

