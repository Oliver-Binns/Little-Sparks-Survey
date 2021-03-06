//
//  LittleSparks.swift
//  LittleSparksSurvey
//
//  Created by Oliver Binns on 12/05/2018.
//  Copyright © 2018 Oliver Binns. All rights reserved.
//

import UIKit

class LittleSparksLogo: UIView {
	static let originalWidth: CGFloat = 362.08
	static let originalHeight: CGFloat = 351.23
	
	func display(_ animated: Bool){
		let gradients = [
			[#colorLiteral(red: 0.9882352941, green: 0.937254902, blue: 0.2588235294, alpha: 1).cgColor, #colorLiteral(red: 0.9098039216, green: 0.2470588235, blue: 0.2235294118, alpha: 1).cgColor],
			[#colorLiteral(red: 0.5490196078, green: 0.7725490196, blue: 0.2549019608, alpha: 1).cgColor, #colorLiteral(red: 0.231372549, green: 0.7019607843, blue: 0.2901960784, alpha: 1).cgColor],
			[#colorLiteral(red: 0.1607843137, green: 0.6705882353, blue: 0.8862745098, alpha: 1).cgColor, #colorLiteral(red: 0.1137254902, green: 0.462745098, blue: 0.7333333333, alpha: 1).cgColor, #colorLiteral(red: 0.1137254902, green: 0.462745098, blue: 0.7333333333, alpha: 1).cgColor],
			[#colorLiteral(red: 0.7882352941, green: 0.4588235294, blue: 0.6823529412, alpha: 1).cgColor, #colorLiteral(red: 0.6823529412, green: 0.4039215686, blue: 0.662745098, alpha: 1).cgColor, #colorLiteral(red: 0.6039215686, green: 0.3647058824, blue: 0.6470588235, alpha: 1).cgColor, #colorLiteral(red: 0.5490196078, green: 0.3411764706, blue: 0.6352941176, alpha: 1).cgColor, #colorLiteral(red: 0.5176470588, green: 0.3254901961, blue: 0.631372549, alpha: 1).cgColor, #colorLiteral(red: 0.5058823529, green: 0.3215686275, blue: 0.6274509804, alpha: 1).cgColor],
			[#colorLiteral(red: 0.9450980392, green: 0.4117647059, blue: 0.1411764706, alpha: 1).cgColor, #colorLiteral(red: 0.937254902, green: 0.3411764706, blue: 0.1647058824, alpha: 1).cgColor, #colorLiteral(red: 0.9294117647, green: 0.2392156863, blue: 0.1843137255, alpha: 1).cgColor, #colorLiteral(red: 0.9215686275, green: 0.1215686275, blue: 0.2039215686, alpha: 1).cgColor]
		]
		
		for i in 0..<5{
			let petalWidth = bounds.width * (PetalLayer.originalWidth / LittleSparksLogo.originalWidth)
			let petalHeight = petalWidth / PetalLayer.aspectRatio
			
			let frame = CGRect(x: (bounds.width - petalWidth) / 2,
							   y: 0, width: petalWidth, height: petalHeight)
			
			let petal = PetalLayer(animated, frame: frame)
			petal.colors = gradients[i]
			petal.rotate(angle: -CGFloat(i) * 2 * CGFloat.pi / 5)
			
			layer.addSublayer(petal)
		}
		
		let faceYoffset = bounds.height * 162.603 / LittleSparksLogo.originalHeight
		let faceWidth = bounds.width * FaceLayer.originalWidth / LittleSparksLogo.originalWidth
		let faceHeight = bounds.height * FaceLayer.originalHeight / LittleSparksLogo.originalHeight
		
		layer.addSublayer(
			FaceLayer(animated,
					  frame: CGRect(x: (bounds.width - faceWidth) / 2,
									y: faceYoffset,
									width: faceWidth,
									height: faceHeight)
			)
		)
	}
}
extension CALayer{
	func rotate(angle: CGFloat){
		let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
		let point = CGPoint(x: bounds.width / 2, y: bounds.height)
		
		var transform = CATransform3DIdentity;
		transform = CATransform3DTranslate(transform, point.x-center.x, point.y-center.y, 0.0);
		transform = CATransform3DRotate(transform, angle, 0.0, 0.0, -1.0);
		transform = CATransform3DTranslate(transform, center.x-point.x, center.y-point.y, 0.0);
		self.transform = transform
	}
}
