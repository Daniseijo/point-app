//
//  ViewController.swift
//  PointApp
//
//  Created by Daniel Seijo Sánchez on 12/07/16.
//  Copyright © 2016 Daniel Seijo Sánchez. All rights reserved.
//

import UIKit
import CoreLocation

import ImageViewer

let offset_HeaderStop:CGFloat = 40.0 // At this offset the Header stops its transformations
let offset_B_LabelHeader:CGFloat = 162.0 // At this offset the Black label reaches the Header
let distance_W_LabelHeader:CGFloat = 35.0 // The distance between the bottom of the Header and the top of the White Label
let distance_W_ButtonHeader:CGFloat = 45.0 // The distance between the bottom of the Header and the top of the White Label

class ViewController: UIViewController, UIScrollViewDelegate {

    /// The top view for when there is no iBeacon near
    @IBOutlet weak var startingView: UIView!
    
    /// The scrollview
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var header: UIView!
    
    @IBOutlet weak var elementImgBtn: UIButton!
    @IBOutlet weak var elementImgHeaderBtn: UIButton!
    
    @IBOutlet weak var placeHeaderLabel: UILabel!
    @IBOutlet var placeHeaderImgView:UIImageView!
    @IBOutlet var placeHeaderBlurImgView:UIImageView!
    
    @IBOutlet weak var elementHeaderLabel: UILabel!
    @IBOutlet weak var elementNameLabel: UILabel!
    
    @IBOutlet weak var elementDesc: UITextView!
    
    @IBOutlet weak var showInfoBtn: UIButton!
    
    var blurredHeaderImageView:UIImageView?
    
    var currentElement: Element?
    
    let locationManager = CLLocationManager()
    let region = CLBeaconRegion(proximityUUID: UUID(uuidString: "0018B4CC-1937-4981-B893-9D7191B22E35")!, identifier: "BeaconA");
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.delegate = self;
        if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.authorizedWhenInUse) {
            locationManager.requestWhenInUseAuthorization();
        }
        locationManager.startRangingBeacons(in: region);
        
        scrollView.delegate = self
        elementImgBtn.imageView?.contentMode = .scaleAspectFit
        elementImgHeaderBtn.imageView?.contentMode = .scaleAspectFit
        startingView.layer.zPosition = 3
        showInfoBtn.layer.zPosition = 4
        showInfoBtn.tintColor = UIColor.black
        
        let fixedWidth = elementDesc.frame.size.width
        elementDesc.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        let newSize = elementDesc.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        var newFrame = elementDesc.frame
        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        elementDesc.frame = newFrame;
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Header - Image
        
        placeHeaderImgView = UIImageView(frame: header.bounds)
        placeHeaderImgView?.image = UIImage(named: "header_cafeteria")
        placeHeaderImgView?.contentMode = .scaleAspectFill
        header.insertSubview(placeHeaderImgView, belowSubview: elementHeaderLabel)
        
        // Header - Blurred Image
        
        placeHeaderBlurImgView = UIImageView(frame: header.bounds)
        placeHeaderBlurImgView?.image = UIImage(named: "header_cafeteria")!.blurredImage(withRadius: 10, iterations: 20, tintColor: UIColor.clear)
        placeHeaderBlurImgView?.contentMode = UIViewContentMode.scaleAspectFill
        placeHeaderBlurImgView?.alpha = 0.0
        header.insertSubview(placeHeaderBlurImgView, belowSubview: elementHeaderLabel)
        
        header.clipsToBounds = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Button Actions
    
    @IBAction func elementImgBtnTap(_ sender: UIButton) {
        let imageProvider = SomeImageProvider(element: currentElement!)
        let buttonAssets = CloseButtonAssets(normal: UIImage(named:"close_normal")!, highlighted: UIImage(named: "close_highlighted"))
        let configuration = ImageViewerConfiguration(imageSize: CGSize(width: 10, height: 10), closeButtonAssets: buttonAssets)
        
        let imageViewer = ImageViewerController(imageProvider: imageProvider, configuration: configuration, displacedView: sender)
        self.presentImageViewer(imageViewer)
    }
    
    @IBAction func showInfo(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Point App", message: "Daniel Seijo Sánchez ©2016", preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: Auxiliar functions
    func changingElement(_ newElement: Element) {
        self.currentElement = newElement
        
        placeHeaderLabel.text = newElement.elementPlace?.placeName
        placeHeaderImgView.image = newElement.elementPlace?.placeImg
        placeHeaderBlurImgView.image = newElement.elementPlace?.placeImg?.blurredImage(withRadius: 10, iterations: 20, tintColor: UIColor.clear)
        self.view.backgroundColor = newElement.elementPlace?.placeColor
        
        elementNameLabel.text = newElement.elementName
        elementHeaderLabel.text = newElement.elementName
        
        elementImgBtn.setImage(newElement.elementImg, for: UIControlState())
        elementImgHeaderBtn.setImage(newElement.elementImg, for: UIControlState())
        
        elementDesc.text = newElement.elementDescription
        
        if !startingView.isHidden {
            startingView.isHidden = true
            showInfoBtn.tintColor = UIColor.white
            UIApplication.shared.statusBarStyle = .lightContent
        }
    }
    
}

// MARK: - Location Manager Delegate
extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        
        var knownBeacons = beacons.filter{ $0.proximity == .immediate }
        knownBeacons.append(contentsOf: beacons.filter{ $0.proximity == .near })
            
        if (knownBeacons.count > 0) {
            let closestBeacon = knownBeacons[0]
            
            if self.currentElement == nil || closestBeacon.major != self.currentElement?.elementPlace?.major || closestBeacon.minor != self.currentElement?.minor {
                PointAppAPI.fetchBeacon(UUID: region.proximityUUID.uuidString, major: closestBeacon.major, minor: closestBeacon.minor) { (element) in
                    self.changingElement(element)
                }
            }
            
            if self.currentElement != nil {
                currentElement?.elementPlace?.major = closestBeacon.major
                currentElement?.minor = closestBeacon.minor
            }
            
        } else {
            startingView.isHidden = false
            showInfoBtn.tintColor = UIColor.black
            UIApplication.shared.statusBarStyle = .default
            currentElement = nil
        }
    }
    
    func CLProximity2String(proximity: CLProximity) -> String {
        switch proximity {
        case .far:
            return "Far";
        case .immediate:
            return "Inmediate";
        case .near:
            return "Near";
        case .unknown:
            return "Unknown";
        }
    }
}

// MARK: - Scroll View Twitter Effect [http://www.thinkandbuild.it/implementing-the-twitter-ios-app-ui/]
extension ViewController {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
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
            elementHeaderLabel.layer.transform = labelTransform
            
            var buttonTransform = CATransform3DMakeTranslation(0, max(-distance_W_ButtonHeader, offset_B_LabelHeader - offset), 0)
            buttonTransform = CATransform3DScale(buttonTransform, 1.0,  1.0, 1.0)
            elementImgHeaderBtn.layer.transform = buttonTransform
            
            //  ------------ Blur
            
            placeHeaderBlurImgView?.alpha = min (1.0, (offset - offset_B_LabelHeader)/distance_W_LabelHeader)
            
            // Avatar -----------
            
            let avatarScaleFactor = (min(offset_HeaderStop, offset)) / elementImgBtn.bounds.height / 1.4 // Slow down the animation
            let avatarSizeVariation = ((elementImgBtn.bounds.height * (1.0 + avatarScaleFactor)) - elementImgBtn.bounds.height) / 2.0
            avatarTransform = CATransform3DTranslate(avatarTransform, 0, avatarSizeVariation, 0)
            avatarTransform = CATransform3DScale(avatarTransform,  1.0 - avatarScaleFactor, 1.0 - avatarScaleFactor, 1)
            
            if offset <= offset_HeaderStop {
                
                if elementImgBtn.layer.zPosition < header.layer.zPosition{
                    header.layer.zPosition = 0
                }
                
            } else {
                if elementImgBtn.layer.zPosition >= header.layer.zPosition{
                    header.layer.zPosition = 2
                }
            }
        }
        
        // ------------- Place Label
        placeHeaderLabel.alpha = min(1.0, (offset_HeaderStop - offset) / offset_HeaderStop)
        
        // Apply Transformations
        
        header.layer.transform = headerTransform
        elementImgBtn.layer.transform = avatarTransform
    }
}

class SomeImageProvider: ImageProvider {
    
    var element: Element?
    
    init(element: Element) {
        self.element = element
    }
    
    var imageCount: Int {
        return 1
    }
    
    func provideImage(_ completion: (UIImage?) -> Void) {
        completion(element?.elementImg)
    }
    
    func provideImage(atIndex index: Int, completion: (UIImage?) -> Void) {
        completion(element?.elementImg)
    }
}
