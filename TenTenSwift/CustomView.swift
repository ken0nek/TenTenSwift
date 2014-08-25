//
//  CustomView.swift
//  TenTenSwift
//
//  Created by Ken Tominaga on 8/21/14.
//  Copyright (c) 2014 Tommy. All rights reserved.
//

import UIKit

class CustomView: UIView {
    
    var customImageView: CustomImageView = CustomImageView(point: CGPointMake(0, 0), number: Fraction())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.userInteractionEnabled = true
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: Selector("didDrag:"))
        self.addGestureRecognizer(panGestureRecognizer)
        
        customImageView.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2)
        self.addSubview(customImageView)
    }
    
    convenience init(point: CGPoint) {
        let width = CGFloat(60)
        let height = CGFloat(60)
        self.init(frame: CGRectMake(point.x, point.y, width, height))
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func didDrag(panGestureRecognizer: UIPanGestureRecognizer) {
        self.superview!.bringSubviewToFront(self)
        self.bringSubviewToFront(customImageView)
        
        let myCenterPoint = self.center
        let translation = panGestureRecognizer.translationInView(self)
        // println("translation : \(translation)")
        
        updateTranslationLabel(translation)

        let targetPoint = myCenterPoint.add(translation)
        
        self.center = targetPoint
        
        panGestureRecognizer.setTranslation(CGPointMake(0, 0), inView: self)
        
        for someView in self.superview!.subviews {
            if let customView = someView as? CustomView {
                if !customView.isEqual(self) {
                    if CGRectIntersectsRect(customView.frame, self.frame) {
                        let customImageView = customView.customImageView
                        if customImageView.isActive == true {
                            println("Active")
                            let sensitivity = CGFloat(15)
                            var direction = ""
                            var type = OperatorType.Add
                            if translation.x > sensitivity || translation.x < -sensitivity || translation.y > sensitivity || translation.y < -sensitivity {
                                if translation.x > sensitivity {
                                    println("right")
                                    direction = "right"
                                    type = OperatorType.Add
                                } else if translation.x < -sensitivity {
                                    println("left")
                                    direction = "left"
                                    type = OperatorType.Subtract
                                } else if translation.y > sensitivity {
                                    println("down")
                                    direction = "down"
                                    type = OperatorType.Divide
                                } else if translation.y < -sensitivity {
                                    println("up")
                                    direction = "up"
                                    type = OperatorType.Multiply
                                } else {
                                    println("undefined")
                                    direction = "undefined"
                                    customImageView.dismiss()
                                }
                                updateDirectionLabel(direction)
                                customImageView.execute(type)
                                
                                let fraction1 = Fraction(numerator: 5, denominator: 3)
                                let fraction2 = Fraction(numerator: 3, denominator: 4)
                                fraction1.calculate(fraction2, type: type)
                                
                                panGestureRecognizer.enabled = false
                                self.removeFromSuperview()
                            } else { // Intersect but no action
                                
                            }
                        } else {
                            println("Inactive")
                            customImageView.expand()
                        }
                    } else {
                        customView.customImageView.dismiss()
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
