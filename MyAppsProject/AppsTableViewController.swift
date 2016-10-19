//
//  AppsTableViewController.swift
//  MyAppsProject
//
//  Created by Guti on 10/14/16.
//  Copyright © 2016 PielDeJaguar. All rights reserved.
//

import UIKit

class AppsTableViewController: UITableViewController {
    
    // MARK: - Variables
    var apps = [AppModel]()
    var appleAppsURL = "https://itunes.apple.com/us/rss/topfreeapplications/limit=10/json"
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fetchData = FetchDataDelegate()
                
        fetchData.callback = { apps in
            self.apps = apps
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        
        }
        
        fetchData.getAppData()
        
        
        
        
        
        
        
        // TODO: - Reload table data
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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

        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if "detailViewSegue" == segue.identifier {
            let detailDestination = segue.destination as! DetailViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                detailDestination.app = apps[indexPath.row]
                
            }
        }

    }
    

}
