//
//  CustomButton.swift
//  TenTenSwift
//
//  Created by Ken Tominaga on 8/19/14.
//  Copyright (c) 2014 Tommy. All rights reserved.
//

import UIKit

let CommandIconPrefixString: String = "command_icon"
let GameLevelSelectPrefixString: String = "gameLevelSelect"

enum Direction {
    case Right, Left, Up, Down
    
    func toOperatorType() -> OperatorType {
        switch self {
        case .Right: return .Add
        case .Left: return .Subtract
        case .Up: return .Multiply
        case .Down: return .Divide
        }
    }
    
    func toGameLevel() -> GameLevel {
        switch self {
        case .Right: return .Easy
        case .Left: return .Hard
        case .Up: return .Normal
        case .Down: return .Easy
        }
    }
}

class CustomButton: UIButton {
    
    let animationButtons: [AnimationButton] =
    [AnimationButton(point: CGPointMake(0, 0), type: .Add),
        AnimationButton(point: CGPointMake(0, 0), type: .Divide),
        AnimationButton(point: CGPointMake(0, 0), type: .Subtract),
        AnimationButton(point: CGPointMake(0, 0), type: .Multiply)]
    let imageNamePrefix: String
    var isActive: Bool = false
    
    init(frame: CGRect, imageNamePrefix: String) {
        self.imageNamePrefix = imageNamePrefix
        super.init(frame: frame)
        self.setBackgroundImage(UIImage(named: self.imageNamePrefix), forState: UIControlState.Normal)
        self.addTarget(self, action: Selector("didPressButton"), forControlEvents: UIControlEvents.TouchDown)
        self.addTarget(self, action: Selector("didReleaseButton"), forControlEvents: UIControlEvents.TouchUpInside)
        self.userInteractionEnabled = true
        
        let directions: [UISwipeGestureRecognizerDirection] = [.Right, .Left, .Up, .Down]
        for direction in directions {
            let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("didSwipe:"))
            swipeGestureRecognizer.direction = direction
            self.addGestureRecognizer(swipeGestureRecognizer)
        }
        
        let centerPoint = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2)
        
        for animationButton in animationButtons {
            animationButton.setBackgroundImage(UIImage(named: imageNamePrefix + "\(animationButton.type.toInt())"), forState: UIControlState.Normal)
            animationButton.frame = CGRectMake(0, 0, self.frame.size.width / 1.2, self.frame.size.height / 1.2)
            animationButton.center = centerPoint
            self.addSubview(animationButton)
            animationButton.alpha = 0.0
            animationButton.transform = CGAffineTransformMakeScale(0.0, 0.0)
        }
    }
    
    convenience init(point: CGPoint, imageNamePrefix: String) {
        let width = CGFloat(60)
        let height = CGFloat(60)
        self.init(frame: CGRectMake(point.x, point.y, width, height), imageNamePrefix: imageNamePrefix)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func didSwipe(swipeGestureRecognizer: UISwipeGestureRecognizer) {
        self.superview!.bringSubviewToFront(self)
        var direction: Direction = .Right
        switch swipeGestureRecognizer.direction.toRaw() {
        case 1:
            direction = .Right
        case 2:
            direction = .Left
        case 4:
            direction = .Up
        case 8:
            direction = .Down
        default: println("undefined")
        }
        
        execute(direction.toOperatorType())
    }
    
    func didPressButton() {
        expand()
    }
    
    func didReleaseButton() {
        dismiss()
    }
    
    func expand() {
        isActive = true
        
        let centerPoint = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2)
        let radius: Int = Int(self.frame.size.width * 0.8)
        
        for animationButton in animationButtons {
            animationButton.center = centerPoint
            self.addSubview(animationButton)
            
            let point = CGPoint(x: radius * Int(cosf(Float(M_PI_2) * Float(animationButton.type.toInt()))), y: radius * Int(sinf(Float(M_PI_2) * Float(animationButton.type.toInt()))))
            
            animationButton.alpha = 0.0
            animationButton.transform = CGAffineTransformMakeScale(0, 0)
            
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
                        animationButton.center = centerPoint
                        animationButton.transform = CGAffineTransformMakeScale(1.0, 1.0)
                        animationButton.alpha = 0.0
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
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect)
    {
        // Drawing code
    }
    */

}

protocol GameLevelSelectButtonDelegate: class {
    func gameLevelSelectButtonDidSwipe(direction: Direction)
}

class GameLevelSelectButton: CustomButton {
    
    var delegate: GameLevelSelectButtonDelegate?
    
    init(frame: CGRect, imageNamePrefix: String, delegate: GameLevelSelectButtonDelegate)  {
        self.delegate = delegate
        super.init(frame: frame, imageNamePrefix: imageNamePrefix)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didSwipe(swipeGestureRecognizer: UISwipeGestureRecognizer) {
        self.superview!.bringSubviewToFront(self)
        var direction: Direction = .Right
        switch swipeGestureRecognizer.direction.toRaw() {
        case 1:
            direction = .Right
        case 2:
            direction = .Left
        case 4:
            direction = .Up
        case 8:
            direction = .Down
        default: println("undefined")
        }
        
        delegate?.gameLevelSelectButtonDidSwipe(direction)
        execute(direction.toOperatorType())
    }
}
