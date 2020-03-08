//
//  CircularTransition.swift
//  FinanceCalculator
//
//  Created by Subin Chitrakar on 29/02/2020.
//  Copyright © 2020 Subin Chitrakar. All rights reserved.
//

import UIKit

/*
    CirculatTransition is a class which only holds the properties for the animation of help page
    The properties include
        a. A view
        b. The starting point of the View
        c. The duration of the animation
        d. The transition phase of the animation
 */
class CircularTransition: NSObject {

    var circle = UIView()
    
    var startingPoint = CGPoint.zero{
        didSet{
            circle.center = startingPoint
        }
    }
    
    var circleColor = UIColor.white
    
    var duration = 0.3
    
    enum CircularTransitionMode : Int{
        case present, dismiss, pop
    }
    
    var transitionMode:CircularTransitionMode = .present
    
}

/*
    An extension of the class which inherits from UIViewControllerAnimatedTransitioning
 */
extension CircularTransition:UIViewControllerAnimatedTransitioning{
    
    /*
        implemented method transitionDuration
        the method returns the duration of the animation
     */
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    /*
        implemented method animateTransition
        the method created a cicle view and created an animation to cover the frame if the status is present
        else created another view to cover the help view and remove it while it uncovers
     */
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        if transitionMode == .present{
            if let presentedView = transitionContext.view(forKey: UITransitionContextViewKey.to){
                let viewCenter = presentedView.center
                let viewSize = presentedView.frame.size
                
                circle = UIView()
                circle.frame = frameForCircle(withViewCenter: viewCenter, size: viewSize, startPoint: startingPoint)
                circle.layer.cornerRadius = circle.frame.size.height/2
                circle.center = startingPoint
                circle.backgroundColor = circleColor

                circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                containerView.addSubview(circle)
                
                presentedView.center = startingPoint
                presentedView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                presentedView.alpha = 0
                containerView.addSubview(presentedView)
                
                UIView.animate(withDuration: duration, animations: {
                    self.circle.transform = CGAffineTransform.identity
                    presentedView.transform = CGAffineTransform.identity
                    presentedView.alpha = 1
                    presentedView.center = viewCenter
                }, completion: { (success) in
                    transitionContext.completeTransition(success)
                })
            }
        }
        else{
            let transitionModeKey = (transitionMode == .pop) ? UITransitionContextViewKey.to : UITransitionContextViewKey.from
            if let returningView = transitionContext.view(forKey: transitionModeKey){
                
                let viewCenter = returningView.center
                let viewSize = returningView.frame.size
                
                circle.frame = frameForCircle(withViewCenter: viewCenter, size: viewSize, startPoint: startingPoint)
                circle.layer.cornerRadius = circle.frame.size.height/2
                circle.center = startingPoint
                
                UIView.animate(withDuration: duration, animations: {
                    self.circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                    returningView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                    returningView.center = self.startingPoint
                    returningView.alpha = 0
                    
                    if self.transitionMode == .pop{
                        containerView.insertSubview(returningView, belowSubview: returningView)
                        containerView.insertSubview(self.circle, belowSubview: returningView)
                    }
                    
                }, completion: { (success) in
                    returningView.center = viewCenter
                    returningView.removeFromSuperview()
                    
                    self.circle.removeFromSuperview()
                    transitionContext.completeTransition(success)
                })
            }
        }
    }
    
    /*
        Method to return the frame of the circle
     */
    func frameForCircle(withViewCenter viewCenter:CGPoint, size viewSize:CGSize, startPoint:CGPoint) -> CGRect{
        
        let xLength = fmax(startPoint.x, viewSize.width - startPoint.x)
        let yLength = fmax(startPoint.y, viewSize.height - startPoint.y)
        
        let offsetVector = sqrt(xLength * xLength + yLength * yLength) * 2
        let size = CGSize(width: offsetVector, height: offsetVector)
        
        return CGRect(origin: CGPoint.zero, size: size)
    }

}

