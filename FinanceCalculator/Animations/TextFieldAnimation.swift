//
//  TextFieldAnimation.swift
//  FinanceCalculator
//
//  Created by Subin Chitrakar on 29/02/2020.
//  Copyright © 2020 Subin Chitrakar. All rights reserved.
//

import Foundation
import UIKit

/*
    The class to add animation to the text field when the value has been calculated
 */
class TextFieldAnimation
{
    /*
        method to increase the size of the textfield by 0.1 within 0.2 second
        on completion of the animation it calls another method which is scaleToNormalAnimation
     */
    static func scapeUpAnimation(textField:UITextField){
        UIView.animate(withDuration: 0.2, animations: {
            textField.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }){(success) in
            self.scaleToNormalAnimation(textField: textField)
        }
    }
    
    /*
        method to decrease the size of the textfield to its initial size 
     */
    static func scaleToNormalAnimation(textField:UITextField){
        UIView.animate(withDuration: 0.35, delay: 0.1, options: .curveEaseIn, animations: {
            textField.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: nil)
    }
}
