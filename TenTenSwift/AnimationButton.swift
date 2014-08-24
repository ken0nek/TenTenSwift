//
//  AnimationButton.swift
//  TenTenSwift
//
//  Created by Ken Tominaga on 8/20/14.
//  Copyright (c) 2014 Tommy. All rights reserved.
//

import UIKit

class AnimationButton: UIButton {
    
    var type: Int = 0

    init(frame: CGRect, type: Int) {
        super.init(frame: frame)
        self.type = type
        self.setBackgroundImage(UIImage(named: "command_icon_\(type)"), forState: UIControlState.Normal)
        self.addTarget(self, action: Selector("didPressAnimationButton"), forControlEvents: UIControlEvents.TouchUpInside)
        self.userInteractionEnabled = true
    }
    
    convenience init(point: CGPoint, type: Int) {
        let width: CGFloat = CGFloat(40)
        let height: CGFloat = CGFloat(40)
        self.init(frame: CGRectMake(point.x, point.y, width, height), type: type)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func didPressAnimationButton() {
        self.removeFromSuperview()
    }
    
    func initialize() -> AnimationButton {
        return AnimationButton(point: CGPointMake(0, 0), type: self.type)
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
