//
//  SoundtrackDetailViewController.swift
//  AC3.2IMDbad
//
//  Created by Ilmira Estil on 11/13/16.
//  Copyright © 2016 C4Q-3.2. All rights reserved.
//

import UIKit

class SoundtrackDetailViewController: UIViewController {
    var thisSoundtrack: Soundtrack!
    
    @IBOutlet weak var soundtrackBackgroundImage: UIImageView!
    @IBOutlet weak var soundtrackImageView: UIImageView!
    @IBOutlet weak var soundtrackTextLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //soundtrackImageView.image = UIImage(data: thisSoundtrack)
        soundtrackTextLabel.text = thisSoundtrack.title
        
        /*
        let soundTrackImageData = thisSoundtrack.images[0].imageData
        if soundTrackImageData != nil {
            APIManager.manager.getData(endPoint: thisSoundtrack.images[0].urlString, callback: { (data: Data?) in
                DispatchQueue.main.async {
                    self.soundtrackImageView.image = UIImage(data: soundTrackImageData!)
                    self.view.setNeedsLayout()
                }
            })
            
        }
         */
    }
 
   
}
