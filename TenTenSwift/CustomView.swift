//
//  CustomView.swift
//  TenTenSwift
//
//  Created by Ken Tominaga on 8/21/14.
//  Copyright (c) 2014 Tommy. All rights reserved.
//

import UIKit

class CustomView: UIView {
    
    var customButton: CustomButton = CustomButton(frame: CGRectMake(0, 0, 0, 0))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.userInteractionEnabled = true
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: Selector("dragView:"))
        self.addGestureRecognizer(panGestureRecognizer)
        
        customButton =  CustomButton(frame: CGRectMake(0, 0, 60, 60))
        customButton.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2)
        self.addSubview(customButton)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func dragView(panGestureRecognizer: UIPanGestureRecognizer) {
        let movingView = panGestureRecognizer.view
        
        let point1 = panGestureRecognizer.view.center
        let point2 = panGestureRecognizer.translationInView(panGestureRecognizer.view)
        let targetPoint = point1.addPoint(point2)
        
        movingView.center = targetPoint
        
        panGestureRecognizer.setTranslation(CGPointMake(0, 0), inView: movingView)
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
