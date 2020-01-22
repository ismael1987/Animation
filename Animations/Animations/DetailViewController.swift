//
//  DetailViewController.swift
//  Animations
//
//  Created by ismael alali on 27.12.19.
//  Copyright © 2019 ismael alali. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

  //Variables
  var barTitle = ""
  var animateView: UIView!
  fileprivate let duration = 2.0
  fileprivate let delay = 0.2
  fileprivate let scale = 1.2
  
  //Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupRect()
    setupNavigationBar()
  }
  //The fileprivate keyword took over the role of the private keyword and the latter became more restrictive, more importantly, very focused.
  fileprivate func setupNavigationBar() {
    navigationController?.navigationBar.topItem?.title = barTitle
  }
  
  fileprivate func setupRect() {
    if barTitle == "BezierCurve Position" {
      animateView = drawCircleView()
      
    } else if barTitle == "View Fade In" {
      animateView = UIImageView(image: UIImage(named: "whatsapp"))
      animateView.frame = generalFrame
      animateView.center = generalCenter
    } else {
      animateView = drawRectView(UIColor.red, frame: generalFrame, center: generalCenter)
    }
    view.addSubview(animateView)
  }
  
  //IBAction
  @IBAction func didTapAnimate(_ sender: AnyObject) {
    switch barTitle {
    case "2-Color":
      changeColor(UIColor.green)
      
    case "Simple 2D Rotation":
      rotateView(Double.pi)
      
    case "Multicolor":
      multiColor(UIColor.green, UIColor.blue)
      
    case "Multi Point Position":
      multiPosition(CGPoint(x: animateView.frame.origin.x, y: 100), CGPoint(x: animateView.frame.origin.x, y: 350))
      //multiPosition(CGPoint(x: 200 , y: 200), CGPoint(x: animateView.frame.origin.x, y: 300))
      
    case "BezierCurve Position":
      var controlPoint1 = self.animateView.center
      controlPoint1.y -= 125.0
      var controlPoint2 = controlPoint1
      controlPoint2.x += 40.0
      controlPoint2.y -= 125.0;
      var endPoint = self.animateView.center;
      endPoint.x += 75.0
      curvePath(endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
  
      
    case "Color and Frame Change":
      let currentFrame = self.animateView.frame
      let firstFrame = currentFrame.insetBy(dx: -30, dy: -50)
      let secondFrame = firstFrame.insetBy(dx: 10, dy: 15)
      let thirdFrame = secondFrame.insetBy(dx: -15, dy: -20)
      colorFrameChange(firstFrame, secondFrame, thirdFrame, UIColor.orange, UIColor.yellow, UIColor.green)
      
    case "View Fade In":
      viewFadeIn()
      
    case "Pop":
      Pop(UIColor.black)
      
    default:
      let alert = makeAlert("Alert", message: "The animation not implemented yet", actionTitle: "OK")
      self.present(alert, animated: true, completion: nil)
    }
  }
  
  // change color method
  fileprivate func changeColor(_ color: UIColor) {
    UIView.animate(withDuration: self.duration, animations: {
      self.animateView.backgroundColor = color
      }, completion: nil)
  }
  // change the color 2 time
  fileprivate func multiColor(_ firstColor: UIColor, _ secondColor: UIColor) {
    UIView.animate(withDuration: duration, animations: {
      self.animateView.backgroundColor = firstColor
      }, completion: { finished in
        self.changeColor(secondColor)
    })
  }
  
   // chang the shap position
  fileprivate func multiPosition(_ firstPos: CGPoint, _ secondPos: CGPoint) {
    func simplePosition(_ pos: CGPoint) {
      UIView.animate(withDuration: self.duration, animations: {
        self.animateView.frame.origin = pos
      }, completion: nil)
    }
    
    UIView.animate(withDuration: self.duration, animations: {
      self.animateView.frame.origin = firstPos
      }, completion: { finished in
        simplePosition(secondPos)
    })
  }
  
    // rotate method
  fileprivate func rotateView(_ angel: Double) {
    // if we add options: [.repeat], after delay so that will make a loop
    UIView.animate(withDuration: duration, delay: delay,  animations: {
      self.animateView.transform = CGAffineTransform(rotationAngle: CGFloat(angel))
      }, completion: nil)
  }
  //change the color and the size
  fileprivate func colorFrameChange(_ firstFrame: CGRect, _ secondFrame: CGRect, _ thirdFrame: CGRect,
                                _ firstColor: UIColor, _ secondColor: UIColor, _ thirdColor: UIColor) {
    UIView.animate(withDuration: self.duration, animations: {
      self.animateView.backgroundColor = firstColor
      self.animateView.frame = firstFrame
      }, completion: { finished in
        UIView.animate(withDuration: self.duration, animations: {
          self.animateView.backgroundColor = secondColor
          self.animateView.frame = secondFrame
          }, completion: { finished in
            UIView.animate(withDuration: self.duration, animations: {
              self.animateView.backgroundColor = thirdColor
              self.animateView.frame = thirdFrame
              }, completion: nil)
        })
    })
  }
  
  fileprivate func curvePath(_ endPoint: CGPoint, controlPoint1: CGPoint, controlPoint2: CGPoint) {
    let path = UIBezierPath()
    path.move(to: self.animateView.center)
    
    path.addCurve(to: endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)

    // create a new CAKeyframeAnimation that animates the objects position
    let anim = CAKeyframeAnimation(keyPath: "position")
    
    // set the animations path to our bezier curve
    anim.path = path.cgPath
    
    // set some more parameters for the animation
    anim.duration = self.duration
    
    // add the animation to the squares 'layer' property
    self.animateView.layer.add(anim, forKey: "animate position along path")
    self.animateView.center = endPoint
  }
  
  fileprivate func viewFadeIn() {
    let secondView = UIImageView(image: UIImage(named: "facebook"))
    secondView.frame = self.animateView.frame
    secondView.alpha = 0.0
    
    view.insertSubview(secondView, aboveSubview: self.animateView)
    
    UIView.animate(withDuration: duration, delay: delay, options: .curveEaseOut, animations: {
      secondView.alpha = 1.0
      self.animateView.alpha = 0.0
      }, completion: nil)
  }
  // change the size
  fileprivate func Pop(_ color: UIColor) {
    UIView.animate(withDuration: duration / 4,
      animations: {
       self.animateView.backgroundColor = color;
       self.animateView.transform = CGAffineTransform(scaleX: CGFloat(self.scale), y: CGFloat(self.scale))
      }, completion: { finished in
        UIView.animate(withDuration: self.duration / 5, animations: {
          self.animateView.transform = CGAffineTransform.identity
        })
    })
  }
}
