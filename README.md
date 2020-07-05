# JSONPlaceholder

![](https://api.travis-ci.org/gavinalt/JSONPlaceholder.svg?branch=travis-ci)

A Simple iOS App with Unit Tests that Demonstrates JSON Parsing and MVVM Pattern.

## Table of Contents:
1. Features
2. Possible Improments
3. Important Notes

## 1. Features:
* This app downloads JSON data online and parses it to display a list of users, albums, and photos.
* This app complys with the MVVM Design Pattern, with seperate view models for users, albums, and photos.
* There are four screens built in this application:
  1. Main Screen: On this screen, you can type in the searchbar and search for users based on their name or username or email.
  2. Albums Screen: Type on one of the users in the table of the Main Screen will bring you to this Screen. This screen displays a list of albums belong to that user.
  3. Photos Screen: Type on one of the albums in the Albums Screen will bring you here. This screen displays a list of photos in the album you typed on.
  4. Webview Screen: Type on one of the photos in the Photos Screen will bring you here. This screen shows the high quality version of the same photo you typed.
* On the backend, this application uses URLSession to deal with all the network tasks and promptly caches the photos downloaded. It uses JSON decoder to parse the JSON data downloaded online.

## 2. Possible Improments:
* Add to the Main Screen a search result indicator which tells the user 'No Result Found' if the user's search yields nothing. 

## 3. Important Notes:
* All the JSON data are downloaded from [JSONPlaceholder](https://jsonplaceholder.typicode.com)
