//
//  GuitarString.swift
//  Chordie
//
//  Created by Budhathoki,Bipin on 10/24/15.
//  Copyright © 2015 Bipin Budhathoki. All rights reserved.
//

import UIKit

class GuitarString: UIView, UIGestureRecognizerDelegate {
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 2
        
        self.layer.shadowOffset = CGSizeMake(-2, 5)
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.5
        
        let tapGesture = UITapGestureRecognizer(target: self, action: Selector("stringTapped:"))
        self.addGestureRecognizer(tapGesture)
        
        self.backgroundColor = UIColor.brownColor()
    }
    
    func stringTapped(gestureRecognizer: UITapGestureRecognizer) {
        vibrateString(direction: nil)
    }
    
    func vibrateString(direction direction: UIPanGestureRecognizer?) {
        let f: CGFloat = 2.0
        let leftTransform = CGAffineTransformTranslate(CGAffineTransformIdentity,0,f);
        let rightTransform = CGAffineTransformTranslate(CGAffineTransformIdentity,0, -f);
        
        self.layer.removeAllAnimations()
        
        self.transform = leftTransform;
        
        UIView.beginAnimations("GUITAR_STRING_ANIMATION", context: nil)
        UIView.setAnimationRepeatAutoreverses(true)
        UIView.setAnimationDuration(0.03)
        UIView.setAnimationDelegate(self)
        UIView.setAnimationRepeatCount(7)
        self.transform = rightTransform;
        UIView.commitAnimations()
    }
}
    
   