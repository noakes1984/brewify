# brewify
Template for breweries to create an app with features that pull menu and beerlist in real time.  It also utilizes the BreweryDB.com API for beer searches while linking to both twitter and facebook api's.

('ViewController'):
-First View utitlizes the BreweryDB.com API making breweries and beers searchable by using the SearchDisplayController.  The Search bar even squashes and strips whitespace for cleaner searches.  Also has code for ParseUI to setup userbase that will also link to user's current FB and Twitter accounts.

('MenuViewController'):
-Second View pulls from parse.com Mongo Rocks Database for menu lists and details in real time.

('BeerListController'):
-Third View pulls from parse.com as well for Beer lists with details.

('SettingsViewController'):
-Pulls user information from parse.com.



**Left to do**
-Give user the ability to add favorites from "ViewController", "MenueViewController" & "BeerListController" to  "SettingsViewController".

-Send the user the a push notification when favorite beer is back on available on beerlist.
