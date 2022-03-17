#  Project Title: Nine Bar

## About Nine Bar
Nine Bar is an app for coffee lovers. Users can search coffee shops based on the locations users enter. The app will provide the result of up to 10 coffee shops that are open now using Yelp API.

## Steps to Build & Run Nine Bar
1. Unzip "Nine Bar.zip" file.
2. Open the terminal.
3. Go to "Nine Bar" directory.
4. Type "pod Install" in the terminal and install pod files.
5. After installation has been completed, open "Nine Bar.xcworkspace".
6. Run the app.

## User Experience

## 1. Search Cafe View Controller
This is the initial view controller.

Search text field: Users can type the locations (the street name, city name, postal code, etc) in the search text field.
Search Button: By tapping the Search button, users will lead to the Results Map View Controller and will be able to see the search results. The search results can be seen in both map and table view (Results Map View Controller & Results Table View Controller).

## 2. Results Map View Controller
Results Map View Controller shows the search results in a map view. When tapping a pin, users will lead to the detail page of the selected store.

## 3. Results Table View Controller
Results Table View Controller shows the search results in a table view. When tapping a table row, users will lead to the detail page of the selected store.

## 4. Favorites List View Controller
Favorites List View Controller shows the list of the user's favorite coffee shops. The data will be stored in the persistent store, and therefore, the saved data will be displayed when the app is relaunched. When tapping a table row, users will lead to the detail page of the selected store.

Delete Button: Delete button will show up after swiping left on a table row. Users can remove their favorite stores by tapping the delete button.

## 5. Cafe Detail View Controller
This is the detail page of the store. 

Photo collection view: Three photos of the store is displayed at the top. Users can swipe left to see the next photos.
Call Button: Users can make a call to the store. (Note that this feature won't be available on a simulator.)
Website Button: Users will lead to the store's web page in Yelp.
Directions Button: Users will lead to Google Maps and can see the directions to the store.
Favorites Button: Users can add the store to the favorite list. The button only provides the function to add their favorite store to the list. Users will be able to remove the stores from their favorite list on the Favorites List View Controller.
Store Map View: A pin of the store is displayed. Users can zoom in, zoom out, and move around on the map view.
