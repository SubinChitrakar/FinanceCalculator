//
//  SecondViewController.swift
//  FinanceCalculator
//
//  Created by Subin Chitrakar on 22/02/2020.
//  Copyright © 2020 Subin Chitrakar. All rights reserved.
//

import UIKit

class CompoundSavingsViewController: UIViewController {

    @IBOutlet weak var txtPrincipleAmount: UITextField!
    @IBOutlet weak var txtInterestRate: UITextField!
    @IBOutlet weak var txtTimePeriod: UITextField!
    @IBOutlet weak var txtMonthlyPaymentAmount: UITextField!
    @IBOutlet weak var txtFutureAmount: UITextField!
    
    @IBOutlet weak var switchPaymentAtBeginning: UISwitch!
    
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
            txtPrincipleAmount.text = defaults.string(forKey: "PrincipleAmountCompoundSavings")
            txtInterestRate.text = defaults.string(forKey: "InterestRateCompoundSavings")
            txtTimePeriod.text = defaults.string(forKey: "TimePeriodCompoundSavings")
            txtMonthlyPaymentAmount.text = defaults.string(forKey: "MonthlyPaymentAmountCompoundSavings")
            txtFutureAmount.text = defaults.string(forKey: "FutureAmountCompoundSavings")
            switchPaymentAtBeginning.isOn = defaults.bool(forKey: "SwitchForBeginningCompoundSavings")
        }
        closeKeyboard()
    }
    
    @objc func saveData(){
        defaults.set(self.txtPrincipleAmount.text, forKey: "PrincipleAmountCompoundSavings")
        defaults.set(self.txtInterestRate.text, forKey: "InterestRateCompoundSavings")
        defaults.set(self.txtTimePeriod.text, forKey: "TimePeriodCompoundSavings")
        defaults.set(self.txtMonthlyPaymentAmount.text, forKey: "MonthlyPaymentAmountCompoundSavings")
        defaults.set(self.txtFutureAmount.text, forKey: "FutureAmountCompoundSavings")
        defaults.set(self.switchPaymentAtBeginning.isOn, forKey: "SwitchForBeginningCompoundSavings")
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
    
    
    @IBAction func calculateValues(_ sender: UIButton) {
        var emptyFieldCounter = 0
        var result : Double = 0
        
        let principleAmount: Double! = Double(txtPrincipleAmount.text!)
        if principleAmount == nil {
            emptyField = CalculationCases.principleAmount
            emptyFieldCounter += 1
        }
        
        let timePeriod: Double! = Double(txtTimePeriod.text!)
        if timePeriod == nil {
            emptyField = CalculationCases.timePeriod
            emptyFieldCounter += 1
        }
        
        let monthlyPayment: Double! = Double(txtMonthlyPaymentAmount.text!)
        if monthlyPayment == nil{
            emptyField = CalculationCases.monthlyPaymentAmount
            emptyFieldCounter += 1
        }
        
        let futureAmount: Double! = Double(txtFutureAmount.text!)
        if futureAmount == nil{
            emptyField = CalculationCases.futureAmount
            emptyFieldCounter += 1
        }
        
        let interestRate: Double! = Double(txtInterestRate.text!)
        if interestRate == nil{
            
            emptyField = CalculationCases.empty
            
        }
        
        if (emptyFieldCounter == 0 && emptyField == CalculationCases.empty) || emptyFieldCounter > 1 {
            
            emptyField = CalculationCases.empty
            
            let errorAlert = UIAlertController(title: "Error", message: "More than ONE TEXTFIELDS EMPTY", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            errorAlert.addAction(okButton);
            self.present(errorAlert, animated: true, completion: nil)
        }
        
        switch emptyField {
            
        case .futureAmount:
            if switchPaymentAtBeginning.isOn {
                result = CompoundSaving.getFutureValueForDepositAtBeginning(principleAmount: principleAmount, interestRate: interestRate, timePeriod: timePeriod, monthlyPaymentAmount: monthlyPayment)
            }
            else{
                result = CompoundSaving.getFutureValueForDepositAtEnd(principleAmount: principleAmount, interestRate: interestRate, timePeriod: timePeriod, monthlyPaymentAmount: monthlyPayment)
            }
            
            txtFutureAmount.text = String(format: "%.2f", result)
        
        case .monthlyPaymentAmount:
            if switchPaymentAtBeginning.isOn {
                result = CompoundSaving.getMonthlyPaymentForDepositAtBeginning(principleAmount: principleAmount, interestRate: interestRate, timePeriod: timePeriod, futureAmount: futureAmount)
            }
            else{
                result = CompoundSaving.getMonthlyPaymentForDepositAtEnd(principleAmount: principleAmount, interestRate: interestRate, timePeriod: timePeriod, futureAmount: futureAmount)
            }
            
            txtMonthlyPaymentAmount.text = String(format: "%.2f", result)
            
        case .timePeriod:
            if switchPaymentAtBeginning.isOn {
                result = CompoundSaving.getTimePeriodForDepositAtBeginning(principleAmount: principleAmount, interestRate: interestRate, monthlyPaymentAmount: monthlyPayment, futureAmount: futureAmount)
            }
            else{
                result = CompoundSaving.getTimePeriodForDepositAtEnd(principleAmount: principleAmount, interestRate: interestRate, monthlyPaymentAmount: monthlyPayment, futureAmount: futureAmount)
            }
            
            txtTimePeriod.text = String(format: "%.2f", result)
            
        default:
            return
        }
        
    }
}
