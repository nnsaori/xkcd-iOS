# xkcd-iOS


## INTRO

Thank you for the opportunity. I enjoyed the coding challenge. xkcd isn't popular in Japan, so it was my first time reading these.



## THE SOLUTION

I created an application using Swift version 5.5.1. 
I've been a Swift developer for ~6 years, and it's my preferred stack because its's good for rapid iteration and quick prototyping.

## SPECIFICATION
* Xcode 13+
* Swift 5+
* iOS 15+

## MVP FEATURES

I've selected the MVP features that can be reasonably completed within the deadline.



1. Browsing comics
2. Searching comics
3. Viewing comic details and explanation
4. Favorite comics
5. Sending comic
6. Supporting multiple form factors


### 1. Browsing comics - View the latest xkcd comic

A preview of the latest comic is displayed on the home screen with an overlay showing comic ID and title.

<img src="https://user-images.githubusercontent.com/5316319/143376201-600b0201-7cbf-4855-992c-7217c27f4ebc.png" width="300" >

I used the [xkcd JSON API](https://xkcd.com/info.0.json) to display the current comic on the home screen. A preview of the comic is displayed in a table view. Every comic image has a different aspect ratio, so the preview allows them to be evenly stacked. The overlay shows the comic ID and title. The user can tap the comic to view the comic details.  

* **Upcoming feature:** Additional research is required to know what comic details are most important and should be displayed on the home screen overlay.
* **Upcoming feature:** The API doesn't support paging, so there's no way to view "next" comic in the table yet. 



### 2. Searching comics - Search for a comic by ID or text

A search field is displayed on the home screen above the latest comic.

<img src="https://user-images.githubusercontent.com/5316319/143376947-c6fe6384-bb4a-42b4-9d49-047b5b12399c.png" width="300" >


The xkcd search ([relevantxkcd.appspot.com](https://relevantxkcd.appspot.com/)) you provided didn't work (Status 500). I was able to find another search API ([relevant-xkcd.github.io](https://relevant-xkcd.github.io/)) that was working. 

* **MVP blocker:** Unfortunately, this API also stopped working (Status 503). I've messaged the API owner to fix the issue. 
* **Upcoming feature:** Find a more reliable xkcd search API. 



### 3. Viewing comic details and explanation - Learn more about the comic

The comic detail page shows the full comic image, title, ID, release date, favorite button, alt text, and explanation link.

<img src="https://user-images.githubusercontent.com/5316319/143377252-97194422-bbc2-4a42-9f35-2cbe665aec49.png" width="300" >



The full comic image is displayed on the details page. Some comic aspect ratios are difficult to view on mobile, so I've added the ability to zoom. The alt text is displayed above the comic. The user can tap the Safari icon to view the Explain xkcd wiki page. The user can also tap the favorite button to add to their favorite comics.

* **Upcoming feature:** Additional research is required to know if the user perfers a button to display the alt text.
* **Upcoming feature:** Testing is required to know if explanation link should be displayed as text instead of the Safari icon.





### 4. Favorite comics - View favorite comics

Favorite comics are displayed online and offline.
| home page | detail page |
----|---- 
| <img src="https://user-images.githubusercontent.com/5316319/143377894-8854e9ce-eeb9-450f-882c-2bfe1b27ec5f.png" width="200" > | <img src="https://user-images.githubusercontent.com/5316319/143378112-ea51118e-b6f0-4cde-a3ae-b3660c31c5b0.png" width="200" > |



The user's favorite comics are displayed by tapping the Favorites icon on the home page. The table view of favorite comics is available online and offline. When the user favorites a comic, that comic image and details are saved to the UserDefaults.



### 5. Sending comics - Share comic with a friend


The user can share or copy the URL of the Explain xkcd wiki page.

 <img src="https://user-images.githubusercontent.com/5316319/143378153-d437874c-c597-4bda-abbd-dac8c9a5cf5c.png" width="300" > 

Tapping the Share icon will display the UIActivityViewController. This will allow the user to share the URL of the Explain xkcd wiki page. This seems like the best placement for sharing since you are viewing the webpage.

* **Upcoming feature:** Allow sharing of the xkcd comic page, not only the Explain xkcd wiki page.



### 6. Supporting multiple form factors - View the app on any iPhone device

The app supports all iPhone sizes in portrait. I tested the different form factors in the simulator. 


## TECHNICAL POINTS

Here are some technical points I'd like to share.



### Swift 5 async/await

I used the async/await feature for asynchronous functions. This is a new Swift 5 feature that I've never tried before.



### NSCache

I used NSCache for reusing images in `NetworkManager`. 



### protocols and extension

I used protocols as composable extensions. For example, to use the `ErrorDialogViewController` function in a limited UIViewController.



### Unit testing

I wrote unit tests for asynchronous functions. For example, I used `MockURLProtocol` to test without a server (see `xkcd_iOSNetworkManagerTests`) and test UserDefaults with Dependency Injection (see `xkcd_iOSFavoriteManagerTests`).

### Project architecture

I used MVVM architecture.

### Project structure

 <img src="https://user-images.githubusercontent.com/5316319/143379129-85ab571f-b6c9-4b1a-9990-ea665c889101.png" width="400" > 

## FEATURES OMITTED FROM MVP

The features that aren't included in the MVP.



### Push notifications - Notify when a new comic is released

This feature is non-trivial because I need to find a service for the push notifications. I omitted this feature from the MVP because of the limited development time.



### Fancy design

I've created a simple layout with no colors, branding, or themes. I wanted to focus on the functionality and unit tests, so I didn't worry about a fancy UI. 



### UI testing

I focused on unit testing over UI testing because I know the UI will likely change from client and user feedback. 



