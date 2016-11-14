# AC3.2IMDbad

#Project: IMDbad

An interactive app that searches and catalogs movie details and soundtracks. Inspired by IMDb.

![logo3](https://cloud.githubusercontent.com/assets/20913255/20250258/9a3235a0-a9da-11e6-9399-84d059d3c127.jpg)


## Tom

## Nesting Objects

During the course of this project learned about nesting model objects into one main object. IMDbad has 3 main objects for it’s model, a briefMovie, a fullMovie and a soundtrack. The initial view controller had an array of briefMovie and segued into a detail view passing it a fullMovie after making an API call for the full movie. 
I created a Movie class that has a briefInfo property and an optional fullInfo property. The initial API call from the BriefMovieViewController now creates an array of Movie and just populates the breifInfo property, leaving the fullInfo as nil. Now when a cell is selected the code checks to see if that movie has fullInfo, if it doesn’t it makes the API call to get the full Info, creates an instance of fullMovie and then assigns it to the fullInfo property of that Movie. This way it saves the info into the object as it goes and if you navigate to a cell that you have navigated to before it uses the stored fullInfo and doesn’t make another API call.
This works well with classes as they are reference types.

I also did the same with the soundtrack info. Movie has an optional property of an array of Soundtrack and checks to see if that info is already there before making the api call to Spotify.

Another trick I learned, in the same vein was to save image data. I created an optional property in fullMovie of type data. Before the app makes an api call to get image data it checks to see if that fullMovie already has image data first and if not makes the api call and assigns that data to the property. 

Overall I feel much more comfortable modeling data after working on this project.


## Mira

### Project planning and Git methodology

I realized how much more time is needed for pre-modeling before actually coding any project.  It was tough developing a project with new code or ideas while maintaining a standard code structure to avoid merge conflicts. I've probably learned bad Git habit while manually downloading new files, but have a  much better understanding as to how useful Git can be when developing projects with others.  


## Simone

### Collection View and Auto Layout

This project gave me an opportunity to dive deep into UICollectionView and Auto Layout. I learned how to layer views to create
a custom UI based on a collection view. I also learned more about how to customize various UI elements, both programmatically and in the storyboard. This included the UINavigation, UISearchBar, and custom font. Working with git was also a challenge, but I ended the project with a greater understanding of the git workflow.
