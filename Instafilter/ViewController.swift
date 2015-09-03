//
//  ViewController.swift
//  Instafilter
//
//  Created by Yohannes Wijaya on 9/3/15.
//  Copyright © 2015 Yohannes Wijaya. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "importPicture")
        self.coreImageContext = CIContext(options: nil)
        self.coreImageFilter = CIFilter(name: "CISepiaTone")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Stored Properties
    
    var currentImage: UIImage!
    var coreImageContext: CIContext!
    var coreImageFilter: CIFilter!
    
    // MARK: - IBOutlet Properties
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var intensitySlider: UISlider!
    
    // MARK: - IBAction Properties
    
    @IBAction func changeFilterButtonAction(sender: UIButton) {
    }
    @IBAction func saveImageButtonAction(sender: UIButton) {
    }
    @IBAction func changeIntensitySliderAction(sender: UISlider) {
        self.applyFilterProcessing()
    }
    
    // MARK: - Delegate Methods
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        var newImage: UIImage!
        let imageToBeAppliedWithFilter: CIImage!
        
        if let possibleNewImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            newImage = possibleNewImage
        }
        else if let possibleNewImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            newImage = possibleNewImage
        }
        else {
            return
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
        self.currentImage = newImage
        
        imageToBeAppliedWithFilter = CIImage(image: self.currentImage)
        self.coreImageFilter.setValue(imageToBeAppliedWithFilter, forKey: kCIInputImageKey)
        self.applyFilterProcessing()
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Local Properties
    
    func importPicture() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.allowsEditing = true
        imagePickerController.delegate = self
        self.presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    func applyFilterProcessing() {
        self.coreImageFilter.setValue(self.intensitySlider.value, forKey: kCIInputIntensityKey)
        
        let cgImage = self.coreImageContext.createCGImage(self.coreImageFilter.outputImage, fromRect: self.coreImageFilter.outputImage.extent)
        let processedImage = UIImage(CGImage: cgImage)
        
        self.imageView.image = processedimage
        
    }
}

