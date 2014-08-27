//
//  CustomLabel.swift
//  TenTenSwift
//
//  Created by Ken Tominaga on 8/25/14.
//  Copyright (c) 2014 Tommy. All rights reserved.
//

import UIKit

class CustomLabel: UILabel {
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.adjustsFontSizeToFitWidth = true
        self.font = UIFont.boldSystemFontOfSize(self.frame.size.height / 1.5)
        self.textColor = UIColor.blackColor()
        self.textAlignment = NSTextAlignment.Center
    }
    
    convenience init(point: CGPoint) {
        let width = CGFloat(30)
        let height = CGFloat(30)
        self.init(frame: CGRectMake(point.x, point.y, width, height))
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
