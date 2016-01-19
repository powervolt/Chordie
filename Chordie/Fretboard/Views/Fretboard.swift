//
//  Fretboard.swift
//  Chordie
//
//  Created by Budhathoki,Bipin on 10/22/15.
//  Copyright © 2015 Bipin Budhathoki. All rights reserved.
//

import UIKit

@IBDesignable class Fretboard: UIView, UIGestureRecognizerDelegate {
    
    var view: UIView!
    
    @IBOutlet weak var nut: UIView!
    @IBOutlet weak var fretNumber: UIView!
    
    @IBOutlet weak var EString: GuitarString!
    @IBOutlet weak var AString: GuitarString!
    @IBOutlet weak var DString: GuitarString!
    @IBOutlet weak var GString: GuitarString!
    @IBOutlet weak var BString: GuitarString!
    @IBOutlet weak var ESmallString: GuitarString!
    
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var fretBoardLayoutButtonMargin: NSLayoutConstraint!
    @IBOutlet weak var fretBoardLayoutTopMargin: NSLayoutConstraint!
    
    @IBOutlet weak var EStringHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var AStringHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var DStringHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var GStringHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var BStringHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var ESmallStringHeightConstraint: NSLayoutConstraint!

    
    let numberOfBars = 4
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) { // for using CustomView in IB
        super.init(coder: aDecoder)
        setUp()
    }
    
    private func setUp() {
        view = loadViewFormNib()
        view.frame = bounds
        view.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
        view.autoresizesSubviews = true
        self.contentMode = UIViewContentMode.Redraw
        addSubview(view)
    }
    
    func loadViewFormNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "Fretboard", bundle: bundle)
        let view: UIView = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        return view;
    }
    
    override func drawRect(rect: CGRect) {
        var arrayOfX = [CGFloat]()
        let fretSpacing = (rect.width - nut.frame.width)/CGFloat(numberOfBars)
        let context = UIGraphicsGetCurrentContext()
        
        for view in fretNumber.subviews {
            view.removeFromSuperview()
        }
        
        //line to sepearte frame from fretNumber
        CGContextMoveToPoint(context, 0, nut.frame.origin.y)
        CGContextAddLineToPoint(context, rect.width ,nut.frame.origin.y)
        CGContextSetLineWidth(context, 1)
        CGContextSetStrokeColorWithColor(context, getBorderColor().CGColor)
        CGContextStrokePath(context)
        
        //bottom border line
        CGContextMoveToPoint(context, 0, nut.frame.origin.y + nut.frame.height)
        CGContextAddLineToPoint(context, rect.width ,nut.frame.origin.y + nut.frame.height)
        CGContextSetLineWidth(context, 1)
        CGContextSetStrokeColorWithColor(context, UIColor.blackColor().CGColor)
        CGContextStrokePath(context)
        
        var fromX = fretSpacing + nut.frame.width
    
        for index in (1...numberOfBars) {
            arrayOfX.append(fromX)
            CGContextMoveToPoint(context, fromX, nut.frame.origin.y)
            CGContextAddLineToPoint(context,fromX ,rect.height)
            CGContextSetLineWidth(context, 1)
            CGContextSetStrokeColorWithColor(context, getBorderColor().CGColor)
            CGContextStrokePath(context)
            fromX += fretSpacing
            
            //index here == starting fret
            if (index % 3 == 0 || index % 5 == 0) {
                let y = stackView.frame.origin.y + (stackView.frame.height)/2
                let x = arrayOfX[index - 2] + fretSpacing/2
                let circleRect = CGRectMake(x - stackView.spacing/2, y - stackView.spacing/2, stackView.spacing, stackView.spacing)
                CGContextSetFillColorWithColor(context, getBorderColor().CGColor)
                CGContextAddEllipseInRect(context, circleRect)
                CGContextFillEllipseInRect(context, circleRect)
            }
            
            let fretNumberHeight = fretNumber.frame.height
            
            let button = UIButton(frame: CGRectMake(arrayOfX[index-1] - fretSpacing + fretNumberHeight/2, 0, fretNumber.frame.height,fretNumber.frame.height))
            button.setTitle(String(index), forState: .Normal)
            button.layer.cornerRadius = button.bounds.width/2
            ///button.titleLabel?.textColor = UIColor.blackColor()
           // button.backgroundColor = UIColor.blackColor()
            //button.backgroundColor = UIColor.blueColor()
            button.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
            //button.layer.borderWidth = 1;
            fretNumber.addSubview(button);
            
            let centerYConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: fretNumber, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0.0)
            fretNumber.addConstraint(centerYConstraint);
        }
    }
    
    func getBorderColor() -> UIColor {
        return UIColor.grayColor()
    }
    
    override func awakeFromNib() {
        //self.layer.borderWidth = 1
        //self.layer.cornerRadius = 2
        
        let panRestureRecognizer = UIPanGestureRecognizer(target: self, action: Selector("swiped:"))
        panRestureRecognizer.delegate = self
        
        self.view.addGestureRecognizer(panRestureRecognizer)
    }
    
    //MARK: UIResponder methods
    override func touchesBegan(touches: Set<UITouch>,
        withEvent event: UIEvent?){
            
    }
    
    
    //MARK: UISwipeGestureRecognizer action
    func swiped(gestureRecognizer: UIPanGestureRecognizer) {
        let point = gestureRecognizer.locationInView(self)
        
        if (abs(point.y - EString.frame.origin.y) < 35){
            EString.vibrateString(direction: gestureRecognizer)
        } else if (abs(point.y - AString.frame.origin.y) < 10) {
            AString.vibrateString(direction: gestureRecognizer)
        } else if (abs(point.y - DString.frame.origin.y) < 10) {
            DString.vibrateString(direction: gestureRecognizer)
        } else if (abs(point.y - GString.frame.origin.y) < 10) {
            GString.vibrateString(direction: gestureRecognizer)
        } else if (abs(point.y - BString.frame.origin.y) < 10) {
            BString.vibrateString(direction: gestureRecognizer)
        } else if (abs(point.y - ESmallString.frame.origin.y) < 10) {
            ESmallString.vibrateString(direction: gestureRecognizer)
        }
    }
    
    //MARK: UIGestureRecognizerDelegate
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer,
        shouldReceiveTouch touch: UITouch) -> Bool {
            return true;
    }
    
    //draws the chord on the fretboard
//    func drawChord(chord: Chord) {
//        
//    }
}
    