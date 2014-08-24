//
//  CustomButton.swift
//  TenTenSwift
//
//  Created by Ken Tominaga on 8/19/14.
//  Copyright (c) 2014 Tommy. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    
    var animationButtons: [AnimationButton] =
    [AnimationButton(frame: CGRectMake(0, 0, 40, 40), type: 0),
        AnimationButton(frame: CGRectMake(0, 0, 40, 40), type: 1),
        AnimationButton(frame: CGRectMake(0, 0, 40, 40), type: 2),
        AnimationButton(frame: CGRectMake(0, 0, 40, 40), type: 3)]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setBackgroundImage(UIImage(named: "command_icon"), forState: UIControlState.Normal)
        self.addTarget(self, action: Selector("didPressButton"), forControlEvents: UIControlEvents.TouchUpInside)
        self.userInteractionEnabled = true
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func didPressButton() {
        dismiss()
    }
    
    func animate() {
        let centerPoint = CGPointMake(self.superview!.frame.size.width / 2, self.superview!.frame.size.height / 2)
        let radius: Int = 55
        
        for animationButton in animationButtons {
            animationButton.center = centerPoint
            
            self.superview!.addSubview(animationButton)
            
            let point = CGPoint(x: radius * Int(sinf(Float(M_PI_2) * Float(animationButton.type))), y: radius * Int(cosf(Float(M_PI_2) * Float(animationButton.type))))
            
            UIView.animateWithDuration(0.4,
                delay: 0,
                usingSpringWithDamping: 0.6,
                initialSpringVelocity: 0,
                options: UIViewAnimationOptions.CurveLinear,
                animations: {
                    animationButton.center = centerPoint.addPoint(point);
                }, completion: {
                    (value: Bool) in
            })
        }
    }
    
    func dismiss() {
        let centerPoint = CGPointMake(self.superview!.frame.size.width / 2, self.superview!.frame.size.height / 2)
        
        for animationButton in animationButtons {
            
            UIView.animateWithDuration(0.1, animations: {
                    animationButton.center = centerPoint
                }, completion: {
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
