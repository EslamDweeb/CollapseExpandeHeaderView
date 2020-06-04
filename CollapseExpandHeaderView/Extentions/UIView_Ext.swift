//
//  UIView_Ext.swift
//  CollapseExpandHeaderView_ED
//
//  Created by eslam dweeb on 6/4/20.
//  Copyright © 2020 eslam dweeb. All rights reserved.
//

import UIKit

 extension UIView{
     func bindToKeyboard(){
         NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
     }
     
     @objc func keyboardWillChange(_ notifcation: NSNotification){
         
         let duration = notifcation.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
         let curve = notifcation.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
         let beginningFrame = (notifcation.userInfo![UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
         let endFrame = (notifcation.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
         let deltaY = endFrame.origin.y - beginningFrame.origin.y
         UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIView.KeyframeAnimationOptions(rawValue: curve), animations: {
             
             self.frame.origin.y += deltaY
         }, completion: nil)
     }
     
     func pathCurvedForView(givenView: UIView, curvedPercent:CGFloat) ->UIBezierPath
      {
          let arrowPath = UIBezierPath()
          arrowPath.move(to: CGPoint(x:0, y:0))
          arrowPath.addLine(to: CGPoint(x:givenView.bounds.size.width, y:0))
          arrowPath.addLine(to: CGPoint(x:givenView.bounds.size.width, y:givenView.bounds.size.height - (givenView.bounds.size.height*curvedPercent)))
          arrowPath.addQuadCurve(to: CGPoint(x:0, y:givenView.bounds.size.height - (givenView.bounds.size.height*curvedPercent)), controlPoint: CGPoint(x:givenView.bounds.size.width/2, y:givenView.bounds.size.height))
          arrowPath.addLine(to: CGPoint(x:0, y:0))
          arrowPath.close()

          return arrowPath
      }
     
     func applyCurvedPath(givenView: UIView,curvedPercent:CGFloat) {
         guard curvedPercent <= 1 && curvedPercent >= 0 else{
             return
         }

         let shapeLayer = CAShapeLayer(layer: givenView.layer)
         shapeLayer.path = self.pathCurvedForView(givenView: givenView,curvedPercent: curvedPercent).cgPath
         shapeLayer.frame = givenView.bounds
         shapeLayer.masksToBounds = true
         givenView.layer.mask = shapeLayer
     }
     
     static func getIdentifier () -> String  {
         return String(describing: self )
     }
     func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
         let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
         let mask = CAShapeLayer()
         mask.path = path.cgPath
         self.layer.mask = mask
     }
     @discardableResult
     func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) -> AnchoredConstraints {
         
         translatesAutoresizingMaskIntoConstraints = false
         var anchoredConstraints = AnchoredConstraints()
         
         if let top = top {
             anchoredConstraints.top = topAnchor.constraint(equalTo: top, constant: padding.top)
         }
         
         if let leading = leading {
             anchoredConstraints.leading = leadingAnchor.constraint(equalTo: leading, constant: padding.left)
         }
         
         if let bottom = bottom {
             anchoredConstraints.bottom = bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom)
         }
         
         if let trailing = trailing {
             anchoredConstraints.trailing = trailingAnchor.constraint(equalTo: trailing, constant: -padding.right)
         }
         
         if size.width != 0 {
             anchoredConstraints.width = widthAnchor.constraint(equalToConstant: size.width)
         }
         
         if size.height != 0 {
             anchoredConstraints.height = heightAnchor.constraint(equalToConstant: size.height)
         }
         
         [anchoredConstraints.top, anchoredConstraints.leading, anchoredConstraints.bottom, anchoredConstraints.trailing, anchoredConstraints.width, anchoredConstraints.height].forEach{ $0?.isActive = true }
         
         return anchoredConstraints
     }
     
     func fillSuperview(padding: UIEdgeInsets = .zero) {
         translatesAutoresizingMaskIntoConstraints = false
         if let superviewTopAnchor = superview?.topAnchor {
             topAnchor.constraint(equalTo: superviewTopAnchor, constant: padding.top).isActive = true
         }
         
         if let superviewBottomAnchor = superview?.bottomAnchor {
             bottomAnchor.constraint(equalTo: superviewBottomAnchor, constant: -padding.bottom).isActive = true
         }
         
         if let superviewLeadingAnchor = superview?.leadingAnchor {
             leadingAnchor.constraint(equalTo: superviewLeadingAnchor, constant: padding.left).isActive = true
         }
         
         if let superviewTrailingAnchor = superview?.trailingAnchor {
             trailingAnchor.constraint(equalTo: superviewTrailingAnchor, constant: -padding.right).isActive = true
         }
     }
     
     func centerInSuperview(size: CGSize = .zero) {
         translatesAutoresizingMaskIntoConstraints = false
         if let superviewCenterXAnchor = superview?.centerXAnchor {
             centerXAnchor.constraint(equalTo: superviewCenterXAnchor).isActive = true
         }
         
         if let superviewCenterYAnchor = superview?.centerYAnchor {
             centerYAnchor.constraint(equalTo: superviewCenterYAnchor).isActive = true
         }
         
         if size.width != 0 {
             widthAnchor.constraint(equalToConstant: size.width).isActive = true
         }
         
         if size.height != 0 {
             heightAnchor.constraint(equalToConstant: size.height).isActive = true
         }
     }
     
     func centerXInSuperview() {
         translatesAutoresizingMaskIntoConstraints = false
         if let superViewCenterXAnchor = superview?.centerXAnchor {
             centerXAnchor.constraint(equalTo: superViewCenterXAnchor).isActive = true
         }
     }
     
     func centerYInSuperview() {
         translatesAutoresizingMaskIntoConstraints = false
         if let centerY = superview?.centerYAnchor {
             centerYAnchor.constraint(equalTo: centerY).isActive = true
         }
     }
     
     func constrainWidth(constant: CGFloat) {
         translatesAutoresizingMaskIntoConstraints = false
         widthAnchor.constraint(equalToConstant: constant).isActive = true
     }
     
     func constrainHeight(constant: CGFloat) {
         translatesAutoresizingMaskIntoConstraints = false
         heightAnchor.constraint(equalToConstant: constant).isActive = true
     }
     func returnTitleSize(title:String,font:UIFont) -> CGSize{
         let text = title
         let font = font
         let attributeFont = [NSAttributedString.Key.font: font]
         let size = (text as NSString ).size(withAttributes: attributeFont)
         
         return CGSize(width: size.width, height: size.height)
     }
     func setShadow(shadowColor: CGColor,shadowOffset: CGSize,shadowOpacity: Float,shadowRaduis: CGFloat) {
         layer.shadowRadius = shadowRaduis
         layer.shadowColor = shadowColor
         layer.shadowOffset = shadowOffset
         layer.shadowOpacity = shadowOpacity
         layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: shadowRaduis).cgPath
     }
 }

 struct AnchoredConstraints {
     var top, leading, bottom, trailing, width, height: NSLayoutConstraint?
 }

