//
//  ResultViewController.swift
//  TenTenSwift
//
//  Created by Ken Tominaga on 8/29/14.
//  Copyright (c) 2014 Tommy. All rights reserved.
//

import UIKit

class ResultViewController: BaseViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var resultImageView: UIImageView!
    var valuation: Int = 0
    var answerString: String = ""
    var time: Int = 0
    
    class func viewController(answerString: String, time: Int, valuation: Int) -> ResultViewController {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil);
        let rVC = mainStoryboard.instantiateViewControllerWithIdentifier("Result") as ResultViewController
        rVC.valuation = valuation
        rVC.answerString = answerString
        rVC.time = time
        return rVC
    }
    
    override func viewDidLoad() {
        timeLabel.text = "\(time)"
        answerLabel.text = "\(answerString)"
        messageLabel.text = "message"
        resultImageView.image = UIImage(named: "")
    }
}
