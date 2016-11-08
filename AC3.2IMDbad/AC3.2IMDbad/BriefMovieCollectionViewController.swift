//
//  BriefMovieTableViewController.swift
//  AC3.2IMDbad
//
//  Created by Tom Seymour on 11/8/16.
//  Copyright © 2016 C4Q-3.2. All rights reserved.
//

import UIKit


class BriefMovieCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    fileprivate let itemsPerRow: CGFloat = 3
    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    var briefMovies = [BriefMovie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    func loadData() {
        let apiEndpoint = "https://www.omdbapi.com/?s=batman"
        APIManager.manager.getData(endPoint: apiEndpoint) { (data: Data?) in
            guard let unwrappedData = data else { return }
            self.briefMovies = BriefMovie.buildBriefMovieArray(from: unwrappedData)!
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.briefMovies.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BriefMovieCollectionViewCell.cellID, for: indexPath)
        if let acvc = cell as? BriefMovieCollectionViewCell {
            let briefMovie = self.briefMovies[indexPath.row]
            //acvc.briefMovieLabel.text = "\(indexPath.row + 1). \(briefMovie.title)"
            
            
            if briefMovies.count > 0 {
                APIManager.manager.getData(endPoint: briefMovie.poster) { (data: Data?) in
                    if let validData = data,
                        let image = UIImage(data: validData) {
                        DispatchQueue.main.async {
                            acvc.briefMovieImage.image = image
                            acvc.setNeedsLayout()
                            
                        }
                    }
                }
            }
        }
        
        return cell
    }
    
    // MARK: - TextField Delegate
    /*
     func textFieldShouldReturn(_ textField: UITextField) -> Bool {
     search(textField.text!)
     textField.text = nil
     textField.resignFirstResponder()
     return true
     }
     */
    
    /*
     // MARK: - Utility search
     func search(_ term: String) {
     self.title = term
     let escapedString = term.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
     //escaping avoiding unsafe characters?(ex: spaces and %)
     
     APIRequestManager.manager.getData(endPoint: "https://api.spotify.com/v1/search?q=\(escapedString!)&type=album&limit=50") { (data: Data?) in
     if  let validData = data,
     let validAlbums = Album.albums(from: validData) {
     self.albums = validAlbums
     DispatchQueue.main.async {
     self.collectionView?.reloadData()
     }
     }
     }
     }
     */
    
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1) //how many items per row
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    // margin around the whole section
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    // spacing between rows if vertical / columns if horizontal
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
}
