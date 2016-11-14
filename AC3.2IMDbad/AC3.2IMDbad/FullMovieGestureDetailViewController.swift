//
//  FullMovieGestureDetailViewController.swift
//  AC3.2IMDbad
//
//  Created by Ilmira Estil on 11/14/16.
//  Copyright © 2016 C4Q-3.2. All rights reserved.
//

import UIKit

class FullMovieGestureDetailViewController: UIViewController {

    @IBOutlet weak var swipeUpGesture: UISwipeGestureRecognizer!
    @IBOutlet var tapGestureOnPic: UITapGestureRecognizer!
    
    //MARK: - GESTURES
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func tapGestureOnPic(_ sender: UITapGestureRecognizer) {
        //if sender.numberOfTapsRequired
    
    }

}
