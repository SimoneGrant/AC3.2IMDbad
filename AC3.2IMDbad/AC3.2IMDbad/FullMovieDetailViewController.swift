//
//  FullMovieDetailViewController.swift
//  AC3.2IMDbad
//
//  Created by Tom Seymour on 11/9/16.
//  Copyright © 2016 C4Q-3.2. All rights reserved.
//

import UIKit

class FullMovieDetailViewController: UIViewController, UICollectionViewDelegateFlowLayout  {
    
    var soundtracks: [Soundtrack]! = []
    var thisFullMovie: FullMovie!
    
    var thisBriefMovie: BriefMovie!

    
    @IBOutlet weak var FullMovieImageView: UIImageView!
    
    @IBOutlet weak var FullMovieTitileLabel: UILabel!
    
    @IBOutlet weak var soundtrackCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadFullMovieData()
        loadSoundtrackData()
        
    }
    
    func loadFullMovieData() {
        let fullMovieAPIEndpoint = "https://www.omdbapi.com/?i=\(thisBriefMovie.imdbID)"

        APIManager.manager.getData(endPoint: fullMovieAPIEndpoint) { (data: Data?) in
            guard let unwrappedData = data else { return }
            self.thisFullMovie = FullMovie.getFullMovie(from: unwrappedData)
            DispatchQueue.main.async {
                print("**********************************************")
                dump(self.thisFullMovie)
                self.FullMovieTitileLabel.text = self.thisFullMovie?.plot
            }
            APIManager.manager.getData(endPoint: self.thisFullMovie.posterURL) { (data: Data?) in
                guard let unwrappedData = data else { return }
                DispatchQueue.main.async {
                    self.FullMovieImageView.image = UIImage(data: unwrappedData)
                    self.view.reloadInputViews()
                }
            }
        }
    }
    
    func loadSoundtrackData() {
        let soundtrackAPIEndpoint = "https://api.spotify.com/v1/search?q=\(thisBriefMovie.titleSearchString)&type=album&limit=50"
        APIManager.manager.getData(endPoint: soundtrackAPIEndpoint) { (data: Data?) in
            guard let unwrappedData = data else { return }
            self.soundtracks = Soundtrack.buildSoundtrackArray(from: unwrappedData)
            dump(self.soundtracks[1])
        }
    }
    
    
    
    
    

    //        let imdbString = "http://www.imdb.com/title/" + thisBriefMovie.imdbID
    //        guard let url = URL(string: imdbString) else { return }
    //        UIApplication.shared.open(url, options: [:], completionHandler: nil)

    
    
    
}
