//
//  ToastMessage.swift
//  FinanceCalculator
//
//  Created by Subin Chitrakar on 11/03/2020.
//  Copyright © 2020 Subin Chitrakar. All rights reserved.
//

import Foundation
import UIKit

/*
    Class to show toast message
 */
class ToastView: UILabel {
    //a view to show the message
    var overlayView = UIView()
    //a background view to put the message on
    var backView = UIView()
    //a label to show the message
    var messageLabel = UILabel()
    
    //creating instance of the class
    class var shared: ToastView {
        struct Static {
            static let instance: ToastView = ToastView()
        }
        return Static.instance
    }
    
    /*
        A method to create the view with background color and label
     */
    func setup(_ view: UIView, message:String)
    {
        let white = UIColor ( red: 1/255, green: 0/255, blue:0/255, alpha: 0.0 )
        let red = UIColor ( red: 165/255, green: 40/255, blue:44/255, alpha: 1.0 )
        
        backView.frame = CGRect(x: 0, y: 0, width: view.frame.width , height: view.frame.height)
        backView.center = view.center
        backView.backgroundColor = white
        view.addSubview(backView)
        
        overlayView.frame = CGRect(x: 0, y: 0, width: view.frame.width - 60  , height: 50)
        overlayView.center = CGPoint(x: view.bounds.width / 2, y: view.bounds.height - 120)
        overlayView.backgroundColor = red
        overlayView.clipsToBounds = true
        overlayView.layer.cornerRadius = 10
        overlayView.alpha = 0
        
        messageLabel.frame = CGRect(x: 0, y: 0, width: overlayView.frame.width, height: 50)
        messageLabel.numberOfLines = 0
        messageLabel.textColor = UIColor.white
        messageLabel.center = overlayView.center
        messageLabel.text = message
        messageLabel.textAlignment = .center
        messageLabel.center = CGPoint(x: overlayView.bounds.width / 2, y: overlayView.bounds.height / 2)
        overlayView.addSubview(messageLabel)
        
        view.addSubview(overlayView)
    }
    
    /*
        A method to show the message and make it disappear
     */
    func showToastMessage(_ view: UIView, message:String) {
        self.setup(view, message: message)
        
        UIView.animate(withDuration: 0.25, animations: {
            self.overlayView.alpha = 1
        }) { success in
            UIView.animate(withDuration: 3, animations: {
                self.overlayView.alpha = 0
            }) { success in
                UIView.animate(withDuration: 3, animations: {
                    DispatchQueue.main.async(execute: {
                        self.overlayView.alpha = 0
                        self.messageLabel.removeFromSuperview()
                        self.overlayView.removeFromSuperview()
                        self.backView.removeFromSuperview()
                    })
                })
            }
        }
    }
}
