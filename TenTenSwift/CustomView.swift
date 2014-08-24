//
//  CustomView.swift
//  TenTenSwift
//
//  Created by Ken Tominaga on 8/21/14.
//  Copyright (c) 2014 Tommy. All rights reserved.
//

import UIKit

class CustomView: UIView {
    
    var customButton: CustomButton = CustomButton(frame: CGRectMake(0, 0, 0, 0))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.userInteractionEnabled = true
        self.backgroundColor = UIColor.brownColor()
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: Selector("didDrag:"))
        self.addGestureRecognizer(panGestureRecognizer)
        
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
    
    func didDrag(panGestureRecognizer: UIPanGestureRecognizer) {
        println("pan : \(panGestureRecognizer.state.hashValue)")
        self.superview!.bringSubviewToFront(self)
        self.customButton.dismiss()
        
        let myCenterPoint = self.center
        let translation = panGestureRecognizer.translationInView(self)
        println("translation : \(translation)")
        
        updateTranslationLabel(translation)
        
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
                            let sensitivity: CGFloat = CGFloat(15)
                            var direction = ""
                            if translation.x > sensitivity || translation.x < -sensitivity || translation.y > sensitivity || translation.y < -sensitivity {
                                if translation.x > sensitivity {
                                    println("right")
                                    direction = "right"
                                    customButton.execute(0)
                                } else if translation.x < -sensitivity {
                                    println("left")
                                    direction = "left"
                                    customButton.execute(2)
                                } else if translation.y > sensitivity {
                                    println("down")
                                    direction = "down"
                                    customButton.execute(1)
                                } else if translation.y < -sensitivity {
                                    println("up")
                                    direction = "up"
                                    customButton.execute(3)
                                } else {
                                    println("undefined")
                                    direction = "undefined"
                                    // customButton.dismiss()
                                }
                                updateDirectionLabel(direction)
                                // panGestureRecognizer.enabled = false
                                // self.removeFromSuperview()
                            } else {
                                
                            }
                        } else {
                            println("Inactive")
                            customButton.expand()
                        }
                    }
                }
            }
        }
    }
    
    func updateDirectionLabel(direction: String) {
        let directionLabel = self.superview!.viewWithTag(1) as UILabel
        directionLabel.text = "direction : \(direction)"
    }
    
    func updateTranslationLabel(translation: CGPoint) {
        let translationLabel = self.superview!.viewWithTag(2) as UILabel
        translationLabel.text = "translation : \(translation)"
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
