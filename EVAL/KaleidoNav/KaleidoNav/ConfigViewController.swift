//
//  ConfigViewController.swift
//  KaleidoTab
//
//  Created by William Komer on 12/1/16.
//  Copyright © 2016 William Komer. All rights reserved.
//

import UIKit

class ConfigViewController: UIViewController {
    @IBOutlet weak var toggleAnimSwitch: UISwitch!
    @IBOutlet weak var rectSizeSlider: UISlider!
    @IBOutlet weak var delayTime: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    
    var kaleidoVC   : KaleidoViewController?
    var kaleidoView : KaleidoView?
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        //setup the stepper configs
        stepper.wraps = true;
        stepper.autorepeat = true;
        stepper.maximumValue = 10;
        stepper.minimumValue = 1;
        
        // Get a reference to the KaleidoView's View Controller
        let controllerArray = navigationController?.viewControllers;
        let viewController0 = controllerArray?[0];
        kaleidoVC = viewController0 as? KaleidoViewController;
        
        // Get a reference to the KaleidoView's View Controller's view
        kaleidoView = kaleidoVC?.view as? KaleidoView;
        
        //set the values of the config items
        resetConfigVals();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveChangeButton(sender: AnyObject) {
        //save all values to the KaleidoView object
        kaleidoView?.canToggleAnim = toggleAnimSwitch.on;
        kaleidoView?.rectSize = CGFloat(rectSizeSlider.value);
        kaleidoView?.delay = NSTimeInterval(delayTime.text!)!;
    }
    
    @IBAction func cancelChangeButton(sender: AnyObject) {
        resetConfigVals();
    }
    
    @IBAction func delayStepper(sender: AnyObject) {
        //show the value of the stepper text
        delayTime.text = String(stepper.value / 10.0);
    }
    
    func resetConfigVals() {
        //set all of the config values to the ones that are currently set
        toggleAnimSwitch.setOn((kaleidoView?.canToggleAnim)!, animated: true);
        rectSizeSlider.setValue(Float((kaleidoView?.rectSize)!), animated: true);
        delayTime.text = String((kaleidoView?.delay)!);
        stepper.value = Double((kaleidoView?.delay)!) * 10.0;
    }
}
