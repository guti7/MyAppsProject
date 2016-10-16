//
//  FetchDataDelegate.swift
//  MyAppsProject
//
//  Created by Guti on 10/14/16.
//  Copyright © 2016 PielDeJaguar. All rights reserved.
//

import Foundation

class FetchDataDelegate {
    
    var url = "https://itunes.apple.com/us/rss/topfreeapplications/limit=10/json"
    
    var parsedAppData: [AppModel]?
    
//    var urlSession: URLSession?
    
    
    func getAppData() -> [AppModel]? {
        
        let request = URLRequest(url: URL(string: url)!)
        
        let urlSession = URLSession.shared
        
        let task = urlSession.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            if let error = error {
                print(error)
                return
            }
            
            // Parse JSON Data
            if let data = data {
                self.parsedAppData = self.parseJSONData(data: data)
            }
            
            
        })
        
        
        task.resume()
    }
    
    func parseJSONData(data: Data) -> [AppModel] {
        
        var apps = [AppModel]()
        
        do {
            
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
            
            // Parse
            let jsonFeed = jsonResult?["feed"] as! NSDictionary
            let jsonAuthor = jsonFeed["author"] as! NSDictionary
            let jsonName = jsonAuthor["name"] as! NSDictionary
            
            let jsonApps = jsonName["entry"] as! [AnyObject]
            
            for jsonApp in jsonApps {
                let app = AppModel()
                
                let title = jsonApp["title"] as! [String:AnyObject]
                app.title = title["label"] as! String
//                app.genre = jsonApp["genre"][ as! String
//                app.releaseDate = jsonApp["releaseDate"] as! String
//                app.appImageURLString = jsonApp[']
            }
            
            
            
        } catch {
            print(error)
        }
        
        return apps
    }
    
    
    
}
