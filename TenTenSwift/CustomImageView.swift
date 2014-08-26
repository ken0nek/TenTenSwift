//
//  CustomImageView.swift
//  TenTenSwift
//
//  Created by Ken Tominaga on 8/25/14.
//  Copyright (c) 2014 Tommy. All rights reserved.
//

import UIKit

class CustomImageView: UIImageView {

    var number: Fraction
    var animationButtons: [AnimationButton] =
    [AnimationButton(point: CGPointMake(0, 0), type: OperatorType.Add.toRaw()),
        AnimationButton(point: CGPointMake(0, 0), type: OperatorType.Divide.toRaw()),
        AnimationButton(point: CGPointMake(0, 0), type: OperatorType.Subtract.toRaw()),
        AnimationButton(point: CGPointMake(0, 0), type: OperatorType.Multiply.toRaw())]
    var isActive: Bool = false
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame: CGRect, number: Fraction) {
        self.number = number
        super.init(frame: frame)
        self.userInteractionEnabled = true
        // self.backgroundColor = UIColor.cyanColor()
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: Selector("didDrag:"))
        self.addGestureRecognizer(panGestureRecognizer)
        
        if number.isFraction {
            let width = CGFloat(30)
            let height = CGFloat(30)
            
            let numeratorLabel = CustomLabel(frame: CGRectMake((self.frame.size.width - width) / 2, 0, width, height))
            let denominatorLabel = CustomLabel(frame: CGRectMake(numeratorLabel.frame.origin.x, numeratorLabel.frame.size.height, width, height))
            
            numeratorLabel.text = "\(number.numerator)"
            denominatorLabel.text = "\(number.denominator)"
            
            self.addSubview(numeratorLabel)
            self.addSubview(denominatorLabel)
        } else {
            let width = CGFloat(60)
            let height = CGFloat(60)
            
            let numeratorLabel = CustomLabel(frame: CGRectMake((self.frame.size.width - width) / 2, 0, width, height))
            
            numeratorLabel.text = "\(number.numerator)"
            
            self.addSubview(numeratorLabel)
        }
    }
    
    convenience init(point: CGPoint, number: Fraction) {
        let width = CGFloat(60)
        let height = CGFloat(60)
        self.init(frame: CGRectMake(point.x, point.y, width, height), number: number)
    }
    
    func expand() {
        isActive = true
        
        let centerPoint = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2)
        let radius: Int = 55
        
        for animationButton in animationButtons {
            animationButton.center = centerPoint
            self.addSubview(animationButton)
            
            let point = CGPoint(x: radius * Int(cosf(Float(M_PI_2) * Float(animationButton.type))), y: radius * Int(sinf(Float(M_PI_2) * Float(animationButton.type))))
            
            UIView.animateWithDuration(0.4,
                delay: 0,
                usingSpringWithDamping: 0.6,
                initialSpringVelocity: 0,
                options: UIViewAnimationOptions.CurveLinear,
                animations: {
                    animationButton.center = centerPoint.add(point);
                }, completion: {
                    (value: Bool) in
            })
        }
    }
    
    func dismiss() {
        isActive = false
        
        let centerPoint = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2)
        
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
        
        let centerPoint = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2)
        
        for animationButton in animationButtons {
            if animationButton.type == type.toRaw() {
                UIView.animateWithDuration(0.6, animations: {
                    animationButton.transform = CGAffineTransformMakeScale(1.4, 1.4)
                    animationButton.alpha = 0.4
                    }, completion: {
                        (value: Bool) in
                        animationButton.removeFromSuperview()
                        animationButton.transform = CGAffineTransformMakeScale(1.0, 1.0)
                        animationButton.alpha = 1.0
                })
            } else {
                UIView.animateWithDuration(0.1, animations: {
                    animationButton.center = centerPoint
                    }, completion: {
                        (value: Bool) in
                        animationButton.removeFromSuperview()
                })
            }
        }
    }
    
    func didDrag(panGestureRecognizer: UIPanGestureRecognizer) {
        self.superview!.bringSubviewToFront(self)
        
        let myCenterPoint = self.center
        let translation = panGestureRecognizer.translationInView(self)
        // println("translation : \(translation)")
        
        updateTranslationLabel(translation)
        
        let targetPoint = myCenterPoint.add(translation)
        
        self.center = targetPoint
        
        panGestureRecognizer.setTranslation(CGPointMake(0, 0), inView: self)
        
        for someView in self.superview!.subviews {
            if let customImageView = someView as? CustomImageView {
                if !customImageView.isEqual(self) {
                    if CGRectIntersectsRect(customImageView.frame, self.frame) {
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
                                
                                let newFraction = customImageView.number.calculate(self.number, type: type)
                                
                                panGestureRecognizer.enabled = false
                                self.removeFromSuperview()
                                customImageView.alpha = 0.0
                                
                                let newImageView = CustomImageView(point: CGPointMake(customImageView.frame.origin.x, customImageView.frame.origin.y), number: newFraction)
                                newImageView.alpha = 0.4
                                newImageView.transform = CGAffineTransformMakeScale(1.4, 1.4)
                                
                                UIView.animateWithDuration(0.4, animations: {
                                    customImageView.superview!.addSubview(newImageView)
                                    newImageView.alpha = 1.0
                                    newImageView.transform = CGAffineTransformMakeScale(1.0, 1.0)
                                    }, completion: {
                                        (value: Bool) in
                                        customImageView.removeFromSuperview()
                                })
                                
                            } else { // Intersect but no action
                                
                            }
                        } else {
                            println("Inactive")
                            customImageView.expand()
                        }
                    } else { // Not intersect
                        customImageView.dismiss()
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
