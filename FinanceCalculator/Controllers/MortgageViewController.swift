//
//  MortgageAndLoansViewController.swift
//  FinanceCalculator
//
//  Created by Subin Chitrakar on 22/02/2020.
//  Copyright © 2020 Subin Chitrakar. All rights reserved.
//

import UIKit

class MortgageViewController: UIViewController, UIViewControllerTransitioningDelegate, UITextFieldDelegate {

    @IBOutlet weak var txtPrincipleAmount: UITextField!
    @IBOutlet weak var txtInterestRate: UITextField!
    @IBOutlet weak var txtTimePeriod: UITextField!
    @IBOutlet weak var txtYearlyPaymentAmount: UITextField!
    
    @IBOutlet weak var btnHelp: UIButton!
    
    var emptyField = CalculationCases.empty
    var firstTimeOpen = true
    
    let defaults = UserDefaults.standard
    let transition = CircularTransition()
    
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
            txtPrincipleAmount.text = defaults.string(forKey: "PrincipleAmountMortgage")
            txtInterestRate.text = defaults.string(forKey: "InterestRateMortgage")
            txtTimePeriod.text = defaults.string(forKey: "TimePeriodMortgage")
            txtYearlyPaymentAmount.text = defaults.string(forKey: "YearlyAmountMortgage")
        }
        txtPrincipleAmount.delegate = self
        txtInterestRate.delegate = self
        txtTimePeriod.delegate = self
        txtYearlyPaymentAmount.delegate = self
        closeKeyboard()
    }
    
    func textField(_ textField: UITextField,shouldChangeCharactersIn range: NSRange,replacementString string: String) -> Bool
    {
        let text = textField.text!.filter("1234567890.".contains)
        let dotCount = text.components(separatedBy: ".").count - 1
        if dotCount > 0 && string == "."
        {
            return false
        }
        StringFormatter.putSign(textField: textField, text: text)
        return true
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
    
    @objc func closeKeyboard() {
        view.endEditing(true)
        if (KeyboardStatus.open){
            var tabBarFrame: CGRect = (self.tabBarController?.tabBar.frame)!
            tabBarFrame.origin.y = KeyboardStatus.defaultLocation
            self.tabBarController?.tabBar.frame = tabBarFrame
            KeyboardStatus.open = false
        }
    }
    
    @objc func saveData(){
        defaults.set(self.txtPrincipleAmount.text, forKey: "PrincipleAmountMortgage")
        defaults.set(self.txtInterestRate.text, forKey: "InterestRateMortgage")
        defaults.set(self.txtTimePeriod.text, forKey: "TimePeriodMortgage")
        defaults.set(self.txtYearlyPaymentAmount.text, forKey: "YearlyAmountMortgage")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let helpViewController = segue.destination as! HelpMortgageViewController
        helpViewController.transitioningDelegate = self
        helpViewController.modalPresentationStyle = .custom
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = btnHelp.center
        transition.circleColor = UIColor.init(red: 57/255, green: 31/255, blue: 67/255, alpha: 1.00)
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = btnHelp.center
        transition.circleColor = UIColor.init(red: 57/255, green: 31/255, blue: 67/255, alpha: 1.00)
        return transition
    }
    
    @IBAction func calculateValues(_ sender: UIButton) {
        var emptyFieldCounter = 0
        var result : Double = 0
        
        let principleAmount: Double! = Double(txtPrincipleAmount.text!.filter("1234567890.".contains))
        if principleAmount == nil {
            emptyField = CalculationCases.principleAmount
            emptyFieldCounter += 1
        }
        
        let interestRate: Double! = Double(txtInterestRate.text!.filter("1234567890.".contains))
        if interestRate == nil {
            emptyField = CalculationCases.timePeriod
            
            let errorAlert = UIAlertController(title: "Error", message: "INTEREST RATE MISSING", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            errorAlert.addAction(okButton);
            self.present(errorAlert, animated: true, completion: nil)
        }
        
        let timePeriod: Double! = Double(txtTimePeriod.text!.filter("1234567890.".contains))
        if timePeriod == nil {
            emptyField = CalculationCases.timePeriod
            emptyFieldCounter += 1
        }
        
        let monthlyPayment: Double! = Double(txtYearlyPaymentAmount.text!.filter("1234567890.".contains))
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
            result = MortgageAndLoans.getMonthlyPaymentAmount(principleAmount: principleAmount, interestRate: interestRate, timePeriod: timePeriod)
            TextFieldAnimation.scapeUpAnimation(textField: txtYearlyPaymentAmount)
            txtYearlyPaymentAmount.text = String(format: "£ %.2f", result)
            
        case .timePeriod:
            result = MortgageAndLoans.getTimePeriod(principleAmount: principleAmount, monthlyPaymentAmount: monthlyPayment, interestRate: interestRate)
            TextFieldAnimation.scapeUpAnimation(textField: txtTimePeriod)
            txtTimePeriod.text = String(format: "%.2f", result)
            
        case .principleAmount:
            result = MortgageAndLoans.getPrincipleAmount(monthlyPaymentAmount: monthlyPayment, interestRate: interestRate, timePeriod: timePeriod)
            TextFieldAnimation.scapeUpAnimation(textField: txtPrincipleAmount)
            txtPrincipleAmount.text = String(format: "£ %.2f", result)
            
        default:
            return
            
        }
    }
}
