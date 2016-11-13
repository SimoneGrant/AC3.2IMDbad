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
    
    @IBOutlet weak var soundtrackImageView: UIImageView!
    
    @IBOutlet weak var soundtrackTextLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        soundtrackTextLabel.text = thisSoundtrack.title
        //soundtrackImageView.image = UIImage(data: thisSoundtrack.images[0].imageData!)

        // Do any additional setup after loading the view.
    }

}
