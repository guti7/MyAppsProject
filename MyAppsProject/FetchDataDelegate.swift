//
//  FetchDataDelegate.swift
//  MyAppsProject
//
//  Created by Guti on 10/14/16.
//  Copyright © 2016 PielDeJaguar. All rights reserved.
//

import Foundation

class FetchDataDelegate {
    
    var appsURL = "https://itunes.apple.com/us/rss/topfreeapplications/limit=30/json"
    var apps: [AppModel]?
    var wishList = [AppModel]()
    
    var callback: ((Any, [AppModel]) -> ())? // optional
    
    
    func getAppData() {
        
        let request = URLRequest(url: URL(string: appsURL)!)
        
        let urlSession = URLSession.shared
        
        let task = urlSession.dataTask(with: request, completionHandler: { (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            
            // Parse JSON Data
            if let data = data {
                self.apps = self.parseJSONData(data: data)
                
                // TODO: - Where to reload data? in view controller?
                if let callback = self.callback {
                    if let apps = self.apps{
                        callback(self, apps)
                        
                    }
                   
                }
            }
            
        })
        
        task.resume()
    }
    
    
    
    
    func parseJSONData(data: Data) -> [AppModel] {
        
        var appsArray = [AppModel]()
        
        do {
            
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
            
            // Parse the result
            let jsonFeed = jsonResult?["feed"] as! NSDictionary
            let jsonEntry = jsonFeed["entry"] as! [AnyObject]
            
            
            for jsonApp in jsonEntry {
                let app = AppModel()
                
                // title
                let title = jsonApp["im:name"] as! NSDictionary
                app.title = (title["label"] as! String)
                
                // category
                let category = jsonApp["category"] as! NSDictionary
                let categoryAttbs = category["attributes"] as! NSDictionary
                app.genre = (categoryAttbs["label"] as! String)
                
                // Release date
                let date = jsonApp["im:releaseDate"] as! NSDictionary
                let dateAttbs = date["attributes"] as! NSDictionary
                app.releaseDate = (dateAttbs["label"] as! String)
                
                appsArray.append(app)
                
                // image url
                let images = jsonApp["im:image"] as! NSArray
                let image100x100 = images[2] as! NSDictionary
                app.appImageURLString = (image100x100["label"] as! String)
                
            }
            
        } catch {
            print(error)
        }
        
        return appsArray
    }
}
