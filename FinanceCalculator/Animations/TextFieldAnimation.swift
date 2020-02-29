//
//  TextFieldAnimation.swift
//  FinanceCalculator
//
//  Created by Subin Chitrakar on 29/02/2020.
//  Copyright © 2020 Subin Chitrakar. All rights reserved.
//

import Foundation
import UIKit

class TextFieldAnimation
{
    static func scapeUpAnimation(textField:UITextField){
        UIView.animate(withDuration: 0.2, animations: {
            textField.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }){(success) in
            self.scaleToNormalAnimation(textField: textField)
        }
    }
    
    static func scaleToNormalAnimation(textField:UITextField){
        UIView.animate(withDuration: 0.35, delay: 0.1, options: .curveEaseIn, animations: {
            textField.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: nil)
    }
}
