//
//  SmallFretboard.swift
//  Chordie
//
//  Created by Budhathoki,Bipin on 10/29/15.
//  Copyright © 2015 Bipin Budhathoki. All rights reserved.
//

import UIKit

@IBDesignable class SmallFretboard: Fretboard {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.userInteractionEnabled = false
        self.stackView.spacing = 5;
        
        setEqualStringHeight(1)
        
        fretBoardLayoutButtonMargin.constant = 0
        fretBoardLayoutTopMargin.constant = 0
        
        updateStringColor(UIColor.blackColor())
        
    }
    
    private func setEqualStringHeight(height: CGFloat) {
        EStringHeightConstraint.constant = height;
        AStringHeightConstraint.constant = height;
        DStringHeightConstraint.constant = height;
        GStringHeightConstraint.constant = height;
        BStringHeightConstraint.constant = height;
        ESmallStringHeightConstraint.constant = height;
    }
    
    private func updateStringColor(color: UIColor) {
        EString.backgroundColor = color
        AString.backgroundColor = color
        DString.backgroundColor = color
        GString.backgroundColor = color
        BString.backgroundColor = color
        ESmallString.backgroundColor = color
    }
    
    private func getNewStringFrame(rect: CGRect, height: CGFloat) -> CGRect{
        print(CGRectMake(rect.origin.x, rect.origin.y, rect.width, height))
        return CGRectMake(rect.origin.x, rect.origin.y, rect.width, height)
    }
    
    override func getBorderColor() -> UIColor {
        return UIColor.blackColor()
    }
}
