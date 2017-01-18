//
//  ViewController.swift
//  KaleidoView
//
//  Created by William Komer on 10/23/16.
//  Copyright © 2016 wkomer. All rights reserved.
//

import UIKit

class kaleidoController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        let topView = self.view as! kaleidoDrawView;
        topView.startDrawing()
    }
    
    override func viewDidDisappear(animated: Bool) {
        print("stop called")
        let topView = self.view as! kaleidoDrawView;
        topView.stopDrawing()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

