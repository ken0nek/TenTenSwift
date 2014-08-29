//
//  ResultViewController.swift
//  TenTenSwift
//
//  Created by Ken Tominaga on 8/29/14.
//  Copyright (c) 2014 Tommy. All rights reserved.
//

import UIKit

enum Valuation {
    case A, B, C, D
    
    func toInt() -> Int {
        switch self {
            case .A: return 0
            case .B: return 1
            case .C: return 2
            case .D: return 3
        }
    }
}

class ResultViewController: BaseViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var resultImageView: UIImageView!
    var valuation: Valuation {
        get {
            return valuationFromTime()
        }
    }
    var answerString: String = ""
    var time: Int = -1
    
    class func viewController(answerString: String, time: Int) -> ResultViewController {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil);
        let rVC = mainStoryboard.instantiateViewControllerWithIdentifier("Result") as ResultViewController
        rVC.answerString = answerString
        rVC.time = time
        return rVC
    }
    
    override func viewDidLoad() {
        timeLabel.text = "\(time)"
        answerLabel.text = answerString
        messageLabel.text = messageFromValuation()
        resultImageView.image = UIImage(named: imageNameFromValuation())
    }
    
    private func messageFromValuation() -> String {
        switch valuation {
            case .A: return "Great !"
            case .B: return "Good !"
            case .C: return "Bad :("
            case .D: return "You got D"
        }
    }
    
    private func valuationFromTime() -> Valuation {
        switch time {
        case -1: return .D
        case 0 ..< 10: return .A
        case 10 ..< 20: return .B
        default: return .C
        }
    }
    
    private func imageNameFromValuation() -> String {
        return CommandIconPrefixString + "\(valuation.toInt())"
    }
}
