//
//  ViewController.swift
//  CocTale
//
//  Created by ZHI XUAN MO on 9/8/20.
//  Copyright © 2020 zhixuan mo. All rights reserved.
//

import UIKit

//MARK:- Constants
private let  kHomeSelectedImg = "pencil.circle"
private let  kHomeUnselectedImg = "pencil.circle.fill"
private let  kHomeVCTitle = "Discover"
private let  kTabBarH : CGFloat = 120


//MARK:- MainViewController
class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureControllers()
        tabbarSetup()
    }
    
    override func viewWillLayoutSubviews() {
        var tabFrame = self.tabBar.frame
        tabFrame.size.height = 60
        tabFrame.origin.y = self.view.frame.size.height - 70
        self.tabBar.frame = tabFrame
    }
    


}
//MARK:- Customize Tab Bar
extension MainViewController
{
    func tabbarSetup()
    {
        self.tabBar.shadowImage = UIImage()
        self.tabBar.backgroundImage = UIImage()
        self.tabBar.clipsToBounds = true
        self.tabBar.isTranslucent = true
        self.tabBar.frame.size.height = kTabBarH
        self.tabBar.backgroundColor = UIColor.init(r: kBackGroundRGB.0, g: kBackGroundRGB.1, b: kBackGroundRGB.2)
        self.tabBar.tintColor = UIColor.white
    }
//MARK:- TaskBar Style
    override var preferredStatusBarStyle: UIStatusBarStyle
        {
        return .lightContent
    }
}


//MARK:- Navigation Controller
extension MainViewController
{
    
    private func configureNavController(unselectedImg : UIImage , selectedImg: UIImage , rootViewController : UIViewController = UIViewController()) -> UINavigationController
    {
        let navVC = UINavigationController(rootViewController: rootViewController)
        navVC.tabBarItem.selectedImage = selectedImg
        navVC.tabBarItem.image = unselectedImg
        navVC.navigationBar.tintColor = .black
        return navVC
    }
   
}


//MARK:- TabBar Contents
extension MainViewController
{
    
    private func configureControllers()
       {
           //Home Controller
           let homeVC = configureNavController(
               unselectedImg: UIImage.init(systemName: kHomeSelectedImg)!,
               selectedImg: UIImage.init(systemName: kHomeUnselectedImg)!,
               rootViewController: HomeViewController())
           homeVC.title = kHomeVCTitle
           self.addChild(homeVC)
                      
           
           //My Recipe Controller
        
        
        
        
           //Search Controller

        
        
       }
    
    
    
}

