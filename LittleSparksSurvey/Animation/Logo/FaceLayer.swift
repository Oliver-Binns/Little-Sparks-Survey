//
//  FaceLayer.swift
//  LittleSparksSurvey
//
//  Created by Oliver Binns on 13/05/2018.
//  Copyright © 2018 Oliver Binns. All rights reserved.
//

import UIKit

class FaceLayer: CAShapeLayer {
	static let originalHeight: CGFloat = 52.167
	static let originalWidth: CGFloat = 103.071
	
	init(_ animated: Bool, frame: CGRect){
		super.init()
		
		let sizeAdjust = frame.width / FaceLayer.originalWidth
		let lineWidth = 2 * sizeAdjust
		
		self.frame = frame
		
		let eyeInset: CGFloat = 11.958 * sizeAdjust
		let eyeWidth: CGFloat = 27.375 * sizeAdjust
		//Left Eye:
		createLine(animated, start: CGPoint(x: eyeInset, y: 0),
				   end:   CGPoint(x: eyeInset + eyeWidth, y: 0),
				   width: lineWidth, curve: 5 * sizeAdjust)
		//Right Eye:
		createLine(animated, start: CGPoint(x: frame.width - (eyeInset + eyeWidth), y: 0),
				   end:   CGPoint(x: frame.width - eyeInset, y: 0),
				   width: lineWidth, curve: 5 * sizeAdjust)
		//Mouth:
		let mouthStart = CGPoint(x: eyeInset, y: frame.height)
		let mouthEnd = CGPoint(x: frame.width - eyeInset, y: frame.height)
		let mouthCurve = -15.5 * sizeAdjust
		createLine(animated,
				   start: mouthStart, end: mouthEnd,
				   width: lineWidth, curve: mouthCurve)
		
		let cheekSize = sizeAdjust * 27
		let cheekY = sizeAdjust * 16.463
		createCircle(animated, size: cheekSize,
					 origin: CGPoint(x: 0, y: cheekY))
		createCircle(animated, size: cheekSize,
					 origin: CGPoint(x: frame.width - cheekSize, y: cheekY))
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func createCircle(_ animated: Bool, size: CGFloat, origin: CGPoint){
		let cheek = CAShapeLayer()
		self.addSublayer(cheek)
		cheek.fillColor = #colorLiteral(red: 0.9294117647, green: 0.6980392157, blue: 0.8156862745, alpha: 1).cgColor
		cheek.opacity = 0
		
		let rect = CGRect(origin: origin,
						  size: CGSize(width: size, height: size))
		cheek.path = CGPath(ellipseIn: rect, transform: nil)
		
		if(animated){
			let a = CABasicAnimation(keyPath: "opacity")
			a.beginTime = CACurrentMediaTime() + 1.5
			a.duration = 2
			a.fromValue = 0
			a.toValue = 1
			a.isRemovedOnCompletion = false
			a.fillMode = kCAFillModeForwards
			a.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
			cheek.add(a, forKey: "backgroundColor")
		}else{
			cheek.opacity = 1
		}
	}
	
	func createLine(_ animated: Bool, start: CGPoint, end: CGPoint, width: CGFloat, curve: CGFloat){
		let path = CGMutablePath()
		let length = end.x - start.x
		path.move(to: start)
		path.addQuadCurve(to: end,
						  control: start.applying(CGAffineTransform(translationX: length / 2, y: 0)))
		
		let line = CAShapeLayer()
		line.path = path
		line.lineWidth = width
		line.fillColor = UIColor.clear.cgColor
		line.strokeColor = #colorLiteral(red: 0.4196078431, green: 0.4235294118, blue: 0.4235294118, alpha: 1).cgColor
		
		let finalPath = CGMutablePath()
		finalPath.move(to: start.applying(CGAffineTransform(translationX: 0, y: curve)))
		finalPath.addQuadCurve(to: end.applying(CGAffineTransform(translationX: 0, y: curve)),
							   control: start.applying(CGAffineTransform(translationX: length / 2, y: -curve)))
		
		self.addSublayer(line)
		
		if(animated){
			let a = CABasicAnimation(keyPath: "path")
			a.duration = 2
			a.fromValue = path
			a.toValue = finalPath
			a.isRemovedOnCompletion = false
			a.fillMode = kCAFillModeBoth
			a.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
			line.add(a, forKey: "path")
		}else{
			line.path = finalPath
		}
	}
}
