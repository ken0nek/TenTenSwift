//
//  CustomImageView.swift
//  TenTenSwift
//
//  Created by Ken Tominaga on 8/25/14.
//  Copyright (c) 2014 Tommy. All rights reserved.
//

import UIKit

protocol GameDelegate: class {
    func gameWillStart(customImageView: CustomImageView)
    func gameDidStart(customImageView: CustomImageView)
    func gameWillNotClear(customImageView: CustomImageView, _ newFraction: Fraction)
    func gameDidNotClear(customImageView: CustomImageView)
    func gameWillClear(customImageView: CustomImageView)
    func gameDidClear(customImageView: CustomImageView)
    
    func gameWillContinue(customImageView: CustomImageView, _ newFraction: Fraction)
}

let NumberImagePrefix: String = "number"
let NumberBackgroundImagePrefix: String = "numberBackground"

class CustomImageView: UIImageView {

    let number: Fraction
    let animationButtons: [AnimationButton] =
    [AnimationButton(point: CGPointMake(0, 0), type: .Add),
        AnimationButton(point: CGPointMake(0, 0), type: .Divide),
        AnimationButton(point: CGPointMake(0, 0), type: .Subtract),
        AnimationButton(point: CGPointMake(0, 0), type: .Multiply)]
    let imageNamePrefix: String
    var isActive: Bool = false
    var delegate: GameDelegate?
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame: CGRect, number: Fraction, imageNamePrefix: String, delegate: GameDelegate) {
        self.number = number
        self.imageNamePrefix = imageNamePrefix
        self.delegate = delegate
        super.init(frame: frame)
        self.userInteractionEnabled = true
        self.image = UIImage(named: NumberBackgroundImagePrefix + "\(number.isFraction.hashValue)")
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: Selector("didDrag:"))
        self.addGestureRecognizer(panGestureRecognizer)
        
        if number.isFraction {
            let width = self.frame.size.width
            let height = self.frame.size.height / 2
            
//            let numeratorLabel = CustomLabel(frame: CGRectMake((self.frame.size.width - width) / 2, 0, width, height))
//            let denominatorLabel = CustomLabel(frame: CGRectMake(numeratorLabel.frame.origin.x, numeratorLabel.frame.size.height, width, height))
//            
//            numeratorLabel.text = "\(number.numerator)"
//            denominatorLabel.text = "\(number.denominator)"
//            
//            self.addSubview(numeratorLabel)
//            self.addSubview(denominatorLabel)
            let numeratorImageView = NumberImageView(frame: CGRectMake((self.frame.size.width - width) / 2, 0, width, height))
            numeratorImageView.image = UIImage(named: NumberImagePrefix + "\(number.numerator)")
            self.addSubview(numeratorImageView)
            
            let denominatorImageView = NumberImageView(frame: CGRectMake(numeratorImageView.frame.origin.x, numeratorImageView.frame.size.height, width, height))
            denominatorImageView.image = UIImage(named: NumberImagePrefix + "\(number.denominator)")
            self.addSubview(denominatorImageView)
        } else {
            let width = self.frame.size.width
            let height = self.frame.size.height
            
//            let numeratorLabel = CustomLabel(frame: CGRectMake((self.frame.size.width - width) / 2, 0, width, height))
//            numeratorLabel.text = "\(number.numerator)"
//            self.addSubview(numeratorLabel)
            
            let numeratorImageView = NumberImageView(frame: CGRectMake((self.frame.size.width - width) / 2, 0, width, height))
            numeratorImageView.image = UIImage(named: NumberImagePrefix + "\(number.intValue())")
            self.addSubview(numeratorImageView)
        }
        
        let centerPoint = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2)
        
        for animationButton in animationButtons {
            animationButton.setBackgroundImage(UIImage(named: imageNamePrefix + "\(animationButton.type.toInt())"), forState: UIControlState.Normal)
            animationButton.frame = CGRectMake(0, 0, self.frame.size.width / 1.5, self.frame.size.height / 1.5)
            animationButton.center = centerPoint
            self.addSubview(animationButton)
            animationButton.alpha = 0.0
            animationButton.transform = CGAffineTransformMakeScale(0.0, 0.0)
        }
    }
    
    convenience init(point: CGPoint, number: Fraction, imageNamePrefix: String, delegate: GameDelegate) {
        let width = CGFloat(60)
        let height = CGFloat(60)
        self.init(frame: CGRectMake(point.x, point.y, width, height), number: number, imageNamePrefix: imageNamePrefix, delegate: delegate)
    }
    
    func expand() {
        isActive = true
        
        let centerPoint = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2)
        let radius: Int = Int(self.frame.size.width * 0.8)
        
        for animationButton in animationButtons {
            
            let point = CGPoint(x: radius * Int(cosf(Float(M_PI_2) * Float(animationButton.type.toInt()))), y: radius * Int(sinf(Float(M_PI_2) * Float(animationButton.type.toInt()))))
            
            UIView.animateWithDuration(0.4,
                delay: 0,
                usingSpringWithDamping: 0.6,
                initialSpringVelocity: 0,
                options: UIViewAnimationOptions.CurveLinear,
                animations: {
                    animationButton.alpha = 1.0
                    animationButton.transform = CGAffineTransformMakeScale(1.0, 1.0)
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
                animationButton.alpha = 0.0
                animationButton.transform = CGAffineTransformMakeScale(0, 0)
                }, completion: {
                    (value: Bool) in
                    animationButton.transform = CGAffineTransformMakeScale(1.0, 1.0)
            })
        }
    }
    
    func execute(type: OperatorType) {
        isActive = false
        
        let centerPoint = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2)
        
        for animationButton in animationButtons {
            if animationButton.type == type {
                UIView.animateWithDuration(0.3, animations: {
                    animationButton.transform = CGAffineTransformMakeScale(1.4, 1.4)
                    animationButton.alpha = 1.0
                    }, completion: {
                        (value: Bool) in
                        animationButton.transform = CGAffineTransformMakeScale(1.0, 1.0)
                        animationButton.alpha = 0.0
                        animationButton.center = centerPoint
                })
            } else {
                UIView.animateWithDuration(0.2, animations: {
                    animationButton.center = centerPoint
                    animationButton.alpha = 0.0
                    animationButton.transform = CGAffineTransformMakeScale(0, 0)
                    }, completion: {
                        (value: Bool) in
                        animationButton.transform = CGAffineTransformMakeScale(1.0, 1.0)
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
                            var type: OperatorType = .Add
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
                                
                                let newFraction = customImageView.number.calculate(self.number, type: type)
                                
                                panGestureRecognizer.enabled = false
                                self.removeFromSuperview()
                               
                                customImageView.execute(type)
                                
                                println("count : \(customImageView.count())")
                                
                                if customImageView.count() == 1 {
                                    if newFraction.intValue() == 10 {
                                        println("Clear")
                                        self.delegate?.gameWillClear(customImageView)
                                    } else {
                                        println("Did not clear")
                                        self.delegate?.gameWillNotClear(customImageView, newFraction)
                                    }
                                } else {
                                    // in delegate
                                    println("continue")
                                    self.delegate?.gameWillContinue(customImageView, newFraction)
                                }
                                
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
    
    func count() -> Int {
        var count = 0
        for someView in self.superview!.subviews {
            if let customImageView = someView as? CustomImageView {
                count++
            }
        }
        
        return count
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
