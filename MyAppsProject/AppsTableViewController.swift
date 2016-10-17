//
//  AppsTableViewController.swift
//  MyAppsProject
//
//  Created by Guti on 10/14/16.
//  Copyright © 2016 PielDeJaguar. All rights reserved.
//

import UIKit

class AppsTableViewController: UITableViewController {
    
    
    var apps = [AppModel]()
    
    var appleAppsURL = "https://itunes.apple.com/us/rss/topfreeapplications/limit=10/json"
    
    func getLatestApps() {
        let request = URLRequest(url: URL(string: appleAppsURL)!)
        let urlSession = URLSession.shared
        
        let task = urlSession.dataTask(with: request, completionHandler: {
            (data, response, error) -> Void in
            if let error = error {
                print(error)
                return
            }
            
            if let data = data {
                self.apps = self.parseJsonData(data)
                
                OperationQueue.main.addOperation({ () -> Void in
                    self.tableView.reloadData()
                })
            }
        })
        
        task.resume()
        
    }
    
    func parseJsonData(_ data: Data) -> [AppModel] {
        
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
                app.title = title["label"] as! String
                
                // category
                let category = jsonApp["category"] as! NSDictionary
                let categoryAttbs = category["attributes"] as! NSDictionary
                app.genre = categoryAttbs["label"] as! String
                
                // Release date
                let date = jsonApp["im:releaseDate"] as! NSDictionary
                let dateAttbs = date["attributes"] as! NSDictionary
                app.releaseDate = dateAttbs["label"] as! String
                
                appsArray.append(app)
                
                // image url
                let images = jsonApp["im:image"] as! NSArray
                let image100x100 = images[2] as! NSDictionary
                app.appImageURLString = image100x100["label"] as! String
                
            }
            
        } catch {
            print(error)
        }
        
        
        return appsArray
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getLatestApps()
        print(apps)
        // TODO: - Reload table data

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return apps.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "appCell", for: indexPath) as! AppTableViewCell

        cell.titleLabel.text = apps[indexPath.row].title
        cell.genreLabel.text = apps[indexPath.row].genre
        cell.releaseDateLabel.text = apps[indexPath.row].releaseDate
        
        print("the image url: \(apps[indexPath.row].appImageURLString)")

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
