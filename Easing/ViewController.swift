//
//  ViewController.swift
//  Easing
//
//  Created by Ellen Shapiro on 10/26/14.
//  Copyright (c) 2014 Designated Nerd Software. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var easeInView : UIView?
    @IBOutlet var easeOutView : UIView?
    @IBOutlet var easeInOutView : UIView?
    @IBOutlet var linearView : UIView?
    @IBOutlet var goButton : UIButton?
    @IBOutlet var resetButton : UIButton?
    var targetMove : CGFloat = 0.0
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: View Lifecycle
    
    override func viewDidLoad() {
        self.resetButton?.enabled = false;
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let reallyAView = easeInView {
            let fullViewWidth = CGRectGetWidth(self.view.frame)
            targetMove = fullViewWidth - CGRectGetMinX(reallyAView.frame) - CGRectGetWidth(reallyAView.frame) - 20.0
        }
    }
    
    //MARK: Animations
    
    @IBAction func fireAnimations() {
        fireAnimations(4.0, reverse: false)
    }
    
    func fireAnimations(duration : NSTimeInterval, reverse : Bool) {
        fireAnimationForView(easeInView, easing: .CurveEaseIn, duration: duration, reverse: reverse)
        fireAnimationForView(easeOutView, easing: .CurveEaseOut, duration: duration, reverse: reverse)
        fireAnimationForView(easeInOutView, easing: .CurveEaseInOut, duration: duration, reverse: reverse)
        fireAnimationForView(linearView, easing: .CurveLinear, duration: duration, reverse: reverse)
    }
    
    func fireAnimationForView(view : UIView?, easing : UIViewAnimationOptions, duration : NSTimeInterval, reverse : Bool ) {
        if let reallyAView = view {
            var move = self.targetMove
            if reverse {
                move *= -1
            }
            UIView.animateWithDuration(duration,
                delay: 0,
                options: easing,
                animations: { () -> Void in
                    reallyAView.frame = CGRectOffset(reallyAView.frame, move, 0);
                }) { (Bool) -> Void in
                    if reverse {
                        self.goButton?.enabled = true;
                        self.resetButton?.enabled = false;
                    } else {
                        self.resetButton?.enabled = true;
                        self.goButton?.enabled = false;
                    }
            }
        }
    }
    
    @IBAction func reset() {
        fireAnimations(0.0, reverse: true)
    }
}

