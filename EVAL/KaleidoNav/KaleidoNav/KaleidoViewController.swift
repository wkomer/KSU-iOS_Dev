//
//  ViewController.swift
//  KaleidoTab
//
//  Created by William Komer on 12/1/16 .
//  Copyright © 2016 William Komer. All rights reserved.
//

import UIKit

class KaleidoViewController: UIViewController {

    var configViewController   : ConfigViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        let topView = self.view as! KaleidoView;
        topView.startDrawing();
    }
    
    override func viewDidDisappear(animated: Bool) {
        let topView = self.view as! KaleidoView;
        topView.stopDrawing();
    }
    
}