//
//  FullMovieDetailViewController.swift
//  AC3.2IMDbad
//
//  Created by Tom Seymour on 11/9/16.
//  Copyright © 2016 C4Q-3.2. All rights reserved.
//

import UIKit

class FullMovieDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    var thisMovie: Movie!

    @IBOutlet weak var fullMovieImageView: UIImageView!
    @IBOutlet weak var fullMovieTitileLabel: UILabel!
    @IBOutlet weak var soundtrackCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadFullMovieData()
        loadSoundtrackData()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "imdb", style: .plain, target: self, action: #selector(goToIMDb))
    }
    
    func loadFullMovieData() {
        
        self.fullMovieImageView.image = #imageLiteral(resourceName: "loadingImage")
        self.fullMovieTitileLabel.text = "... loading info"
        
        // CHECK HERE TO SEE IF THIS MOVIE ALREADY HAS A FULL MOVIE BEFORE API CALL
   
        if thisMovie.fullInfo == nil {
            
            let fullMovieAPIEndpoint = "https://www.omdbapi.com/?i=\(thisMovie.briefInfo.imdbID)"
            
            APIManager.manager.getData(endPoint: fullMovieAPIEndpoint) { (data: Data?) in
                guard let unwrappedData = data else { return }
                self.thisMovie.fullInfo = Movie.getFullMovie(from: unwrappedData)
               
                DispatchQueue.main.async {
                    print("*****************FULL MOVIE*****************************")
                    dump(self.thisMovie.fullInfo)
                    
                    // MIGHT WANNA BANG THAT FULL INFO                \|/
                    self.navigationItem.title = self.thisMovie.fullInfo?.title
                    self.fullMovieTitileLabel.text = self.bulidFullMovieLabelText(withFullMovie: self.thisMovie.fullInfo!)
                    self.fullMovieImageView.image = #imageLiteral(resourceName: "noAvailableImage")
                }
                APIManager.manager.getData(endPoint: self.thisMovie.fullInfo!.posterURL) { (data: Data?) in
                    guard let unwrappedData = data else { return }
                    self.thisMovie.fullInfo?.posterData = unwrappedData
                    DispatchQueue.main.async {
                        self.fullMovieImageView.image = UIImage(data: unwrappedData)
                        self.view.reloadInputViews()
                    }
                }
            }
            
        } else {
            self.navigationItem.title = self.thisMovie.fullInfo!.title
            self.fullMovieTitileLabel.text = self.bulidFullMovieLabelText(withFullMovie: self.thisMovie.fullInfo!)
            
            if let fullMoviePosterData = thisMovie.fullInfo?.posterData {
                self.fullMovieImageView.image = UIImage(data: fullMoviePosterData)
            } else {
                self.fullMovieImageView.image = #imageLiteral(resourceName: "noAvailableImage")
            }
        }
        
    }
    
    func loadSoundtrackData() {
        
        if thisMovie.soundtracks == nil {
            
            let soundtrackAPIEndpoint = "https://api.spotify.com/v1/search?q=\(thisMovie.briefInfo.titleSearchString)&type=album&limit=50"
            APIManager.manager.getData(endPoint: soundtrackAPIEndpoint) { (data: Data?) in
                guard let unwrappedData = data else { return }
                self.thisMovie.soundtracks = Movie.buildSoundtrackArray(from: unwrappedData)
                if (self.thisMovie.soundtracks?.count)! > 0 {
                    print("________________________ This is the soundtrack! ______________________________")
                    dump(self.thisMovie.soundtracks?[0])
                } else {
                    print("____________________ NO SOUNDTRACKS___________________")
                }
            }
        }
        
    }
    
    @IBAction func goToIMDb(_ sender: UIButton) {
        let imdbString = "http://www.imdb.com/title/" + thisMovie.briefInfo.imdbID
        guard let url = URL(string: imdbString) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }

    func bulidFullMovieLabelText(withFullMovie tfm: FullMovie) -> String {
        return "\(tfm.year), Rated: \(tfm.rated), Runtime: \(tfm.runtime), IMDb Rating: \(tfm.imdbRating)\nGenre: \(tfm.genre)\nCast: \(tfm.cast)\nSummary:   \(tfm.plot)"
    }
    
    // MARK: Collection View Data Souce Methods
    
    private let soundtrackReuseIdentifier = "soundtrackCell"
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        print("___________________ Collection View Something ___________________")
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return thisMovie.soundtracks?.count ?? 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.soundtrackReuseIdentifier, for: indexPath) as! SoundtrackCollectionViewCell
        guard let thisSoundtrack = thisMovie.soundtracks?[indexPath.item] else { return cell }
        
        cell.soundtrackTextLabel.text = "\(thisSoundtrack.title)\n-\(thisSoundtrack.artistName)"
        
<<<<<<< HEAD
        APIManager.manager.getData(endPoint: thisSoundtrack.images[2].urlString) { (data: Data?) in
=======
        APIManager.manager.getData(endPoint: thisSoundtrack.images[0].urlString) { (data: Data?) in
>>>>>>> 1df1137c1749b529a6c48ba49200b698ab65f97b
            guard let unwrappedData = data else { return }
            DispatchQueue.main.async {
                cell.soundtrackImageView?.image = UIImage(data: unwrappedData)
                cell.setNeedsLayout()
            }
        }
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    private let itemsPerColumn = CGFloat(1)
    private let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = sectionInsets.left * (itemsPerColumn + 1)
<<<<<<< HEAD
        let availableHeight = view.frame.width - paddingSpace
=======
        let availableHeight = collectionView.frame.height - paddingSpace
>>>>>>> 1df1137c1749b529a6c48ba49200b698ab65f97b
        let heightPerItem = availableHeight / itemsPerColumn
        
        return CGSize(width: heightPerItem, height: heightPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }

}



