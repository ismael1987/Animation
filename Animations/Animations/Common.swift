//
//  Common.swift
//  Animations
//
//  Created by ismael alali on 27.12.19.
//  Copyright © 2019 ismael alali. All rights reserved.
//

import Foundation
import UIKit

let screenRect = UIScreen.main.bounds
let generalFrame = CGRect(x: 0, y: 0, width: screenRect.width / 2.0, height: screenRect.height / 4.0)
let generalCenter = CGPoint(x: screenRect.midX, y: screenRect.midY - 50)

func drawRectView(_ color: UIColor, frame: CGRect, center: CGPoint) -> UIView {
  let view = UIView(frame: frame)
  view.center = center
  view.backgroundColor = color
  return view
}

func drawCircleView() -> UIView {
    // here the x and y are the start position, radius the size of the ball
  let circlePath = UIBezierPath(arcCenter: CGPoint(x: 50,y: screenRect.midY - 50), radius: CGFloat(10), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
  
  let shapeLayer = CAShapeLayer()
  shapeLayer.path = circlePath.cgPath
  // the clolor inside the ball
  shapeLayer.fillColor = UIColor.blue.cgColor
  shapeLayer.strokeColor = UIColor.red.cgColor
    //the thick of line
  shapeLayer.lineWidth = 2.0
  
  let view = UIView()
  view.layer.addSublayer(shapeLayer)
  
  return view
}

func makeAlert(_ title: String, message: String, actionTitle: String) -> UIAlertController {
  let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
  alert.addAction(UIAlertAction(title: actionTitle, style: UIAlertAction.Style.default, handler: nil))
  
  return alert
}
