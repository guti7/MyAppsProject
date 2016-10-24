//
//  DetailViewController.swift
//  MyAppsProject
//
//  Created by Guti on 10/17/16.
//  Copyright © 2016 PielDeJaguar. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var app: AppModel?
    var imageURL: String?
    var appManager: FetchDataDelegate? = nil
    
    // MARK: -IBOutlets
    
    @IBOutlet weak var appTitleLabel: UILabel!
    
    @IBOutlet weak var genreLabel: UILabel!
    
    @IBOutlet weak var releaseDateLabel: UILabel!

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var addToWishListButton: UIButton!
    
    
    
    // MARK: -IBActions
    
    @IBAction func addToWishListButton(_ sender: UIButton) {
        
        
        if (sender.titleLabel?.text?.contains("Add"))! {
            if let manager = appManager {
                manager.wishList.append(self.app!)
                sender.setTitle("Remove from wish list", for: .normal)
                print("added to wishlist")
                print(manager.wishList)
            } else {
                print("Error")
            }
        } else {
            // Remove from list
        }
        
        
        
        
    }
    
    @IBAction func markAsDownloadedButton(_ sender: AnyObject) {
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appTitleLabel.text = app!.title
        genreLabel.text = app!.genre
        releaseDateLabel.text = app!.releaseDate
        imageURL = app!.appImageURLString
        
        
        loadImage(urlString: imageURL!)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    
    func loadImage(urlString: String) {
        let imgURL = URL(string: urlString)
        let request = URLRequest(url: imgURL!)
        let urlSession = URLSession.shared
        let task = urlSession.dataTask(with: request, completionHandler: { (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            if let data = data {
                self.imageView.image = UIImage(data: data)
            }
            
        })
        
        
        task.resume()
    }
    
//    func loadPoster(urlString: String) {
//        imageView.af_setImageWithURL(NSURL(string: urlString)!, placeholderImage: nil, filter: nil, progress: nil, progressQueue: dispatch_get_main_queue(), imageTransition: .None, runImageTransitionIfCached: false) { (response: Response<UIImage, NSError>) in
//            switch response.result {
//            case .Success:
//                if let value = response.result.value {
//                    self.backgroundView.image = value
//                    self.randomMovie.movieImage = value
//                }
//            case .Failure(let error):
//                print(error)
//            }
//        }
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
