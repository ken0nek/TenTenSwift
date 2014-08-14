//
//  ViewController.swift
//  TenTenSwift
//
//  Created by Ken Tominaga on 6/18/14.
//  Copyright (c) 2014 Tommy. All rights reserved.
//

import UIKit
import QuartzCore

extension CGPoint {
    func addPoint(point: CGPoint) -> CGPoint {
        return CGPointMake(self.x + point.x, self.y + point.y)
    }
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let button = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        // button.setTitle("あああ", forState: UIControlState.Normal)
        button.setBackgroundImage(UIImage(named: "command_icon"), forState: UIControlState.Normal)
        button.frame = CGRectMake(320/2, 568/2, 60, 60)
        button.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        button.addTarget(self, action: Selector("didPressButton:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didPressButton(button: UIButton) {
        
        let centerPoint = CGPointMake(button.center.x, button.center.y)
        let radius: Int = 60
        var positionArray: [CGPoint] = [CGPointMake(0, 0), CGPointMake(0, 0), CGPointMake(0, 0), CGPointMake(0, 0)]
        
        for i in 0 ..< 4 {
            let point = CGPoint(x: radius * Int(sinf(Float(M_PI_2) * Float(i))), y: radius * Int(cosf(Float(M_PI_2) * Float(i))))
            positionArray[i] = centerPoint.addPoint(point)
            
            let animationButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
            animationButton.frame = CGRectMake(0, 0, 40, 40)
            // animationButton.backgroundColor = UIColor.redColor()
            animationButton.setBackgroundImage(UIImage(named: "command_icon_\(i)"), forState: UIControlState.Normal)
            animationButton.center = centerPoint;
            self.view.addSubview(animationButton)
            
            UIView.animateWithDuration(0.5,
                delay: 0,
                usingSpringWithDamping: 0.4,
                initialSpringVelocity: 0,
                options: UIViewAnimationOptions.CurveLinear,
                animations:{
                    animationButton.center = positionArray[i];
                }, completion:{
                    (value: Bool) in
                    animationButton.removeFromSuperview()
                })
            
//            let animation = CABasicAnimation(keyPath: "transform.scale")
//            animation.delegate = self
//            animation.duration = 1.0
//            animation.toValue = 1.2
//            animation.setValue(animationButton, forKey: "animationType")
//            animationButton.layer.addAnimation(animation, forKey: nil)
//            }
        }
    }
    
//    override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
//        let value = anim.valueForKey("animationType") as String
//        anim.
//    }
}

