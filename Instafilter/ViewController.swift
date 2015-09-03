//
//  ViewController.swift
//  Instafilter
//
//  Created by Yohannes Wijaya on 9/3/15.
//  Copyright © 2015 Yohannes Wijaya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - IBOutlet Properties
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var intensitySlider: UISlider!
    
    // MARK: - IBAction Properties
    
    @IBAction func changeFilterButtonAction(sender: UIButton) {
    }
    @IBAction func saveImageButtonAction(sender: UIButton) {
    }
    @IBAction func changeIntensitySliderAction(sender: UISlider) {
    }
}

