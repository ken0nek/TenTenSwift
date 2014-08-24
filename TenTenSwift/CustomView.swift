//
//  CustomView.swift
//  TenTenSwift
//
//  Created by Ken Tominaga on 8/21/14.
//  Copyright (c) 2014 Tommy. All rights reserved.
//

import UIKit

class CustomView: UIView, UIGestureRecognizerDelegate {
    
    var customButton: CustomButton = CustomButton(frame: CGRectMake(0, 0, 0, 0))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.userInteractionEnabled = true
        self.backgroundColor = UIColor.brownColor()
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: Selector("didDrag:"))
        panGestureRecognizer.delegate = self
        self.addGestureRecognizer(panGestureRecognizer)
        
        let directions: [UISwipeGestureRecognizerDirection] = [.Right, .Left, .Up, .Down]
        for direction in directions {
            let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("didSwipe:"))
            swipeGestureRecognizer.direction = direction
            swipeGestureRecognizer.delegate = self
            self.addGestureRecognizer(swipeGestureRecognizer)
        }
        
        customButton = CustomButton(point: CGPointMake(0, 0))
        customButton.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2)
        self.addSubview(customButton)
    }
    
    convenience init(point: CGPoint) {
        let width: CGFloat = CGFloat(60)
        let height: CGFloat = CGFloat(60)
        self.init(frame: CGRectMake(point.x, point.y, width, height))
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func didDrag(panGestureRecognizer: UIPanGestureRecognizer) {
        println("pan : \(panGestureRecognizer.state.hashValue)")
        self.superview!.bringSubviewToFront(self)
        self.customButton.isActive = false
        
        let myCenterPoint = self.center
        let translation = panGestureRecognizer.translationInView(self)
        println("translation : \(translation)")
//        let location = panGestureRecognizer.locationInView(self)
//        println("location : \(location)")
        let targetPoint = myCenterPoint.addPoint(translation)
        
        self.center = targetPoint
        
        panGestureRecognizer.setTranslation(CGPointMake(0, 0), inView: self)
        
        for someView in self.superview!.subviews {
            if someView.isKindOfClass(CustomView) {
                let customView = someView as CustomView
                if CGRectIntersectsRect(customView.frame, self.frame) {
                    if !customView.isEqual(self) {
                        let customButton = customView.customButton as CustomButton
                        if customButton.isActive == true {
                            println("Active")
                            if translation.x > 10 {
                                println("right")
                            } else if translation.x < -10 {
                                println("left")
                            } else if translation.y > 10 {
                                println("down")
                            } else if translation.y < -10 {
                                println("up")
                                customButton.animationButtons[3]
                            } else {
                                println("undefined")
                            }
                        } else {
                            println("Inactive")
                            customButton.animate()
                        }
                    }
                }
            }
        }
    }
    
    func didSwipe(swipeGestureRecognizer: UISwipeGestureRecognizer) {
        println("swipe : \(swipeGestureRecognizer.state.hashValue)")
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
