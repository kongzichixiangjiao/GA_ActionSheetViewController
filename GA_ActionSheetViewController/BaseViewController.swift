//
//  GA_BackgroundViewController.swift
//  GA_ActionSheetViewController
//
//  Created by houjianan on 16/5/24.
//  Copyright © 2016年 houjianan. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var mainViewController: UIViewController!
    var maskView: UIView!
    var sheetView: UIView!
    
    //将主控制器添加到控制器之上，
    func makeEnvironment(mainViewController: UIViewController, sheetView: UIView?) {
        self.mainViewController = mainViewController
        self.sheetView = sheetView
        
        addChildViewController(mainViewController)
        mainViewController.view.frame = self.view.frame
        self.view.addSubview(mainViewController.view)
    }
    
    private func createMaskView() {
        self.maskView = UIView(frame: self.view.bounds)
        self.maskView.backgroundColor = UIColor.blackColor()
        self.maskView.alpha = 0
        let tap = UITapGestureRecognizer(target: self, action: #selector(BaseViewController.tapMaskView))
        self.maskView.addGestureRecognizer(tap)
        UIApplication.sharedApplication().windows[0].addSubview(maskView)
        
        UIApplication.sharedApplication().windows[0].addSubview(sheetView)
    }
    
    func tapMaskView() {
        hideSheetView()
    }
    
    func showSheetView() {
        self.createMaskView()
        
        if let v = self.mainViewController.view {
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                //第一阶段动画
                v.layer.transform = self.firstStageTransform()
                
            }) { (Bool) in
                UIView .animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                    //maskView出现动画
                    self.maskView.alpha = 0.3
                    //第二阶段动画
                    v.layer.transform = self.secondStageTransform()
                    
                    }, completion: { (Bool) in
                        //sheetView出现动画
                        UIView.animateWithDuration(0.1, animations: {
                            let sH: CGFloat = self.sheetView.frame.height
                            let h = self.view.frame.size.height
                            let w = self.view.frame.size.width
                            self.sheetView.frame = CGRectMake(0, h - sH, w, sH)
                        })
                })
            }
        }
    }
    
    func hideSheetView() {
        var frame = sheetView.frame
        frame.origin.y += sheetView.frame.size.height
        
        UIView.animateWithDuration(0.3, animations: {
            self.sheetView.frame = frame
            self.maskView.alpha = 0
            //执行第一阶段动画
            self.mainViewController.view.layer.transform = self.firstStageTransform()
        }) { (Bool) in
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                //恢复原始状态
                self.mainViewController.view.layer.transform = CATransform3DIdentity;
                }, completion: { (Bool) in
            })
        }
    }
    
    //第一阶段动画
    private func firstStageTransform() -> CATransform3D {
        var t1 = CATransform3DIdentity
        //添加m34透视效果，m34负责z轴方向的translation（移动）。值的大小效果自己感受一下，可以为正，也可以为负
        t1.m34 = 1.0 / -900
        //设置透视的旋转度数和沿着x或y或x旋转
        t1 = CATransform3DRotate(t1, 20.0 * (CGFloat)(M_PI)/180.0, 1, 0, 0)
        //缩放动画
        t1 = CATransform3DScale(t1, 0.9, 0.9, 1)
        return t1
    }
    
    //第二阶段动画
    private func secondStageTransform() -> CATransform3D {
        var t2 = CATransform3DIdentity
        t2.m34 = self.firstStageTransform().m34
        t2 = CATransform3DTranslate(t2, 0, self.view.frame.size.height * (-0.08), 0)
        t2 = CATransform3DScale(t2, 0.8, 0.8, 1)
        return t2
    }
    
    
}
