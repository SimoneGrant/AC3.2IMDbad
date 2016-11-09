//
//  FullMovieDetailViewController.swift
//  AC3.2IMDbad
//
//  Created by Ilmira Estil on 11/9/16.
//  Copyright © 2016 C4Q-3.2. All rights reserved.
//

import UIKit

class FullMovieDetailViewController: UIViewController {
    @IBOutlet weak var fullMovieImage: UIImageView!
    @IBOutlet weak var fullMovieLabel: UILabel!
    
    var detailFullMovie: FullMovie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
            self.fullMovieLabel.text = detailFullMovie?.title
            //self.fullMovieImage.image = nil
            getFullMovieImage()
    }

    func getFullMovieImage() {
        APIManager.manager.getData(endPoint: (detailFullMovie?.posterURL)!) { (data: Data?) in
            if let validData = data,
                let image = UIImage(data: validData) {
                DispatchQueue.main.async {
                    self.fullMovieImage.image = image
                    self.fullMovieImage.setNeedsLayout()
                }
            }
        }
    }

}
