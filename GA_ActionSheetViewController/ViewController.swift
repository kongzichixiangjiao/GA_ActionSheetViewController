//
//  ViewController.swift
//  GA_ActionSheetViewController
//
//  Created by houjianan on 16/5/24.
//  Copyright © 2016年 houjianan. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.yellowColor()
        
        let newController = UIStoryboard(name:"Main", bundle:nil).instantiateViewControllerWithIdentifier("OneViewController")
        
        let b = UIButton()
        b.frame = CGRectMake(200, 100, 100, 100)
        b.addTarget(self, action: #selector(ViewController.action), forControlEvents: .TouchUpInside)
        b.setTitle("2", forState: .Normal)
        newController.view.addSubview(b)
        //可自定义弹出view
        let sH: CGFloat = 200
        let h = self.view.frame.size.height
        let w = self.view.frame.size.width
        let sheetView = UIButton()
        sheetView.backgroundColor = UIColor.blueColor()
        sheetView.frame = CGRectMake(0, h, w, sH)
        self.view.addSubview(sheetView)
        sheetView.addTarget(self, action: #selector(ViewController.sheetViewAction), forControlEvents: .TouchUpInside)
        
        self.makeEnvironment(newController, sheetView: sheetView)

    }
    
    func action() {
        showSheetView()
    }
    
    func sheetViewAction() {
        hideSheetView()
    }
    
}


