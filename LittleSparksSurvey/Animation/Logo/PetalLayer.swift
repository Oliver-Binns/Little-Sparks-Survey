//
//  Petal.swift
//  LittleSparksSurvey
//
//  Created by Oliver Binns on 13/05/2018.
//  Copyright © 2018 Oliver Binns. All rights reserved.
//

import UIKit

class PetalLayer: CAGradientLayer {
	static let originalWidth: CGFloat = 125.485
	static let originalHeight: CGFloat = 188.224
	static let aspectRatio = PetalLayer.originalWidth / PetalLayer.originalHeight
	
	init(_ animated: Bool, frame: CGRect){
		super.init()
		
		self.frame = frame
		
		let shapeMask = CAShapeLayer()
		let lineWidth: CGFloat = 5
		shapeMask.frame = CGRect(origin: CGPoint(x: lineWidth, y: lineWidth), size: frame.insetBy(dx: lineWidth * 2, dy: lineWidth * 2).size)
		shapeMask.fillColor = UIColor.clear.cgColor
		shapeMask.strokeColor = UIColor.black.cgColor
		shapeMask.lineWidth = lineWidth
		shapeMask.petalPath(true)
		self.mask = shapeMask
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
extension CAShapeLayer{
	func petalPath(_ animated: Bool){
		let height = bounds.height
		let ratio = PetalLayer.aspectRatio
		let curveAt = (1 / 3) * height
		let width = ratio * height
		let distance =  (34.875 / PetalLayer.originalWidth) * width
		
		
		
		let north = CGPoint(x: width / 2, y: 0)
		let east = CGPoint(x: width, y: curveAt)
		let bottomR = CGPoint(x: 3 * width / 4, y: 2 * height / 3)
		let bottomL = CGPoint(x: width / 4, y: 2 * height / 3)
		let center = CGPoint(x: width / 2, y: curveAt)
		let west = CGPoint(x: 0, y: curveAt)
		
		let starCurveLevel: CGFloat = 1.2
		
		let path = CGMutablePath()
		path.move(to: north)
		path.addCurve(to: east,
					  control1: north.applying(CGAffineTransform(translationX: distance, y: 0)),
					  control2: east.applying(CGAffineTransform(translationX: 0, y: -distance))
		)
		path.addQuadCurve(to: bottomR, control: east.applying(CGAffineTransform(translationX: 0, y: distance)))
		path.addQuadCurve(to: center, control: CGPoint(x: center.x * starCurveLevel, y: center.y))
		path.addQuadCurve(to: bottomL, control: CGPoint(x: center.x / starCurveLevel, y: center.y))
		path.addQuadCurve(to: west, control: west.applying(CGAffineTransform(translationX: 0, y: distance)))
		path.addCurve(to: north,
					  control1: west.applying(CGAffineTransform(translationX: 0, y: -distance)),
					  control2: north.applying(CGAffineTransform(translationX: -distance, y: 0))
		)
		
		if(animated){
			CATransaction.begin()
			let a = CABasicAnimation(keyPath: "strokeEnd")
			a.duration = 4
			a.fromValue = 0
			a.toValue = 1
			a.isRemovedOnCompletion = false
			a.fillMode = kCAFillModeBoth
			a.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
			CATransaction.setCompletionBlock{
				self.fillColor = self.strokeColor
			}
			self.path = path
			self.add(a, forKey: "strokeEndAnimation")
			CATransaction.commit()
		}else{
			self.path = path
		}
	}
}
