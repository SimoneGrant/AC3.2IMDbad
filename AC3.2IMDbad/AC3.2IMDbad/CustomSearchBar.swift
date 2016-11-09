//
//  CustomSearchBar.swift
//  AC3.2IMDbad
//
//  Created by Ilmira Estil on 11/9/16.
//  Copyright © 2016 C4Q-3.2. All rights reserved.
//

import UIKit

class CustomSearchBar: UISearchBar {
    
    let searchBar = UISearchBar()
    var searchTextColor: UIColor!
    var searchFont: UIFont!
    
    
    //create a search bar in the navigation
    func createSearchBar() {
        searchBar.showsCancelButton = false
        searchBar.placeholder = "Search A Movie"
        
        //        UINavigationItem.titleView = searchBar
    }
    
    //hide keyboard after user stops typing
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
}
