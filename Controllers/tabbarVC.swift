//
//  tabbarVC.swift
//  Netflix
//
//  Created by Amirkhouzam on 24/01/2022.
//

import UIKit

class tabbarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.selectedIndex = 0
        //self.tabBar.barTintColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        self.tabBar.tintColor = .white
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tabBar.items?.first?.image = UIImage(systemName: "house")
        self.tabBar.items?.first?.selectedImage = UIImage(systemName: "house")
        
    }
   
}
