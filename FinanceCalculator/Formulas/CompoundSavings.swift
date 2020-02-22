//
//  File.swift
//  FinanceCalculator
//
//  Created by Subin Chitrakar on 22/02/2020.
//  Copyright © 2020 Subin Chitrakar. All rights reserved.
//

import Foundation

class CompoundSavings{
    
    static func GetCompoundSavingsAmount(principleAmount:Double, interestRate: Double, timePeriod: Double) -> Double {
        
        var compoundSaving = 1 + (interestRate / 100 / 12)
        compoundSaving = pow(compoundSaving, 12 * timePeriod)
        compoundSaving = compoundSaving * principleAmount
        
        return compoundSaving
    }
    
    static func GetPrincipleAmount(compoundSaving: Double, interestRate: Double, timePeriod: Double) -> Double {
        var principleAmount = 1 + (interestRate / 100 / 12)
        principleAmount = pow(principleAmount, 12 * timePeriod)
        principleAmount = compoundSaving / principleAmount
        
        return principleAmount
    }
    
    static func GetInterestRate(compoundSaving: Double, principleAmount: Double, timePeriod: Double) -> Double {
        var interestRate = compoundSaving / principleAmount
        interestRate = pow(interestRate, ( 1 / ( 12 * timePeriod)))
        interestRate = (interestRate - 1) * 12
        
        return interestRate
    }
    
    static func GetTimePeriod(compoundInterest: Double, principleAmount: Double, interestRate: Double) -> Double {
        let topFormula = log(compoundInterest / principleAmount)
        let bottomFormula = 12 * log(1 + (interestRate / 100 / 12))
        let timePeriod: Double = topFormula / bottomFormula
        
        return timePeriod
    }
    
}
