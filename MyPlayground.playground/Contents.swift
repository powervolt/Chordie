//: Playground - noun: a place where people can play

import UIKit

class FretBoard : UIView {
    let numberOfBars = 4
    var arrayOfY = [CGFloat]()
    var spacing: CGFloat = 0
    override func drawRect(rect: CGRect) {
        
        spacing = (rect.height - 10)/CGFloat(numberOfBars) //10 is the nut
        
        let context = UIGraphicsGetCurrentContext()
        var fromY = spacing + 10
        for index in (1...numberOfBars) {
            arrayOfY.append(fromY)
            CGContextMoveToPoint(context, 50, fromY)
            CGContextAddLineToPoint(context,150 ,fromY)
            CGContextSetLineWidth(context, 1)
            CGContextSetStrokeColorWithColor(context, UIColor.blackColor().CGColor)
            CGContextStrokePath(context)
            fromY += spacing
            
            //index here == starting fret
            if (index % 3 == 0 || index % 5 == 0) {
                let circleRect = CGRectMake((rect.width + 50)/2 - 5, arrayOfY[index - 2] + spacing/2 - 5 , 10, 10)
                CGContextAddEllipseInRect(context, circleRect)
               //CGContextStrokePath(context)
                CGContextFillEllipseInRect(context, circleRect)
              
            }
        }
    }
}

let width :CGFloat = 100
let height:CGFloat = 100
let mainView = FretBoard(frame: CGRectMake(0,0, width + 50, height))
let view = UIView(frame: CGRectMake(50, 0, width, height))
view.layer.cornerRadius = 4
view.layer.borderWidth = 1
mainView.addSubview(view)

let nut = UIView(frame: CGRectMake(0, 0, width, 10))
nut.backgroundColor=UIColor.blackColor()
view.addSubview(nut)

//make lines for




//calucate the string 

let numberOfString = 6
let padding = 5 as CGFloat

var stringArray : [UIView] = [UIView]()
let stringSpace = (width)/7
var currentX = stringSpace

for index in (1...numberOfString).reverse(){
    let stringView = UIView(frame: CGRectMake(currentX,0,1 + CGFloat(index)/3,height))
    stringView.backgroundColor = UIColor.brownColor();
    view.addSubview(stringView)
    stringArray.append(view);
    
    currentX += stringSpace
}

//add buttons on the side
for index in 0...mainView.arrayOfY.count-1 {
   var button = UIButton(frame: CGRectMake(20,mainView.arrayOfY[index] - mainView.spacing, 20, 20))
    button.setTitle(String(index+1), forState: .Normal)
    button.layer.cornerRadius = button.bounds.width/2
    //button.backgroundColor = UIColor.blueColor()
    button.layer.borderWidth = 1;
    mainView.addSubview(button);
}

mainView.backgroundColor=UIColor.grayColor()












