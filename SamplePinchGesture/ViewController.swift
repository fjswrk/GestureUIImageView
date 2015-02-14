//
//  ViewController.swift
//  SamplePinchGesture
//
//  Created by sample on 2015/02/13.
//  Copyright (c) 2015年 sample. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let imageView = UIImageView(image: UIImage(named: "sample.jpg"))
    private var watchImageMode = false
    private var beforePoint = CGPointMake(0.0, 0.0)
    private var currentScale:CGFloat = 1.0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.blackColor()
        
        self.imageView.contentMode = .ScaleAspectFit
        self.imageView.frame = self.view.bounds
        self.imageView.userInteractionEnabled = true
        self.view.addSubview(self.imageView)
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: "handleGesture:")
        self.imageView.addGestureRecognizer(pinchGesture)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: "handleGesture:")
        self.imageView.addGestureRecognizer(tapGesture)
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: "handleGesture:")
        self.imageView.addGestureRecognizer(longPressGesture)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: "handleGesture:")
        self.imageView.addGestureRecognizer(panGesture)
    }
    
    func handleGesture(gesture: UIGestureRecognizer){
        if let tapGesture = gesture as? UITapGestureRecognizer{
            tap(tapGesture)
        }else if let pinchGesture = gesture as? UIPinchGestureRecognizer{
            pinch(pinchGesture)
        }else if let longPressGesture = gesture as? UILongPressGestureRecognizer{
            longPress(longPressGesture)
        }else if let panGesture = gesture as? UIPanGestureRecognizer{
            pan(panGesture)
        }
    }
    
    private func pan(gesture:UIPanGestureRecognizer){
        if self.watchImageMode{
            
            var translation = gesture.translationInView(self.view)
            
            if abs(self.beforePoint.x) > 0.0 || abs(self.beforePoint.y) > 0.0{
                translation = CGPointMake(self.beforePoint.x + translation.x, self.beforePoint.y + translation.y)
            }

            switch gesture.state{
            case .Changed:
                let scaleTransform = CGAffineTransformMakeScale(self.currentScale, self.currentScale)
                let translationTransform = CGAffineTransformMakeTranslation(translation.x, translation.y)
                self.imageView.transform = CGAffineTransformConcat(scaleTransform, translationTransform)
            case .Ended , .Cancelled:
                self.beforePoint = translation
            default:
                NSLog("no action")
            }
        }
    }
    
    private func longPress(gesture:UILongPressGestureRecognizer){
        
        if gesture.state == .Began{
            
            self.watchImageMode = !self.watchImageMode
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                
                if self.watchImageMode{
                    self.currentScale = 1.0
                    self.view.backgroundColor = UIColor.orangeColor()
                }else{
                    self.view.backgroundColor = UIColor.blackColor()
                }
                self.imageView.transform = CGAffineTransformIdentity
            })
        }
    }
    
    private func tap(gesture:UITapGestureRecognizer){
        if self.watchImageMode{
            self.watchImageMode = false
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.view.backgroundColor = UIColor.blackColor()
                self.beforePoint = CGPointMake(0.0, 0.0)
                self.imageView.transform = CGAffineTransformIdentity
            })
        }
    }
    
    private func pinch(gesture:UIPinchGestureRecognizer){
        
        if self.watchImageMode{
        
            var scale = gesture.scale
            if self.currentScale > 1.0{
                scale = self.currentScale + (scale - 1.0)
            }
            switch gesture.state{
            case .Changed:
                let scaleTransform = CGAffineTransformMakeScale(scale, scale)
                let transitionTransform = CGAffineTransformMakeTranslation(self.beforePoint.x, self.beforePoint.y)
                self.imageView.transform = CGAffineTransformConcat(scaleTransform, transitionTransform)
            case .Ended , .Cancelled:
                if scale <= 1.0{
                    self.currentScale = 1.0
                    self.imageView.transform = CGAffineTransformIdentity
                }else{
                    self.currentScale = scale
                }
            default:
                NSLog("not action")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

