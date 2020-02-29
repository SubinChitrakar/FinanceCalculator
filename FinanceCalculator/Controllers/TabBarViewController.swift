//
//  TabBarViewController.swift
//  FinanceCalculator
//
//  Created by Subin Chitrakar on 26/02/2020.
//  Copyright © 2020 Subin Chitrakar. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
    let loadingLogo = UIImageView(image: UIImage(named: "Logo")!)
    let splashView  = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        splashView.backgroundColor = UIColor(red: 57/255, green: 31/255, blue: 67/255, alpha: 1.0)
        view.addSubview(splashView)
        splashView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        
        loadingLogo.contentMode = .scaleAspectFit
        splashView.addSubview(loadingLogo)
        loadingLogo.frame = CGRect(x: (splashView.frame.maxX - 120)/2, y: (splashView.frame.maxY - 120)/2, width: 120, height: 120)
        self.delegate = self
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        viewController.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1){
            self.scaleDownAnimation()
        }
    }
    
    func scaleDownAnimation(){
        UIView.animate(withDuration: 0.5, animations: {
            self.loadingLogo.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        }){(success) in
            self.scaleUpAnimation()
        }
    }
    
    func scaleUpAnimation(){
        UIView.animate(withDuration: 0.35, delay: 0.1, options: .curveEaseIn, animations: {
            self.loadingLogo.transform = self.loadingLogo.transform.rotated(by: CGFloat(Double.pi))
            self.loadingLogo.transform = CGAffineTransform(scaleX: 5, y: 5)
        }){(success) in
            self.removeSplashScreen()
        }
    }
    
    func removeSplashScreen(){
        splashView.removeFromSuperview()
    }
}
