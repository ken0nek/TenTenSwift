//
//  CustomButton.swift
//  TenTenSwift
//
//  Created by Ken Tominaga on 8/19/14.
//  Copyright (c) 2014 Tommy. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    
//    var animationButtons: [AnimationButton] =
//    [AnimationButton(point: CGPointMake(0, 0), type: OperatorType.Add),
//        AnimationButton(point: CGPointMake(0, 0), type: OperatorType.Divide),
//        AnimationButton(point: CGPointMake(0, 0), type: OperatorType.Subtract),
//        AnimationButton(point: CGPointMake(0, 0), type: OperatorType.Multiply)]
    var animationButtons: [AnimationButton] =
    [AnimationButton(point: CGPointMake(0, 0), type: OperatorType.Add.toRaw()),
        AnimationButton(point: CGPointMake(0, 0), type: OperatorType.Divide.toRaw()),
        AnimationButton(point: CGPointMake(0, 0), type: OperatorType.Subtract.toRaw()),
        AnimationButton(point: CGPointMake(0, 0), type: OperatorType.Multiply.toRaw())]
    var isActive: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setBackgroundImage(UIImage(named: "command_icon"), forState: UIControlState.Normal)
        self.addTarget(self, action: Selector("didPressButton"), forControlEvents: UIControlEvents.TouchUpInside)
        self.userInteractionEnabled = true
    }
    
    convenience init(point: CGPoint) {
        let width = CGFloat(60)
        let height = CGFloat(60)
        self.init(frame: CGRectMake(point.x, point.y, width, height))
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func didPressButton() {
        dismiss()
    }
    
    func expand() {
        isActive = true
        
        let centerPoint = CGPointMake(self.superview!.frame.size.width / 2, self.superview!.frame.size.height / 2)
        let radius: Int = 55
        
        for animationButton in animationButtons {
            animationButton.center = centerPoint
            self.superview!.addSubview(animationButton)
            
            let point = CGPoint(x: radius * Int(cosf(Float(M_PI_2) * Float(animationButton.type))), y: radius * Int(sinf(Float(M_PI_2) * Float(animationButton.type))))
            
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
        isActive = false
        
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
    
    func execute(type: OperatorType) {
        isActive = false
        
        let centerPoint = CGPointMake(self.superview!.frame.size.width / 2, self.superview!.frame.size.height / 2)
        
        for animationButton in animationButtons {
            if animationButton.type == type.toRaw() {
                UIView.animateWithDuration(0.6, animations: {
                    animationButton.transform = CGAffineTransformMakeScale(1.5, 1.5)
                    animationButton.alpha = 0.4
                    }, completion: {
                        (value: Bool) in
                        animationButton.removeFromSuperview()
                        animationButton.transform = CGAffineTransformMakeScale(1.0, 1.0)
                        animationButton.alpha = 1.0
                })
            } else {
                UIView.animateWithDuration(0.6, animations: {
                    animationButton.center = centerPoint
                    }, completion: {
                        (value: Bool) in
                        animationButton.removeFromSuperview()
                })
            }
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
