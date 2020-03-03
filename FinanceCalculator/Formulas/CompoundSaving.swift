//
//  CompoundInterest.swift
//  FinanceCalculator
//
//  Created by Subin Chitrakar on 24/02/2020.
//  Copyright © 2020 Subin Chitrakar. All rights reserved.
//

import Foundation

/*
    class for finding missing values for Compound Savings with monthly investment
 */
class CompoundSaving{
    
    //method to get the future value when payment is done at the end   from principle value, interest rate, time period and monthly payment
    static func getFutureValueForDepositAtEnd(principleAmount : Double, interestRate : Double, timePeriod : Double, monthlyPaymentAmount : Double) -> Double {
        
        let compoundInterestForPrinciple = principleAmount * pow((1 + interestRate / 100 / 12), 12 * timePeriod)
        
        let topFormula = (pow((1 + interestRate / 100 / 12), 12 * timePeriod)) - 1
        let bottomFormula = interestRate / 100 / 12
        
        let futureAmount = monthlyPaymentAmount * (topFormula / bottomFormula)
        
        return futureAmount + compoundInterestForPrinciple
    }
 
     //method to get the monthly payment when deposit is at the end from principle amount, interest rate, time period and future amount
    static func getMonthlyPaymentForDepositAtEnd(principleAmount : Double, interestRate : Double, timePeriod : Double, futureAmount : Double) -> Double{
        
        let compoundInterestForPrinciple = principleAmount * pow((1 + interestRate / 100 / 12), 12 * timePeriod)
        
        let topFormula = (pow((1 + interestRate / 100 / 12), 12 * timePeriod)) - 1
        let bottomFormula = interestRate / 100 / 12
        
        return (futureAmount - compoundInterestForPrinciple) / (topFormula / bottomFormula)
    }
    
    //method to get the time period of the saving when payment is done at the end from principle amount, interest rate, monthly payment and future amount
    static func getTimePeriodForDepositAtEnd(principleAmount : Double, interestRate : Double, monthlyPaymentAmount : Double, futureAmount : Double) -> Double{
        
        let leftFormulaTop = (futureAmount * (interestRate / 100 / 12)) + monthlyPaymentAmount
        let leftFormulaBottom = (principleAmount * (interestRate / 100 / 12 )) + monthlyPaymentAmount
        
        let leftFormula = log(leftFormulaTop/leftFormulaBottom)
        
        let rightForumla = 1 / (12 * log(1 + interestRate / 100 / 12))
        
        return leftFormula * rightForumla
    }
    
    //method to get the future value when payment is done at the beginning from principle value, interest rate, time period and monthly payment
    static func getFutureValueForDepositAtBeginning(principleAmount : Double, interestRate : Double, timePeriod : Double, monthlyPaymentAmount : Double) -> Double {
        
        let compoundInterestForPrinciple = principleAmount * pow((1 + interestRate / 100 / 12), 12 * timePeriod)
        
        let topFormula = (pow((1 + interestRate / 100 / 12), 12 * timePeriod)) - 1
        let bottomFormula = interestRate / 100 / 12
        let series = (1 + interestRate / 100 / 12)
        
        let futureAmount = monthlyPaymentAmount * (topFormula / bottomFormula) * series
        
        return futureAmount + compoundInterestForPrinciple
    }
    
    //method to get the monthly payment when deposit is at the beginning from principle amount, interest rate, time period and future amount
    static func getMonthlyPaymentForDepositAtBeginning(principleAmount : Double, interestRate : Double, timePeriod : Double, futureAmount : Double) -> Double{
        
        let compoundInterestForPrinciple = principleAmount * pow((1 + interestRate / 100 / 12), 12 * timePeriod)
        
        let topFormula = (pow((1 + interestRate / 100 / 12), 12 * timePeriod)) - 1
        let bottomFormula = interestRate / 100 / 12
        let series = (1 + interestRate / 100 / 12)
        
        return (futureAmount - compoundInterestForPrinciple) / ((topFormula / bottomFormula) * series)
    }
    
    //method to get the time period of the saving when payment is done at the beginning from principle amount, interest rate, monthly payment and future amount
    static func getTimePeriodForDepositAtBeginning(principleAmount : Double, interestRate : Double, monthlyPaymentAmount : Double, futureAmount : Double) -> Double{
        
        let topFormulaPartA = futureAmount + (monthlyPaymentAmount / (interestRate / 100 / 12)) + monthlyPaymentAmount
        let topFormulaPartB = principleAmount + (monthlyPaymentAmount / (interestRate / 100 / 12)) + monthlyPaymentAmount
        
        let topFormula = log(topFormulaPartA / topFormulaPartB)
        
        let bottomFormula = 12 * (log(1 + (interestRate / 100 / 12)))
        
        return topFormula / bottomFormula
    }
}
