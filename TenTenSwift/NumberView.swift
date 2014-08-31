//
//  NumberView.swift
//  TenTenSwift
//
//  Created by Ken Tominaga on 8/31/14.
//  Copyright (c) 2014 Tommy. All rights reserved.
//

import UIKit

let NumberImagePrefix: String = "number"

extension Int {
    func numberAtIndex(index: Int) -> Int {
        return String(Array("\(self)")[index]).toInt()!
    }

    func digits() -> Int {
        var number = self
        var digits = 0
        while number > 0 {
            digits++
            number /= 10
        }
        return digits
    }
}

class NumberView: UIView {

    let number: Int
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame: CGRect, number: Int) {
        self.number = number
        super.init(frame: frame)

        var aNumber = self.number
        let digits = aNumber.digits()
        let width = self.frame.size.width / CGFloat(digits)
        let height = self.frame.size.height
        for i in 0 ..< digits {
            let imageView = UIImageView(frame: CGRectMake(width * CGFloat(i), 0, width, height))
            imageView.contentMode = UIViewContentMode.ScaleAspectFit
            imageView.image = UIImage(named: NumberImagePrefix + "\(aNumber.numberAtIndex(i))")
            self.addSubview(imageView)
        }
    }
    
    convenience init(point: CGPoint, number: Int) {
        let width = CGFloat(30)
        let height = CGFloat(30)
        self.init(frame: CGRectMake(point.x, point.y, width, height), number: number)
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
