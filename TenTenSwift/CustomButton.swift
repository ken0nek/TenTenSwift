//
//  CustomButton.swift
//  TenTenSwift
//
//  Created by Ken Tominaga on 8/19/14.
//  Copyright (c) 2014 Tommy. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setBackgroundImage(UIImage(named: "command_icon"), forState: UIControlState.Normal)
        self.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        self.addTarget(self, action: Selector("didPressButton"), forControlEvents: UIControlEvents.TouchUpInside)
        self.userInteractionEnabled = true
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: Selector("dragView:"))
        self.addGestureRecognizer(panGestureRecognizer)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func dragView(panGestureRecognizer: UIPanGestureRecognizer) {
        let movingView = panGestureRecognizer.view
        
        let point1 = panGestureRecognizer.view.center
        let point2 = panGestureRecognizer.translationInView(panGestureRecognizer.view)
        let targetPoint = point1.addPoint(point2)
        
        movingView.center = targetPoint
        
        panGestureRecognizer.setTranslation(CGPointMake(0, 0), inView: movingView)
    }

    func didPressButton() {
        
        let centerPoint = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2)
        let radius: Int = 60
        
        for i in 0 ..< 4 {
            let animationButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
            animationButton.frame = CGRectMake(0, 0, 40, 40)
            animationButton.setBackgroundImage(UIImage(named: "command_icon_\(i)"), forState: UIControlState.Normal)
            animationButton.center = centerPoint;
            self.addSubview(animationButton)
            
            let point = CGPoint(x: radius * Int(sinf(Float(M_PI_2) * Float(i))), y: radius * Int(cosf(Float(M_PI_2) * Float(i))))
            
            UIView.animateWithDuration(0.8,
                delay: 0,
                usingSpringWithDamping: 0.4,
                initialSpringVelocity: 0,
                options: UIViewAnimationOptions.CurveLinear,
                animations:{
                    animationButton.center = centerPoint.addPoint(point);
                }, completion:{
                    (value: Bool) in
                    animationButton.removeFromSuperview()
            })
        }
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect)
    {
        // Drawing code
    }
    */

}
