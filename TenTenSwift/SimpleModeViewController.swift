//
//  SimpleModeViewController.swift
//  TenTenSwift
//
//  Created by Ken Tominaga on 8/27/14.
//  Copyright (c) 2014 Tommy. All rights reserved.
//

import UIKit

class SimpleModeViewController: BaseViewController {

    @IBOutlet weak var timeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setReplayButton()
        setGiveupButton()
        self.title = "Simple"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        showProblemWithRepeat(false)
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
