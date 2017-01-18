//
//  KaleidoView.swift
//  KaleidoView

//  Created by William Komer on 12/1/16.
//  Copyright © 2016 William Komer. All rights reserved.
//

import UIKit
import Darwin

class KaleidoView: UIView {
    //ability to turn off and on animation control
    var canToggleAnim:Bool = true;
    
    //is animating or not
    var isAnimating:Bool = true;
    
    // Speed
    var delay : NSTimeInterval = 0.5
    
    //size of the rectangles
    var rectSize:CGFloat = 1;
    
    // Must be retained for start and stop
    var timer : NSTimer? = nil
    
    // The retained layer
    var drawLayer : CGLayerRef? = nil
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        
        NSLog("init coder...");
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        NSLog("init frame...");
    }
    
    override func drawRect(rect: CGRect)
    {
        // Get the context being draw upon
        let context = UIGraphicsGetCurrentContext()
        
        if (drawLayer == nil)
        {
            // Create the layer if we don't have one
            let size = CGSizeMake(self.bounds.size.width, self.bounds.size.height)
            drawLayer = CGLayerCreateWithContext(context, size, nil)
        }
        
        // Draw to the layer
        self.drawRectangles();
        
        // Copy layer to context
        CGContextDrawLayerInRect (context, self.bounds, drawLayer);
    }
    
    func drawRectangles() {
        let screenSize: CGRect = UIScreen.mainScreen().bounds;
        
        // Get layer context
        let layerContext = CGLayerGetContext (drawLayer);
        
        //lets get a random color
        let red:CGFloat = CGFloat(arc4random_uniform(256)) / 256,
        green:CGFloat = CGFloat(arc4random_uniform(256)) / 256,
        blue:CGFloat = CGFloat(arc4random_uniform(256)) / 256;
        let color:UIColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0);
        
        //get random values for the offsets from the center
        let offsetWidth:CGFloat = CGFloat(arc4random_uniform(UInt32(screenSize.width / 2))),
        offsetHeight:CGFloat = CGFloat(arc4random_uniform(UInt32(screenSize.height / 2)));
        
        //get random values for the width and the height of the rectangle, lets make the max
        //values a quarter of the screen size
        let height:CGFloat = CGFloat(arc4random_uniform(UInt32(screenSize.height / 4))),
        width:CGFloat = CGFloat(arc4random_uniform(UInt32(screenSize.width / 4)));
        
        //get the center of the screen
        let xCenter = screenSize.width / 2, yCenter = screenSize.height / 2;
        
        //create the rectangle objects
        let upperLeftRect = CGRectMake(xCenter - offsetWidth, yCenter + offsetHeight, width * rectSize, height * rectSize),
        upperRightRect = CGRectMake(xCenter + offsetWidth, yCenter + offsetHeight, width * rectSize, height * rectSize),
        lowerLeftRect = CGRectMake(xCenter - offsetWidth, yCenter - offsetHeight, width * rectSize, height * rectSize),
        lowerRightRect = CGRectMake(xCenter + offsetWidth, yCenter - offsetHeight, width * rectSize, height * rectSize);
        
        //set up the generic settings for the rectangles
        CGContextSetFillColorWithColor(layerContext, color.CGColor);
        CGContextSetStrokeColorWithColor(layerContext, color.CGColor);
        
        //draw the rectangles
        CGContextFillRect(layerContext, upperLeftRect);
        CGContextFillRect(layerContext, upperRightRect);
        CGContextFillRect(layerContext, lowerLeftRect);
        CGContextFillRect(layerContext, lowerRightRect);
        
        CGContextAddRect(layerContext, upperLeftRect);
        CGContextAddRect(layerContext, upperRightRect);
        CGContextAddRect(layerContext, lowerLeftRect);
        CGContextAddRect(layerContext, lowerRightRect);
        
        CGContextStrokePath(layerContext);
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //only continue if the user is able to toggle animation
        if(!canToggleAnim) { return; }
        
        //start/stop drawing based on the current state, the state will be toggled in the function
        if(isAnimating) {
            stopDrawing();
        }
        else {
            startDrawing();
        }
    }
    
    func startDrawing() {
        //we are now animating
        isAnimating = true;
        
        // Set timer, Target/Action pattern used here
        timer = NSTimer(timeInterval: delay,
            target: self,
            selector: Selector("setNeedsDisplay"),
            userInfo: nil,
            repeats: true)
        
        // Get the runloop, add timer to runloop
        let runLoop = NSRunLoop.currentRunLoop()
        runLoop.addTimer(timer!, forMode: "NSDefaultRunLoopMode")
    }
    
    func stopDrawing() {
        //we are no longer animating
        isAnimating = false;
        
        // Clear timer
        if let timer2 = timer
        {
            timer2.invalidate()
        }
        self.timer = nil
    }
    
}
