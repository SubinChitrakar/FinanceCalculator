//
//  ButtonAnimation.swift
//  FinanceCalculator
//
//  Created by Subin Chitrakar on 29/02/2020.
//  Copyright © 2020 Subin Chitrakar. All rights reserved.
//

import UIKit

class ButtonAnimation{

    static func buttonEffect(button: UIButton) {
        
        button.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 6, options: .allowUserInteraction, animations: {
            button.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
}
