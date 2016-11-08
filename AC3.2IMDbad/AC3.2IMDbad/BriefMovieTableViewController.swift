//
//  BriefMovieTableViewController.swift
//  AC3.2IMDbad
//
//  Created by Tom Seymour on 11/8/16.
//  Copyright © 2016 C4Q-3.2. All rights reserved.
//

import UIKit

class BriefMovieTableViewController: UITableViewController, UISearchBarDelegate {
    var briefMovies = [BriefMovie]()
    let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        createSearchBar()
    }
    
    func loadData() {
        let apiEndpoint = "https://www.omdbapi.com/?s=batman"
        APIManager.manager.getData(endPoint: apiEndpoint) { (data: Data?) in
            guard let unwrappedData = data else { return }
            self.briefMovies = BriefMovie.buildBriefMovieArray(from: unwrappedData)!
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    //create a search bar in the navigation
    func createSearchBar() {
        searchBar.showsCancelButton = true
        searchBar.placeholder = "Search Movie or Soundtrack"
        searchBar.delegate = self
        
        self.navigationItem.titleView = searchBar
    }
    
    //hide keyboard after user stops typing
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return briefMovies.count
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "briefMovieTableViewCell", for: indexPath)
        let thisBriefMovie = briefMovies[indexPath.row]
        cell.textLabel?.text = thisBriefMovie.title
        APIManager.manager.getData(endPoint: thisBriefMovie.poster) { (data: Data?) in
            guard let unwrappedData = data else { return }
            DispatchQueue.main.async {
                cell.imageView?.image = UIImage(data: unwrappedData)
                cell.setNeedsLayout()
            }
            
        }
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let thisBriefMovie = briefMovies[indexPath.row]
        let myAPIEndpoint = "https://www.omdbapi.com/?i=\(thisBriefMovie.imdbID)"
        print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" + myAPIEndpoint)
        APIManager.manager.getData(endPoint: myAPIEndpoint) { (data: Data?) in
            guard let unwrappedData = data else { return }
            let thisFullMovie = FullMovie.getFullMovie(from: unwrappedData)
            dump(thisFullMovie)
        }
    }

}
