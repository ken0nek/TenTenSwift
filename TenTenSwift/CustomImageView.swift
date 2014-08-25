//
//  CustomImageView.swift
//  TenTenSwift
//
//  Created by Ken Tominaga on 8/25/14.
//  Copyright (c) 2014 Tommy. All rights reserved.
//

import UIKit

class CustomImageView: UIImageView {

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var numeratorLabel: UILabel
    var denominatorLabel: UILabel?
    var number: Fraction
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
    
//    convenience init(point: CGPoint, number: Fraction) {
//        
//    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect)
    {
        // Drawing code
    }
    */

}
