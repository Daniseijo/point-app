//
//  ViewController.swift
//  PointApp
//
//  Created by Daniel Seijo Sánchez on 12/07/16.
//  Copyright © 2016 Daniel Seijo Sánchez. All rights reserved.
//

import UIKit
import ImageViewer

let offset_HeaderStop:CGFloat = 40.0 // At this offset the Header stops its transformations
let offset_B_LabelHeader:CGFloat = 162.0 // At this offset the Black label reaches the Header
let distance_W_LabelHeader:CGFloat = 35.0 // The distance between the bottom of the Header and the top of the White Label
let distance_W_ButtonHeader:CGFloat = 42.0 // The distance between the bottom of the Header and the top of the White Label

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var descPhoto: UIButton!
    @IBOutlet weak var header: UIView!
    @IBOutlet weak var descHeaderBtn: UIButton!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet var headerImageView:UIImageView!
    @IBOutlet var headerBlurImageView:UIImageView!
    
    var blurredHeaderImageView:UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        scrollView.delegate = self
        descPhoto.imageView?.contentMode = .ScaleAspectFit
        descHeaderBtn.imageView?.contentMode = .ScaleAspectFit
    }
    
    override func viewDidAppear(animated: Bool) {
        // Header - Image
        
        headerImageView = UIImageView(frame: header.bounds)
        headerImageView?.image = UIImage(named: "header_bg")
        headerImageView?.contentMode = .ScaleAspectFill
        header.insertSubview(headerImageView, belowSubview: headerLabel)
        
        // Header - Blurred Image
        
        headerBlurImageView = UIImageView(frame: header.bounds)
        headerBlurImageView?.image = UIImage(named: "header_bg")?.blurredImageWithRadius(10, iterations: 20, tintColor: UIColor.clearColor())
        headerBlurImageView?.contentMode = UIViewContentMode.ScaleAspectFill
        headerBlurImageView?.alpha = 0.0
        header.insertSubview(headerBlurImageView, belowSubview: headerLabel)
        
        header.clipsToBounds = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func descPhotoTap(sender: UIButton) {
        let imageProvider = SomeImageProvider()
        let buttonAssets = CloseButtonAssets(normal: UIImage(named:"close_normal")!, highlighted: UIImage(named: "close_highlighted"))
        let configuration = ImageViewerConfiguration(imageSize: CGSize(width: 10, height: 10), closeButtonAssets: buttonAssets)
        
        let imageViewer = ImageViewerController(imageProvider: imageProvider, configuration: configuration, displacedView: sender)
        self.presentImageViewer(imageViewer)
    }

}

class SomeImageProvider: ImageProvider {
    
    func provideImage(completion: UIImage? -> Void) {
        completion(UIImage(named: "menu-board"))
    }
    
    func provideImage(atIndex index: Int, completion: UIImage? -> Void) {
        completion(UIImage(named: "menu-board"))
    }
}

extension ViewController {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        var avatarTransform = CATransform3DIdentity
        var headerTransform = CATransform3DIdentity
        
        // PULL DOWN -----------------
        
        if offset < 0 {
            
            let headerScaleFactor:CGFloat = -(offset) / header.bounds.height
            let headerSizeVariation = ((header.bounds.height * (1.0 + headerScaleFactor)) - header.bounds.height)/2.0
            headerTransform = CATransform3DTranslate(headerTransform, 0, headerSizeVariation, 0)
            headerTransform = CATransform3DScale(headerTransform, 1.0 + headerScaleFactor, 1.0 + headerScaleFactor, 0)
            
            header.layer.transform = headerTransform
        }
            
            // SCROLL UP/DOWN ------------
            
        else {
            
            // Header -----------
            
            headerTransform = CATransform3DTranslate(headerTransform, 0, max(-offset_HeaderStop, -offset), 0)
            
            //  ------------ Label
            
            let labelTransform = CATransform3DMakeTranslation(0, max(-distance_W_LabelHeader, offset_B_LabelHeader - offset), 0)
            headerLabel.layer.transform = labelTransform
            
            var buttonTransform = CATransform3DMakeTranslation(0, max(-distance_W_ButtonHeader, offset_B_LabelHeader - offset), 0)
            buttonTransform = CATransform3DScale(buttonTransform, 1.0,  1.0, 1.0)
            descHeaderBtn.layer.transform = buttonTransform
            
            //  ------------ Blur
            
            headerBlurImageView?.alpha = min (1.0, (offset - offset_B_LabelHeader)/distance_W_LabelHeader)
            
            // Avatar -----------
            
            let avatarScaleFactor = (min(offset_HeaderStop, offset)) / descPhoto.bounds.height / 1.4 // Slow down the animation
            let avatarSizeVariation = ((descPhoto.bounds.height * (1.0 + avatarScaleFactor)) - descPhoto.bounds.height) / 2.0
            avatarTransform = CATransform3DTranslate(avatarTransform, 0, avatarSizeVariation, 0)
            avatarTransform = CATransform3DScale(avatarTransform,  1.0 - avatarScaleFactor, 1.0 - avatarScaleFactor, 1)
            
            if offset <= offset_HeaderStop {
                
                if descPhoto.layer.zPosition < header.layer.zPosition{
                    header.layer.zPosition = 0
                }
                
            } else {
                if descPhoto.layer.zPosition >= header.layer.zPosition{
                    header.layer.zPosition = 2
                }
            }
        }
        
        // Apply Transformations
        
        header.layer.transform = headerTransform
        descPhoto.layer.transform = avatarTransform
    }
}