//
//  AppDelegate.swift
//  MovieApp
//
//  Created by Aashish Tyagi on 9/8/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication,
                     didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}


/* ---------------------------------------------------- ----------------------------------------------------
 1. App Flow management
 2. Search suggestion feature.
 3. Loading indicator
 4. Skelonton Loading view
 5. Custom cache >  Remove Kingfisher library.
 6. Open Detail screen as present viewController
 7. placeholder image for ImageView
 8. Error handling
 9. Show loading state
 10. Implement pre-fetch feature for better user experience.
 11. Full ImageViewer  with pitch to zoom feature (should be work on detail screen image)
 12. Replace cocopods with SPM
 13. Networking should be used as independent Package/Module.
 14. Design can be break in Multiple StoryBoard as per requirement.
 15. Use Composition technique
 16. Remove direct coupling of viewModel from controller by DI.
 
// Unit Test cases ---------------------------------------------------- --------------------------------------

 ##-MovieList Screen :
    1. Empty tableview
    2. DataSource/Delegete should be set
    3. Intial controller should be MovieList
    5. Load three section on successfully data receiving
    6. Check pull to refresh is implemented.
    7. Check pull to refresh is working fine and re-load table listing
    8. Movielist title should be set
    9. On Item selection, Should be move to another screen. (or Detail Screen)
    
## - Movie Detail Screen
     1. Title should be set
     2. Description should be multiline
     3. Full screen image feature should be work
     
## -  Search Screen
    1. Search Textfield should have placeholder
    2. Search Textfield should be empty on loading
    3. Search feature should be work with debouce or with milli second delay
    4. intial table will be empty
    5. Delagete/DataSource should be set
    6. On Item Selection, Should be move to another screen (or Detail Screen)
    7. No-Record found label on table background view when no result get from Search API.
    TO BE CONTINUE .....
*/

















/* -- Git Configuration in Xcode tools
 Generate private token firstly
 git error Solution
 sudo chown -R "$USER" ~/.config
 */
