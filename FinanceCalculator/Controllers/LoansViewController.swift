//
//  LoansViewController.swift
//  FinanceCalculator
//
//  Created by Subin Chitrakar on 24/02/2020.
//  Copyright © 2020 Subin Chitrakar. All rights reserved.
//

import UIKit

class LoansViewController: UIViewController {

    @IBOutlet weak var txtPrincipleAmount: UITextField!
    @IBOutlet weak var txtInterestRate: UITextField!
    @IBOutlet weak var txtTimePeriod: UITextField!
    @IBOutlet weak var txtMonthlyPaymentAmount: UITextField!
    
    var emptyField = CalculationCases.empty
    
    var firstTimeOpen = true
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (firstTimeOpen){
            super.viewDidLoad()
            firstTimeOpen = false
            let sel = #selector(self.closeKeyboard)
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: sel)
            view.addGestureRecognizer(tap)
        
            let notification = NotificationCenter.default
            notification.addObserver(self, selector: #selector(self.saveData), name: UIApplication.willResignActiveNotification, object: nil)
            txtPrincipleAmount.text = defaults.string(forKey: "PrincipleAmountLoans")
            txtInterestRate.text = defaults.string(forKey: "InterestRateLoans")
            txtTimePeriod.text = defaults.string(forKey: "TimePeriodLoans")
            txtMonthlyPaymentAmount.text = defaults.string(forKey: "MonthlyPaymentAmountLoans")
        }
        closeKeyboard();
    }

    @objc func saveData(){
        defaults.set(self.txtPrincipleAmount.text, forKey: "PrincipleAmountLoans")
        defaults.set(self.txtInterestRate.text, forKey: "InterestRateLoans")
        defaults.set(self.txtTimePeriod.text, forKey: "TimePeriodLoans")
        defaults.set(self.txtMonthlyPaymentAmount.text, forKey: "MonthlyPaymentAmountLoans")
    }
    
    @objc func closeKeyboard() {
        view.endEditing(true)
        if (KeyboardStatus.open){
            var tabBarFrame: CGRect = (self.tabBarController?.tabBar.frame)!
            tabBarFrame.origin.y = KeyboardStatus.defaultLocation
            self.tabBarController?.tabBar.frame = tabBarFrame
            KeyboardStatus.open = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if (!KeyboardStatus.open){
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                if (KeyboardStatus.keyBoardHeight == -1) {
                    KeyboardStatus.keyBoardHeight = keyboardSize.origin.y - keyboardSize.height -
                        (self.tabBarController?.tabBar.frame.height)!
                }
            }
            var tabBarFrame: CGRect = (self.tabBarController?.tabBar.frame)!
            if (KeyboardStatus.defaultLocation == -1) {
                KeyboardStatus.defaultLocation = tabBarFrame.origin.y
            }
            tabBarFrame.origin.y = KeyboardStatus.keyBoardHeight
            self.tabBarController?.tabBar.frame = tabBarFrame
            KeyboardStatus.open = true
        }
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        var emptyFieldCounter = 0
        var result : Double = 0
        
        let principleAmount: Double! = Double(txtPrincipleAmount.text!)
        if principleAmount == nil {
            emptyField = CalculationCases.principleAmount
            emptyFieldCounter += 1
        }
        
        let interestRate: Double! = Double(txtInterestRate.text!)
        if interestRate == nil {
            emptyField = CalculationCases.empty
            
            let errorAlert = UIAlertController(title: "Error", message: "INTEREST RATE can't be EMPTY", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            errorAlert.addAction(okButton);
            self.present(errorAlert, animated: true, completion: nil)
        }
        
        let timePeriod: Double! = Double(txtTimePeriod.text!)
        if timePeriod == nil {
            emptyField = CalculationCases.timePeriod
            emptyFieldCounter += 1
        }
        
        let monthlyPayment: Double! = Double(txtMonthlyPaymentAmount.text!)
        if monthlyPayment == nil {
            emptyField = CalculationCases.monthlyPaymentAmount
            emptyFieldCounter += 1
        }
        
        if (emptyFieldCounter == 0 && emptyField == CalculationCases.empty) || emptyFieldCounter > 1 {
            
            emptyField = CalculationCases.empty
            
            let errorAlert = UIAlertController(title: "Error", message: "More than ONE TEXTFIELDS EMPTY", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            errorAlert.addAction(okButton);
            self.present(errorAlert, animated: true, completion: nil)
        }
        
        
        switch emptyField {
            
        case .monthlyPaymentAmount:
            result = MortgageAndLoans.getMonthlyPaymentAmount(principleAmount: principleAmount, interestRate: interestRate, timePeriod: timePeriod/12)
            txtMonthlyPaymentAmount.text = String(format: "%.2f", result)
            
        case .timePeriod:
            result = MortgageAndLoans.getTimePeriod(principleAmount: principleAmount, monthlyPaymentAmount: monthlyPayment, interestRate: interestRate)
            txtTimePeriod.text = String(format: "%.2f", result * 12)
            
        case .principleAmount:
            result = MortgageAndLoans.getPrincipleAmount(monthlyPaymentAmount: monthlyPayment, interestRate: interestRate, timePeriod: timePeriod/12)
            txtPrincipleAmount.text = String(format: "%.2f", result)
            
        default:
            return
            
        }
    }
    
}
