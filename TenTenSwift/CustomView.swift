//
//  CustomView.swift
//  TenTenSwift
//
//  Created by Ken Tominaga on 8/21/14.
//  Copyright (c) 2014 Tommy. All rights reserved.
//

import UIKit

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
}

class CustomView: UIView {
    
    var customButton: CustomButton = CustomButton(point: CGPointMake(0, 0))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.userInteractionEnabled = true
        // self.backgroundColor = UIColor.brownColor()
        
        let directions: [UISwipeGestureRecognizerDirection] = [.Right, .Left, .Up, .Down]
        for direction in directions {
            let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("didSwipe:"))
            swipeGestureRecognizer.direction = direction
            self.addGestureRecognizer(swipeGestureRecognizer)
        }
        
        customButton.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2)
        self.addSubview(customButton)
    }
    
    convenience init(point: CGPoint) {
        let width = CGFloat(60) // 150
        let height = CGFloat(60)
        self.init(frame: CGRectMake(point.x, point.y, width, height))
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func didSwipe(swipeGestureRecognizer: UISwipeGestureRecognizer) {
        var direction: Direction = .Right
        switch swipeGestureRecognizer.direction.toRaw() {
        case 1:
            println("right")
            direction = .Right
        case 2:
            println("left")
            direction = .Left
        case 4:
            println("up")
            direction = .Up
        case 8:
            println("down")
            direction = .Down
        default: println("undefined")
        }
        
        customButton.execute(direction.toOperatorType())
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
