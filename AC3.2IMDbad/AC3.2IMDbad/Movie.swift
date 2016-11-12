//
//  Movie.swift
//  AC3.2IMDbad
//
//  Created by Tom Seymour on 11/11/16.
//  Copyright © 2016 C4Q-3.2. All rights reserved.
//

import Foundation

class Movie {
    let briefInfo: BriefMovie
    var fullInfo: FullMovie?
    
    init(briefInfo: BriefMovie) {
        self.briefInfo = briefInfo
    }
    
    static func buildMovieArray(from data: Data) -> [Movie]? {
        
        do {
            let movieJSONdata: Any = try JSONSerialization.jsonObject(with: data, options: [])
            guard let resultDict = movieJSONdata as? [String: AnyObject] else {
                print("first error")
                return nil
            }
            
            guard let arrOfMovieDict = resultDict["Search"] as? [[String: String]] else { return nil }
            
            var arrOfMovies: [Movie] = []
            
            for dict in arrOfMovieDict {
                
                if let thisBriefMovie = BriefMovie(withDict: dict) {
                    let thisMovie = Movie(briefInfo: thisBriefMovie)
                    arrOfMovies.append(thisMovie)
                }
            }
            return arrOfMovies
            
        } catch let error as NSError {
            print("error here \(error)")
            return nil
        }
    }

}
