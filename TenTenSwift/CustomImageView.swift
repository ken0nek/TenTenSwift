//
//  CustomImageView.swift
//  TenTenSwift
//
//  Created by Ken Tominaga on 8/25/14.
//  Copyright (c) 2014 Tommy. All rights reserved.
//

import UIKit

class CustomImageView: UIImageView {

    let number: Fraction
    let animationButtons: [AnimationButton] =
    [AnimationButton(point: CGPointMake(0, 0), type: .Add),
        AnimationButton(point: CGPointMake(0, 0), type: .Divide),
        AnimationButton(point: CGPointMake(0, 0), type: .Subtract),
        AnimationButton(point: CGPointMake(0, 0), type: .Multiply)]
    let imageNamePrefix: String
    var isActive: Bool = false
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame: CGRect, number: Fraction, imageNamePrefix: String) {
        self.number = number
        self.imageNamePrefix = imageNamePrefix
        super.init(frame: frame)
        self.userInteractionEnabled = true
        self.image = UIImage(named: "numberBackground\(number.isFraction.hashValue)")
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: Selector("didDrag:"))
        self.addGestureRecognizer(panGestureRecognizer)
        
        for animationButton in animationButtons {
            animationButton.setBackgroundImage(UIImage(named: imageNamePrefix + "\(animationButton.type.toInt())"), forState: UIControlState.Normal)
            animationButton.frame = CGRectMake(0, 0, self.frame.size.width / 1.5, self.frame.size.height / 1.5)
        }
        
        if number.isFraction {
            let width = self.frame.size.width
            let height = self.frame.size.height / 2
            
            let numeratorLabel = CustomLabel(frame: CGRectMake((self.frame.size.width - width) / 2, 0, width, height))
            let denominatorLabel = CustomLabel(frame: CGRectMake(numeratorLabel.frame.origin.x, numeratorLabel.frame.size.height, width, height))
            
            numeratorLabel.text = "\(number.numerator)"
            denominatorLabel.text = "\(number.denominator)"
            
            self.addSubview(numeratorLabel)
            self.addSubview(denominatorLabel)
        } else {
            let width = self.frame.size.width
            let height = self.frame.size.height
            
            let numeratorLabel = CustomLabel(frame: CGRectMake((self.frame.size.width - width) / 2, 0, width, height))
            
            numeratorLabel.text = "\(number.numerator)"
            
            self.addSubview(numeratorLabel)
        }
    }
    
    convenience init(point: CGPoint, number: Fraction, imageNamePrefix: String) {
        let width = CGFloat(60)
        let height = CGFloat(60)
        self.init(frame: CGRectMake(point.x, point.y, width, height), number: number, imageNamePrefix: imageNamePrefix)
    }
    
    func expand() {
        isActive = true
        
        let centerPoint = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2)
        let radius: Int = Int(self.frame.size.width * 0.8)
        
        for animationButton in animationButtons {
            animationButton.center = centerPoint
            self.addSubview(animationButton)
            
            let point = CGPoint(x: radius * Int(cosf(Float(M_PI_2) * Float(animationButton.type.toInt()))), y: radius * Int(sinf(Float(M_PI_2) * Float(animationButton.type.toInt()))))
            
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
            
            UIView.animateWithDuration(0.2, animations: {
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
            if animationButton.type == type {
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
        
        let targetPoint = myCenterPoint.add(translation)
        
        self.center = targetPoint
        
        panGestureRecognizer.setTranslation(CGPointMake(0, 0), inView: self)
        
        for someView in self.superview!.subviews {
            if let customImageView = someView as? CustomImageView {
                if !customImageView.isEqual(self) {
                    if CGRectIntersectsRect(customImageView.frame, self.frame) {
                        if customImageView.isActive == true {
                            // Active
                            let sensitivity = CGFloat(13)
                            var type = OperatorType.Add
                            if translation.x > sensitivity || translation.x < -sensitivity || translation.y > sensitivity || translation.y < -sensitivity {
                                if translation.x > sensitivity {
                                    type = .Add
                                } else if translation.x < -sensitivity {
                                    type = .Subtract
                                } else if translation.y > sensitivity {
                                    type = .Divide
                                } else if translation.y < -sensitivity {
                                    type = .Multiply
                                } else {
                                    customImageView.dismiss()
                                }
                                customImageView.execute(type)
                                
                                let newFraction = customImageView.number.calculate(self.number, type: type)
                                
                                panGestureRecognizer.enabled = false
                                self.removeFromSuperview()
                                customImageView.alpha = 0.0
                                
                                let newImageView = CustomImageView(frame: CGRectMake(customImageView.frame.origin.x, customImageView.frame.origin.y, customImageView.frame.size.width, customImageView.frame.size.height), number: newFraction, imageNamePrefix: customImageView.imageNamePrefix)
                                
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
                            // Inactive
                            customImageView.expand()
                        }
                    } else { // Not intersect
                        customImageView.dismiss()
                    }
                }
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
