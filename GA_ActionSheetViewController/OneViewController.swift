//
//  OneViewController.swift
//  GA_ActionSheetViewController
//
//  Created by houjianan on 16/5/24.
//  Copyright © 2016年 houjianan. All rights reserved.
//

import UIKit

class OneViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.orangeColor()
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print(self.childViewControllers)
    }
    
    
}
