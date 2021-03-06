//
//  TimeAttackModeViewController.swift
//  TenTenSwift
//
//  Created by Ken Tominaga on 8/27/14.
//  Copyright (c) 2014 Tommy. All rights reserved.
//

import UIKit

let MaxIndex: Int = 5

class TimeAttackModeViewController: BaseViewController {

    private var currentIndex: Int = 1
    
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setReplayButton()
        setGiveupButton()
        self.title = "Time Attack"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        showProblemWithRepeat(false)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        currentIndex = 1
        indexLabel.text = "\(currentIndex) / \(MaxIndex)"
    }
    
    override func gameWillClear(customImageView: CustomImageView) {
        super.gameWillClear(customImageView)
        
        if currentIndex == MaxIndex {
            finishTimeAttack()
        } else {
            currentIndex++
            indexLabel.text = "\(currentIndex) / \(MaxIndex)"
        }
    }
    
    override func update() {
        super.update()
        timeLabel.text = timeDescription()
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
