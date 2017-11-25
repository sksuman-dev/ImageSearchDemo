//
//  ViewController.swift
//  ImageSearchDemo
//
//  created by Suman on 11/25/17.
//  Copyright © 2017 suman. All rights reserved.
//

import UIKit
import AlamofireImage

class ViewController: UIViewController, SearchResultViewDelegate {

    
    // MARK: Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    @IBOutlet weak var resultView: SearchResultView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    // MARK: Control variables
    var isImageHidden = false
    var isApperingFirstTime = true
    var isAnimating = false
    
    // MARK: Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        resultView.delegate = self;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {
        
        //Trigger the API to fetch the search result. (Only if loading first time)
        if isApperingFirstTime {
            DataManager.fetchImages { (googleApiModel: GoogleAPIModel?) in
                //TODO: Error handling
                self.loader.stopAnimating()
                self.resultView.updateView(items: (googleApiModel?.items)!)
                print(googleApiModel?.items?[0].imageLink ?? "Not")
            }
            
            self.isApperingFirstTime = false;
        }
    }
    
    
    
    // MARK: IBActions
    @IBAction func ShowHideButtonClicked(_ sender: AnyObject) {
        
        //Do nothing if a animation is already in progress
        if self.isAnimating {
            return
        }
        
        //Animate the height of imageview
        self.isAnimating = true
        UIView.animate(withDuration: Constants.AnimationTime, animations: {
                self.imageHeight.constant = (CGFloat) (self.isImageHidden ? Constants.ImageHeight : 0)
                self.view.layoutIfNeeded()
            }, completion:{ (completed) -> Void in
                self.isImageHidden = !self.isImageHidden;
                self.isAnimating = false
        });
        
    }
    
    
    // MARK: Private functions
    func showErrorAlert(message: String) {
        //Bring the alert with custom message
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    
    // MARK: SearchResultView Delegate
    func resultView(sender: SearchResultView, didSelectResult resultItem: SearchItemModel) {
        
        //User selected a image. Lazy load the image to show (Placehodle image is provided to show until image gets loaded)
        self.imageView.af_setImage(withURL: URL(string:resultItem.imageLink!)!, placeholderImage:UIImage(named: "placeholder.jpg")!, completion: { (response) -> Void in
            
            //Error image not loaded
            if (response.error != nil) {
                self.showErrorAlert(message: "Not able to get image. Error: "+(response.error?.localizedDescription)!)
            }
            self.imageView.setNeedsLayout()
        })

    }
    
}










