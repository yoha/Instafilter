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
        
        self.title = "Instafilter"
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
        let alertController = UIAlertController(title: "Choose filter", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        alertController.addAction(UIAlertAction(title: "CIBumpDistortion", style: UIAlertActionStyle.Default, handler: setFilter))
        alertController.addAction(UIAlertAction(title: "CIGaussianBlur", style: .Default, handler: setFilter))
        alertController.addAction(UIAlertAction(title: "CIPixellate", style: .Default, handler: setFilter))
        alertController.addAction(UIAlertAction(title: "CISepiaTone", style: .Default, handler: setFilter))
        alertController.addAction(UIAlertAction(title: "CITwirlDistortion", style: .Default, handler: setFilter))
        alertController.addAction(UIAlertAction(title: "CIUnsharpMask", style: .Default, handler: setFilter))
        alertController.addAction(UIAlertAction(title: "CIVignette", style: .Default, handler: setFilter))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
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
        let acceptableFilterParams = self.coreImageFilter.inputKeys
        if acceptableFilterParams.contains(kCIInputIntensityKey) {
            self.coreImageFilter.setValue(self.intensitySlider.value, forKey: kCIInputIntensityKey)
        }
        if acceptableFilterParams.contains(kCIInputRadiusKey) {
            self.coreImageFilter.setValue(self.intensitySlider.value * 200, forKey: kCIInputRadiusKey)
        }
        if acceptableFilterParams.contains(kCIInputScaleKey) {
            self.coreImageFilter.setValue(self.intensitySlider.value * 10, forKey: kCIInputScaleKey)
        }
        if acceptableFilterParams.contains(kCIInputCenterKey) {
            self.coreImageFilter.setValue(CIVector(x: self.currentImage.size.width / 2, y: self.currentImage.size.height / 2), forKey: kCIInputCenterKey)
        }
        
        let cgImage = self.coreImageContext.createCGImage(self.coreImageFilter.outputImage, fromRect: self.coreImageFilter.outputImage.extent)
        let processedImage = UIImage(CGImage: cgImage)
        
        self.imageView.image = processedImage
        
    }
    
    func setFilter(action: UIAlertAction) {
        self.coreImageFilter = CIFilter(name: action.title!)
        let imageToBeFiltered = CIImage(image: self.currentImage)
        self.coreImageFilter.setValue(imageToBeFiltered, forKey: kCIInputImageKey)
        self.applyFilterProcessing()
    }
}