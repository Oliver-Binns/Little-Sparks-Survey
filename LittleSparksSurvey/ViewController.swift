//
//  ViewController.swift
//  LittleSparksSurvey
//
//  Created by Oliver Binns on 07/03/2018.
//  Copyright © 2018 Oliver Binns. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	@IBOutlet var logo: LittleSparks!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}
	
	override func viewDidAppear(_ animated: Bool) {
		logo.display(true)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

