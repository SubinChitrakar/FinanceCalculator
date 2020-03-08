//
//  SecondViewController.swift
//  FinanceCalculator
//
//  Created by Subin Chitrakar on 22/02/2020.
//  Copyright © 2020 Subin Chitrakar. All rights reserved.
//

import UIKit

/*
    Class to manage the Compound Saving with timely investment
*/
class CompoundSavingsViewController: UIViewController, UIViewControllerTransitioningDelegate, UITextFieldDelegate {

    //Textfield declarations
    @IBOutlet weak var txtPrincipleAmount: UITextField!
    @IBOutlet weak var txtInterestRate: UITextField!
    @IBOutlet weak var txtTimePeriod: UITextField!
    @IBOutlet weak var txtMonthlyPaymentAmount: UITextField!
    @IBOutlet weak var txtFutureAmount: UITextField!
    
    //Switch and Help button declaration
    @IBOutlet weak var switchPaymentAtBeginning: UISwitch!
    @IBOutlet weak var btnHelp: UIButton!
    
    //declaring and setting default case for calculation
    var emptyField = CalculationCases.empty
    //checking the page open
    var firstTimeOpen = true

    //user defaults to save the data of the user
    let defaults = UserDefaults.standard
    //transition to controller the help page
    let transition = CircularTransition()
    
    /*
        The method loads the view as per the storyboard
        Also, the method checks whether the page is being opened or not. In case, its opened for the first time the keyboard 
        notification is set to close the keyboard and values are set if it was set previously.

    */
    override func viewDidLoad() {        
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
        txtPrincipleAmount.delegate = self
        txtInterestRate.delegate = self
        txtTimePeriod.delegate = self
        txtMonthlyPaymentAmount.delegate = self
        txtFutureAmount.delegate = self
        closeKeyboard()
    }
    
    /*
        The method runs as a response to textfield select and adds a pound or a percentage
    */
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
    
    /*
        The method would add a notification to the keyboard when the view will appear
    */
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    /*
        The method raises the tab bar when the keyboard is displayed
    */
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
    
    /*
        The method closes the keyboard and sets the tab to its original position
    */
    @objc func closeKeyboard() {
        view.endEditing(true)
        if (KeyboardStatus.open){
            var tabBarFrame: CGRect = (self.tabBarController?.tabBar.frame)!
            tabBarFrame.origin.y = KeyboardStatus.defaultLocation
            self.tabBarController?.tabBar.frame = tabBarFrame
            KeyboardStatus.open = false
        }
    }
    
    /*
        The method saves the value to the defaults in a key value pair
    */
    @objc func saveData(){
        defaults.set(self.txtPrincipleAmount.text, forKey: "PrincipleAmountCompoundSavings")
        defaults.set(self.txtInterestRate.text, forKey: "InterestRateCompoundSavings")
        defaults.set(self.txtTimePeriod.text, forKey: "TimePeriodCompoundSavings")
        defaults.set(self.txtMonthlyPaymentAmount.text, forKey: "MonthlyPaymentAmountCompoundSavings")
        defaults.set(self.txtFutureAmount.text, forKey: "FutureAmountCompoundSavings")
        defaults.set(self.switchPaymentAtBeginning.isOn, forKey: "SwitchForBeginningCompoundSavings")
    }
    
    /*
        The method notifies the controller is gonna perform a segue
        and animation is set for the segue animation
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let helpViewController = segue.destination as! HelpCompoundSavingsViewController
        helpViewController.transitioningDelegate = self
        helpViewController.modalPresentationStyle = .custom
    }
    
    /*
        The method to show animation when clicked on the help button
    */
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = btnHelp.center
        transition.circleColor = UIColor.init(red: 57/255, green: 31/255, blue: 67/255, alpha: 1.00)
        return transition
    }
    
    /*
        The method to show animation when the help page is dismissed
    */
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = btnHelp.center
        transition.circleColor = UIColor.init(red: 57/255, green: 31/255, blue: 67/255, alpha: 1.00)
        return transition
    }
    
    /*
        The method to calculate the missing values from the view on clicking the calculate button
    */
    @IBAction func calculateValues(_ sender: UIButton) {
        var emptyFieldCounter = 0
        var result : Double = 0
        
        let principleAmount: Double! = Double(txtPrincipleAmount.text!.filter("1234567890.".contains))
        if principleAmount == nil {
            emptyField = CalculationCases.empty
            let errorAlert = UIAlertController(title: "Error", message: "PRINCIPLE AMOUNT MISSING", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            errorAlert.addAction(okButton);
            self.present(errorAlert, animated: true, completion: nil)
        }
        
        let timePeriod: Double! = Double(txtTimePeriod.text!.filter("1234567890.".contains))
        if timePeriod == nil {
            emptyField = CalculationCases.timePeriod
            emptyFieldCounter += 1
        }
        
        let monthlyPayment: Double! = Double(txtMonthlyPaymentAmount.text!.filter("1234567890.".contains))
        if monthlyPayment == nil{
            emptyField = CalculationCases.monthlyPaymentAmount
            emptyFieldCounter += 1
        }
        
        let futureAmount: Double! = Double(txtFutureAmount.text!.filter("1234567890.".contains))
        if futureAmount == nil{
            emptyField = CalculationCases.futureAmount
            emptyFieldCounter += 1
        }
        
        let interestRate: Double! = Double(txtInterestRate.text!.filter("1234567890.".contains))
        if interestRate == nil{
            emptyField = CalculationCases.empty
            let errorAlert = UIAlertController(title: "Error", message: "INTEREST RATE MISSING", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            errorAlert.addAction(okButton);
            self.present(errorAlert, animated: true, completion: nil)
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
            TextFieldAnimation.scapeUpAnimation(textField: txtFutureAmount)
            txtFutureAmount.text = String(format: "£ %.2f", result)
        
        case .monthlyPaymentAmount:
            if switchPaymentAtBeginning.isOn {
                result = CompoundSaving.getMonthlyPaymentForDepositAtBeginning(principleAmount: principleAmount, interestRate: interestRate, timePeriod: timePeriod, futureAmount: futureAmount)
            }
            else{
                result = CompoundSaving.getMonthlyPaymentForDepositAtEnd(principleAmount: principleAmount, interestRate: interestRate, timePeriod: timePeriod, futureAmount: futureAmount)
            }
            TextFieldAnimation.scapeUpAnimation(textField: txtMonthlyPaymentAmount)
            txtMonthlyPaymentAmount.text = String(format: "£ %.2f", result)
            
        case .timePeriod:
            if switchPaymentAtBeginning.isOn {
                result = CompoundSaving.getTimePeriodForDepositAtBeginning(principleAmount: principleAmount, interestRate: interestRate, monthlyPaymentAmount: monthlyPayment, futureAmount: futureAmount)
            }
            else{
                result = CompoundSaving.getTimePeriodForDepositAtEnd(principleAmount: principleAmount, interestRate: interestRate, monthlyPaymentAmount: monthlyPayment, futureAmount: futureAmount)
            }
            TextFieldAnimation.scapeUpAnimation(textField: txtTimePeriod)
            txtTimePeriod.text = String(format: "%.2f", result)
            
        default:
            return
        }
        
    }
}

