//
//  AnimationButton.swift
//  TenTenSwift
//
//  Created by Ken Tominaga on 8/20/14.
//  Copyright (c) 2014 Tommy. All rights reserved.
//

import UIKit

enum OperatorType {
    case Add, Subtract, Multiply, Divide
    func toInt() -> Int {
        switch self {
        case .Add: return 0
        case .Subtract: return 2
        case .Multiply: return 3
        case .Divide: return 1
        }
    }
}

class AnimationButton: UIButton {
    
    var type: OperatorType

    init(frame: CGRect, type: OperatorType) {
        self.type = type
        super.init(frame: frame)
        self.addTarget(self, action: Selector("didPressAnimationButton"), forControlEvents: UIControlEvents.TouchUpInside)
        self.userInteractionEnabled = false
    }
    
    convenience init(point: CGPoint, type: OperatorType) {
        let width = CGFloat(40)
        let height = CGFloat(40)
        self.init(frame: CGRectMake(point.x, point.y, width, height), type: type)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func didPressAnimationButton() {
        self.removeFromSuperview()
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
