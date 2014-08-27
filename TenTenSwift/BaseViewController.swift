//
//  BaseViewController.swift
//  TenTenSwift
//
//  Created by Ken Tominaga on 8/4/14.
//  Copyright (c) 2014 Tommy. All rights reserved.
//

import UIKit

let Origin = CGPointMake(55, 280)
let Margin: CGFloat = 140
let xMargin = CGPointMake(Margin, 0)
let yMargin = CGPointMake(0, Margin)

let FirstPoint = Origin
let SecondPoint = CGPointMake(Origin.add(xMargin).x, Origin.y)
let ThirdPoint = CGPointMake(Origin.x, Origin.add(yMargin).y)
let FourthPoint = CGPointMake(Origin.add(xMargin).x, Origin.add(yMargin).y)

let positionArray: [CGPoint] = [FirstPoint, SecondPoint, ThirdPoint, FourthPoint];

class BaseViewController: UIViewController {
    
    let gameManager: GameManager = GameManager.sharedManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.setHidesBackButton(true, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startNewGame(continueOrNot: Bool) {
        if !continueOrNot {
            gameManager.problemIndex = Int(arc4random_uniform(gameManager.problemsCount()))
        }
        
        refresh()
        display()
    }
    
    private func display() {
        for i in 0 ..< 4 {
            let imageView = CustomImageView(frame: CGRectMake(positionArray[i].x, positionArray[i].y, 70, 70), number: Fraction(numerator: gameManager.getNumbers()[i]), imageNamePrefix: "operator")
            
            imageView.alpha = 0.4
            imageView.transform = CGAffineTransformMakeScale(0.2, 0.2)
            imageView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI / 180 * -20))
            self.view.addSubview(imageView)
            
            UIView.animateWithDuration(0.8, animations: {
                imageView.alpha = 1.0
                imageView.transform = CGAffineTransformMakeScale(1.0, 1.0)
                imageView.transform = CGAffineTransformMakeRotation(0)
                }, completion: {
                    (value: Bool) in
                    
            })
        }
    }
    
    private func refresh() {
        for someView in self.view.subviews {
            if let customImageView = someView as? CustomImageView {
                customImageView.removeFromSuperview()
            }
        }
    }
    
    func getViewController(identifier: String) -> UIViewController {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil);
        let viewController = mainStoryboard.instantiateViewControllerWithIdentifier(identifier) as UIViewController
        return viewController
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
